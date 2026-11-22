; Windows installer for Tailnet Link (NSIS 3).
; Built by packaging/windows/build-installer.sh, which passes:
;   /DVERSION=v1.2.3   /DVERSION_NUM=1.2.3.0   /DDIST=<folder with tailnet-link.exe, tailnet-link.ico, LICENSE.txt>   /DOUTFILE=<setup.exe>
;
; - Installs for all users in Program Files (needs admin once).
;   Runs on x64 and ARM64 Windows (ARM64 runs the x64 build via emulation).
; - Adds a Windows Firewall rule for the app only (direct peer-to-peer
;   connections, no "allow access" pop-up).
; - Start-menu shortcut, optional desktop shortcut, optional start at login.
; - Upgrades in place: stops the running copy, keeps logins and settings.
; - Uninstall: stops the app, puts the proxy setting back, removes the
;   firewall rule, login item and shortcuts; asks before deleting logins.

Unicode true
ManifestDPIAware true
RequestExecutionLevel admin
SetCompressor /SOLID lzma

!ifndef VERSION
  !define VERSION "dev"
!endif
!ifndef VERSION_NUM
  !define VERSION_NUM "0.0.0.0"
!endif
!ifndef DIST
  !define DIST "..\dist"
!endif
!ifndef OUTFILE
  !define OUTFILE "${DIST}\tailnet-link-windows-setup.exe"
!endif

!define APP        "Tailnet Link"
!define EXE        "tailnet-link.exe"
!define LEGACY_EXE "tailnet-proxy.exe"
!define ICO        "tailnet-link.ico"
!define PUBLISHER  "Azazel Labs LLC"
!define URL        "https://github.com/Azazel-Labs/tailnet-link"
!define UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP}"
!define RUN_KEY    "Software\Microsoft\Windows\CurrentVersion\Run"
!define RUNONCE_KEY "Software\Microsoft\Windows\CurrentVersion\RunOnce"
!define FW_RULE    "Tailnet Link"

Name "${APP}"
OutFile "${OUTFILE}"
InstallDir "$PROGRAMFILES64\${APP}"
InstallDirRegKey HKLM "${UNINST_KEY}" "InstallLocation"
BrandingText "${APP} ${VERSION}"

VIProductVersion "${VERSION_NUM}"
VIAddVersionKey "ProductName" "${APP}"
VIAddVersionKey "FileDescription" "${APP} installer"
VIAddVersionKey "ProductVersion" "${VERSION}"
VIAddVersionKey "FileVersion" "${VERSION_NUM}"
VIAddVersionKey "CompanyName" "${PUBLISHER}"
VIAddVersionKey "LegalCopyright" "Copyright © 2026 ${PUBLISHER}"

!include "MUI2.nsh"
!include "x64.nsh"
!include "LogicLib.nsh"

!define MUI_ICON   "${DIST}\${ICO}"
!define MUI_UNICON "${DIST}\${ICO}"
!define MUI_ABORTWARNING
!define MUI_WELCOMEPAGE_TEXT "This installs ${APP} ${VERSION}.$\r$\n$\r$\nIt lets you reach machines on other tailnets while staying on your own, from a tray icon. Your normal Tailscale app isn't changed.$\r$\n$\r$\nIf ${APP} is running, it will be closed and restarted. Your logins and settings are kept."
!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Start ${APP} now"
!define MUI_FINISHPAGE_RUN_FUNCTION LaunchAsUser

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

; ---------------------------------------------------------------------------

Function .onInit
  ${IfNot} ${RunningX64}
  ${AndIfNot} ${IsNativeARM64}
    MessageBox MB_ICONSTOP "${APP} needs 64-bit Windows (x64 or ARM64)."
    Abort
  ${EndIf}
  SetRegView 64
FunctionEnd

Function un.onInit
  SetRegView 64
FunctionEnd

; Stop every running copy (the app and its hidden watchdog), then put the
; proxy setting back if they had it on. Used before upgrading and uninstalling.
; Also stops the app under its earlier name: while tailnet-proxy runs, its
; settings and logins can't be moved, and its proxy setting stays in the way.
!macro StopApp
  nsExec::Exec 'taskkill /F /T /IM "${EXE}"'
  Pop $0
  nsExec::Exec 'taskkill /F /T /IM "${LEGACY_EXE}"'
  Pop $0
  Sleep 800
  ${If} ${FileExists} "$INSTDIR\${EXE}"
    nsExec::Exec '"$INSTDIR\${EXE}" -cleanup'
    Pop $0
  ${EndIf}
!macroend

; The installer runs as admin; start the app as the normal user instead
; (Explorer launches it un-elevated).
Function LaunchAsUser
  Exec '"$WINDIR\explorer.exe" "$INSTDIR\${EXE}"'
FunctionEnd

; ---------------------------------------------------------------------------

