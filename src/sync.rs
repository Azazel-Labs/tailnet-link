//! Synchronisation helpers.
use std::sync::{Mutex, MutexGuard, PoisonError};

/// Lock a mutex, recovering from poisoning (a panicked thread must not take
/// the whole app down with it).
pub fn lock<T>(m: &Mutex<T>) -> MutexGuard<'_, T> {
    m.lock().unwrap_or_else(PoisonError::into_inner)
}
