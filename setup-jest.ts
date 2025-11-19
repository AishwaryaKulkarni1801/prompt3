// Minimal Jest setup file.
// Intentionally not importing `jest-preset-angular/setup-jest` here because
// certain versions of `jest-preset-angular` bundle do not expose that path.
// For direct-instantiation/unit tests (no TestBed) this minimal setup is
// sufficient. If you later use Angular TestBed heavily, we can adjust this
// to import the correct preset setup or add required polyfills.

// Example: add lightweight DOM API mocks here if needed by your components.
// (global as any).ResizeObserver = class {
//   observe() {}
//   unobserve() {}
//   disconnect() {}
// };

// Make a small global flag available to tests
(global as any).IS_JEST = true;

// Diagnostic output to help debug why tests report as zero tests.
// This will print during Jest setup phase.
try {
	// eslint-disable-next-line no-console
	console.log('=== setup-jest diagnostics ===', {
		describe: typeof (global as any).describe,
		it: typeof (global as any).it,
		test: typeof (global as any).test,
		expect: typeof (global as any).expect,
		jest: typeof (global as any).jest,
	});
} catch (e) {
	// ignore diagnostics failures
}