Section "${APP} (required)" SecApp
  SectionIn RO
  SetOutPath "$INSTDIR"
  !insertmacro StopApp

  File "${DIST}\${EXE}"
  File "${DIST}\${ICO}"
  File "${DIST}\LICENSE.txt"
  WriteUninstaller "$INSTDIR\uninstall.exe"

  ; Start menu (all users)
  SetShellVarContext all
  CreateShortCut "$SMPROGRAMS\${APP}.lnk" "$INSTDIR\${EXE}" "" "$INSTDIR\${ICO}" 0
  SetShellVarContext current

  ; Add/Remove Programs
  WriteRegStr   HKLM "${UNINST_KEY}" "DisplayName"          "${APP}"
  WriteRegStr   HKLM "${UNINST_KEY}" "DisplayVersion"       "${VERSION}"
  WriteRegStr   HKLM "${UNINST_KEY}" "DisplayIcon"          "$INSTDIR\${ICO}"
  WriteRegStr   HKLM "${UNINST_KEY}" "InstallLocation"      "$INSTDIR"
  WriteRegStr   HKLM "${UNINST_KEY}" "Publisher"            "${PUBLISHER}"
  WriteRegStr   HKLM "${UNINST_KEY}" "URLInfoAbout"         "${URL}"
  WriteRegStr   HKLM "${UNINST_KEY}" "UninstallString"      '"$INSTDIR\uninstall.exe"'
  WriteRegStr   HKLM "${UNINST_KEY}" "QuietUninstallString" '"$INSTDIR\uninstall.exe" /S'
  WriteRegDWORD HKLM "${UNINST_KEY}" "NoModify" 1
  WriteRegDWORD HKLM "${UNINST_KEY}" "NoRepair" 1
  WriteRegDWORD HKLM "${UNINST_KEY}" "EstimatedSize" 30000
SectionEnd

Section "Windows Firewall rule (recommended)" SecFirewall
  ; Inbound UDP for this program only: lets the other tailnets connect
  ; directly instead of through Tailscale's relays, without a pop-up.
  nsExec::Exec 'netsh advfirewall firewall delete rule name="${FW_RULE}"'
  Pop $0
  nsExec::Exec 'netsh advfirewall firewall add rule name="${FW_RULE}" dir=in action=allow protocol=UDP program="$INSTDIR\${EXE}" enable=yes profile=any description="Tailnet Link: direct connections to other tailnets"'
  Pop $0
SectionEnd

Section "Start at login" SecAutostart
  ; Same entry the app's "Start at login" setting uses (starts quietly in the tray).
  WriteRegStr HKCU "${RUN_KEY}" "${APP}" '"$INSTDIR\${EXE}" --background'
SectionEnd

Section /o "Desktop shortcut" SecDesktop
  CreateShortCut "$DESKTOP\${APP}.lnk" "$INSTDIR\${EXE}" "" "$INSTDIR\${ICO}" 0
SectionEnd

Section "-silent restart"
  ; Silent installs (e.g. company rollout with /S) restart the app if it was set to start at login.
  ${If} ${Silent}
    ReadRegStr $0 HKCU "${RUN_KEY}" "${APP}"
    ${If} $0 != ""
      Call LaunchAsUser
    ${EndIf}
  ${EndIf}
SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecApp}       "The app itself."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecFirewall}  "Allow direct connections from your other tailnets (this program only), so traffic doesn't have to go through Tailscale's relays."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecAutostart} "Start ${APP} in the tray when you log in to Windows. You can change this later in its Settings."
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktop}   "Put a ${APP} shortcut on your desktop."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; ---------------------------------------------------------------------------

Section "Uninstall"
  !insertmacro StopApp

  ; Logins and settings belong to the user; ask before deleting (keep them on silent uninstall).
  ; Asked first, while the app is still here to sign each tailnet out: deleting a
  ; login without that leaves an abandoned machine in the tailnet, and the next
  ; install's machine gets "-1" added to its name.
  StrCpy $1 "keep"
  ${IfNot} ${Silent}
    MessageBox MB_YESNO|MB_ICONQUESTION "Also sign out of your tailnets and delete your ${APP} settings?$\r$\n$\r$\nThis computer is removed from each tailnet you added. Choose No to keep them for a later reinstall." IDNO keep_logins
      StrCpy $1 "delete"
      DetailPrint "Signing out of your tailnets..."
      nsExec::Exec '"$INSTDIR\${EXE}" --logout-all'
      Pop $0
    keep_logins:
  ${EndIf}

  nsExec::Exec 'netsh advfirewall firewall delete rule name="${FW_RULE}"'
  Pop $0

  DeleteRegValue HKCU "${RUN_KEY}" "${APP}"
  DeleteRegValue HKCU "${RUNONCE_KEY}" "${APP} cleanup"
  DeleteRegKey   HKCU "Software\${APP}"

  SetShellVarContext all
  Delete "$SMPROGRAMS\${APP}.lnk"
  SetShellVarContext current
  Delete "$DESKTOP\${APP}.lnk"

  Delete "$INSTDIR\${EXE}"
  Delete "$INSTDIR\${ICO}"
  Delete "$INSTDIR\LICENSE.txt"
  Delete "$INSTDIR\uninstall.exe"
  RMDir  "$INSTDIR"

  DeleteRegKey HKLM "${UNINST_KEY}"

  ${If} $1 == "delete"
    RMDir /r "$APPDATA\${APP}"
  ${EndIf}
SectionEnd
