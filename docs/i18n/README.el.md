# Tailnet Link

[![CI](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml/badge.svg)](https://github.com/Azazel-Labs/tailnet-link/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/Azazel-Labs/tailnet-link)](https://github.com/Azazel-Labs/tailnet-link/releases)
[![License: MIT-0](https://img.shields.io/badge/license-MIT--0-blue.svg)](../../LICENSE)
[![Rust: 1.95+](https://img.shields.io/badge/rust-1.95%2B-orange.svg)](../../Cargo.toml)
[![Edition: 2024](https://img.shields.io/badge/edition-2024-orange.svg)](../../Cargo.toml)
[![Platforms](https://img.shields.io/badge/platforms-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)](../../README.md#download)

[English](../../README.md) · [Afrikaans](README.af.md) · [Català](README.ca.md) · [Čeština](README.cs.md) · [Dansk](README.da.md) · [Deutsch](README.de.md) · Ελληνικά · [Español (Latinoamérica)](README.es-419.md) · [Español (España)](README.es-ES.md) · [Suomi](README.fi.md) · [Français](README.fr.md) · [Magyar](README.hu.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Norsk bokmål](README.nb.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português (Brasil)](README.pt-BR.md) · [Português (Portugal)](README.pt-PT.md) · [Română](README.ro.md) · [Русский](README.ru.md) · [Српски](README.sr-Cyrl.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [简体中文](README.zh-Hans.md) · [繁體中文](README.zh-Hant.md)

![Tailnet Link](../images/hero.svg)

**Μείνετε στο δικό σας tailnet. Φτάστε σε μηχανήματα σε κάθε άλλο, ταυτόχρονα.**

Το Tailscale σάς επιτρέπει να είστε συνδεδεμένοι σε ένα μόνο tailnet κάθε φορά. Αν το οικιακό σας εργαστήριο, η εταιρεία σας και ένας πελάτης έχουν το καθένα το δικό του, αλλάζετε συνεχώς λογαριασμούς και ό,τι ήταν συνδεδεμένο διακόπτεται. Το Tailnet Link βάζει τέλος σε αυτό. Η εφαρμογή Tailscale μένει ακριβώς όπως είναι και το Tailnet Link προσθέτει αθόρυβα τα υπόλοιπα tailnet δίπλα της, έτσι ώστε και το `https://wiki.comet-bebop.ts.net/` και το `build-pc.capybara-iguana.ts.net` απλώς να ανοίγουν.

**[Κατεβάστε την πιο πρόσφατη έκδοση](https://github.com/Azazel-Labs/tailnet-link/releases/latest)** για Windows, macOS ή Linux. Είναι δωρεάν και ανοιχτού κώδικα.

![Η καρτέλα Tailnet με δύο tailnet σε δρομολόγηση και τα μηχανήματά τους](../images/tailnets.png)

*Τα στιγμιότυπα οθόνης χρησιμοποιούν φανταστικά tailnet· κάθε όνομα και διεύθυνση σε αυτά είναι επινοημένα.*

## Γιατί Tailnet Link

- **Τέλος οι εναλλαγές λογαριασμών.** Προσθέστε όσα tailnet χρειάζεστε και χρησιμοποιήστε τα όλα μαζί. Το δικό σας tailnet δεν αποσυνδέεται ποτέ.
- **Τίποτα για ρύθμιση.** Συνδεθείτε και ο τομέας του tailnet εντοπίζεται για εσάς. Ανοίξτε τα μηχανήματά του με το όνομά τους σε οποιοδήποτε πρόγραμμα περιήγησης.
- **Βρίσκει τους ιστότοπους στα μηχανήματά σας.** Τα μηχανήματα που εξυπηρετούν μια σελίδα HTTPS εμφανίζονται ως πλακίδια με το όνομα και το εικονίδιο της σελίδας, ένα κλικ μακριά. Κάθε μηχάνημα ελέγχεται το πολύ μία φορά την ημέρα.
- **Δεν συγκρούεται με το Tailscale.** Χωρίς προσαρμογέα VPN, χωρίς διαδρομές, χωρίς αλλαγές στο DNS. Κάθε επιπλέον tailnet εκτελείται ως ξεχωριστός κόμβος μέσα στην εφαρμογή, οπότε τίποτα δεν συγκρούεται με την εφαρμογή Tailscale ή μεταξύ τους.
- **Κλειδωμένο από προεπιλογή.** Κάθε επιπλέον κόμβος συνδέεται με «shields up»: εσείς έχετε πρόσβαση σε αυτά τα tailnet, αλλά τίποτα από αυτά δεν έχει πρόσβαση στον υπολογιστή σας.
- **Περνά μόνο η δική τους κίνηση.** Οι διευθύνσεις των άλλων tailnet σας περνούν από το Tailnet Link. Όλα τα υπόλοιπα πηγαίνουν απευθείας, ακριβώς όπως πριν.
- **Λειτουργεί με εφαρμογές που αγνοούν τον διακομιστή μεσολάβησης.** Η Απομακρυσμένη επιφάνεια εργασίας, το SSH και τα προγράμματα-πελάτες βάσεων δεδομένων αποκτούν με ένα κλικ μια τοπική θύρα που οδηγεί στο μηχάνημα.
- **Καθαρίζει πίσω του.** Η ρύθμιση διακομιστή μεσολάβησης του συστήματος είναι ενεργή μόνο όσο κάτι δρομολογείται και επαναφέρεται στην έξοδο, την παύση, την κατάρρευση ή τη διακοπή ρεύματος.
- **Μιλά τη γλώσσα σας.** Η διεπαφή είναι μεταφρασμένη σε 31 γλώσσες.

## Πώς λειτουργεί

1. **Προσθέστε ένα tailnet.** Η σελίδα σύνδεσης του ίδιου του Tailscale ανοίγει στο πρόγραμμα περιήγησης, όπως ακριβώς και με την εφαρμογή Tailscale.
2. **Ο τομέας του εντοπίζεται αυτόματα.** Μετά τη σύνδεση, το Tailnet Link διαβάζει το όνομα MagicDNS του tailnet (για παράδειγμα `capybara-iguana.ts.net`) και δρομολογεί το `*.capybara-iguana.ts.net` μέσω αυτού.
3. **Ανοίξτε τα μηχανήματά του.** Πληκτρολογήστε ένα όνομα στο πρόγραμμα περιήγησης ή επιλέξτε ένα μηχάνημα από τη λίστα για να το ανοίξετε, να αντιγράψετε τη διεύθυνσή του ή να προωθήσετε μια θύρα σε αυτό.

## Εφαρμογές που αγνοούν τον διακομιστή μεσολάβησης

Τα προγράμματα περιήγησης και τα περισσότερα εργαλεία ακολουθούν τη ρύθμιση διακομιστή μεσολάβησης του συστήματος. Η Απομακρυσμένη επιφάνεια εργασίας, τα προγράμματα-πελάτες βάσεων δεδομένων και παρόμοιες εφαρμογές όχι. Για αυτές, κάντε κλικ στο κουμπί με το βύσμα δίπλα σε ένα μηχάνημα και επιλέξτε θύρα: επιλέγεται και διατηρείται μια ελεύθερη τοπική θύρα και συνδέεστε στο `127.0.0.1:<port>`. Στα Windows, οι προωθήσεις Απομακρυσμένης επιφάνειας εργασίας έχουν δικό τους κουμπί **Άνοιγμα Απομακρυσμένης επιφάνειας εργασίας**.

![Το παράθυρο μετά την προώθηση της Απομακρυσμένης επιφάνειας εργασίας: μια τοπική διεύθυνση για αντιγραφή και ένα κουμπί για άνοιγμα της Απομακρυσμένης επιφάνειας εργασίας](../images/forward.png)

## Λήψη και πλατφόρμες

Το Tailnet Link λειτουργεί σε Windows, macOS και Linux (GNOME και KDE). Στην [πιο πρόσφατη έκδοση](https://github.com/Azazel-Labs/tailnet-link/releases/latest) θα βρείτε το πρόγραμμα εγκατάστασης για Windows `tailnet-link-windows-setup.exe`, το `tailnet-link-macos-universal.dmg` για Mac (Apple Silicon και Intel) και το `tailnet-link-linux-amd64.deb` για Ubuntu και Debian (`sudo apt install ./tailnet-link-linux-amd64.deb`).

**Χωρίς ψηφιακή υπογραφή κώδικα.** Στα Windows, στην προειδοποίηση του SmartScreen επιλέξτε **Περισσότερες πληροφορίες → Εκτέλεση οπωσδήποτε**. Στο macOS, την πρώτη φορά κάντε δεξί κλικ στην εφαρμογή και επιλέξτε **Άνοιγμα**.

## Περισσότερα

Όλες οι λεπτομέρειες (ρυθμίσεις, μενού, επαναφορά του διακομιστή μεσολάβησης, πρόγραμμα εγκατάστασης για Windows, τοποθεσίες αρχείων) βρίσκονται στο [αγγλικό README](../../README.md). Για βελτιώσεις της μετάφρασης, δείτε το [docs/translations.md](../../docs/translations.md).

Copyright © 2026 Azazel Labs LLC. Διατίθεται με άδεια [MIT-0](../../LICENSE). Το Tailnet Link δεν έχει δημιουργηθεί από την Tailscale Inc. ούτε σχετίζεται με αυτήν. Το Tailscale είναι εμπορικό σήμα της Tailscale Inc.
