// Minimal @angular/core mock for direct-instantiation unit tests.
// This mock provides a no-op Component decorator and basic symbols used by
// simple components in this repo. It is intentionally minimal — for TestBed
// based tests you should use the real @angular/core and proper preset.

function Component(meta) {
  return function (target) {
    // attach metadata as static property for tests if needed
    target.__annotations = meta || {};
    return target;
  };
}

function Injectable() {
  return function (target) { return target; };
}

class EventEmitter {
  constructor() { this.listeners = []; }
  emit(v) { this.listeners.forEach(l => l(v)); }
  subscribe(l) { this.listeners.push(l); return { unsubscribe: () => {} }; }
}

module.exports = {
  Component,
  Injectable,
  EventEmitter,
  // common Angular exports as no-ops
  Input: () => (t, k) => {},
  Output: () => (t, k) => {},
  NgModule: () => (t) => t,
};
