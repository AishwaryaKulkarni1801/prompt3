import { AppComponent } from './app.component';

/**
 * Comprehensive Jest tests for AppComponent
 * - Follows direct-instantiation pattern from established analysis
 * - Uses jest spies/mocks (no TestBed)
 * - Exercises all lines in the component for full coverage
 */

describe('AppComponent (direct instantiation)', () => {
  let component: AppComponent;

  beforeEach(() => {
    component = new AppComponent();
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  it('should create the component instance', () => {
    expect(component).toBeDefined();
  });

  it("should initialize title to 'Angular Demo App'", () => {
    expect(component.title).toBe('Angular Demo App');
  });

  it('should return the Angular version string from getAngularVersion', () => {
    const v = component.getAngularVersion();
    expect(v).toBe('16.x');
  });

  it('should execute someMethod without throwing', () => {
    expect(() => {
      component.someMethod();
    }).not.toThrow();
  });

  it('should allow calling someMethod multiple times without throwing', () => {
    expect(() => {
      component.someMethod();
      component.someMethod();
    }).not.toThrow();
  });
});

