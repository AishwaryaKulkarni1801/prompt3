/**
 * Jest configuration for Angular 16+ projects.
 * Key choices:
 * - Uses 'jest-preset-angular' to provide Angular test environment and transforms.
 * - setupFilesAfterEnv points to a project setup file where TestBed global setup lives.
 * - moduleNameMapper handles style/static asset imports commonly used in Angular projects.
 */
module.exports = {
  // Using ts-jest directly for TypeScript transformation. If you need
  // full Angular TestBed + template compilation support, we can install a
  // compatible version of jest-preset-angular and enable it later.
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/setup-jest.ts'],
  transform: {
    '^.+\\.(ts|js|html)$': ['ts-jest', {
      tsconfig: '<rootDir>/tsconfig.spec.json',
      stringifyContentPathRegex: '\\.(html)$'
    }]
  },
  moduleFileExtensions: ['ts', 'html', 'js', 'json'],
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '^src/(.*)$': '<rootDir>/src/$1',
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
    '\\.(jpg|jpeg|png|gif|webp|svg)$': '<rootDir>/test-setup/file-mock.js',
    '^@angular\\/core$': '<rootDir>/test-setup/angular-core-mock.js'
  },
  collectCoverage: false,
  coverageDirectory: '<rootDir>/coverage/',
  coverageReporters: ['html', 'text-summary'],
  testMatch: ['**/+(*.)+(spec|test).+(ts|js)'],
  globals: {
    'ts-jest': {
      tsconfig: '<rootDir>/tsconfig.spec.json',
      diagnostics: false
    }
  }
};
