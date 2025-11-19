import { DemoComponent } from './demo.component';

/*
 * Tests follow the established pattern:
 * - Direct instantiation (no TestBed)
 * - Small factory helper to create instances
 * - Deterministic spies for Date
 * - Naming: 'should <action> when <condition>'
 */

describe('DemoComponent (direct instantiation)', () => {
  let component: DemoComponent;

  const createComponent = (): DemoComponent => new DemoComponent();

  beforeEach(() => {
    component = createComponent();
  });

  test('should initialize with expected default values when instantiated', () => {
    expect(component).toBeDefined();
    expect(component.title).toBe('Demo Component');
    expect(component.message).toBe('Welcome to the demo section!');
    expect(component.counter).toBe(0);
    expect(component.items).toEqual(['Item 1', 'Item 2', 'Item 3']);
    expect(component.newItem).toBe('');
    expect(component.showDetails).toBe(false);
  });

  test('should increment counter when increment() is called', () => {
    component.counter = 0;
    component.increment();
    expect(component.counter).toBe(1);
    component.increment();
    expect(component.counter).toBe(2);
  });

  test('should decrement counter when decrement() is called and allow negative values', () => {
    component.counter = 1;
    component.decrement();
    expect(component.counter).toBe(0);

    component.decrement();
    expect(component.counter).toBe(-1);
  });

  test('should reset counter to 0 when reset() is called', () => {
    component.counter = 42;
    component.reset();
    expect(component.counter).toBe(0);
  });

  describe('addItem()', () => {
    test('should add trimmed newItem and clear newItem when non-empty', () => {
      component.newItem = '   NewEntry   ';
      const before = component.items.length;
      component.addItem();
      expect(component.items.length).toBe(before + 1);
      expect(component.items[component.items.length - 1]).toBe('NewEntry');
      expect(component.newItem).toBe('');
    });

    test('should not add when newItem is only whitespace or empty', () => {
      component.newItem = '   ';
      const before = component.items.length;
      component.addItem();
      expect(component.items.length).toBe(before);

      component.newItem = '';
      component.addItem();
      expect(component.items.length).toBe(before);
    });

    test('should allow duplicate entries (no uniqueness enforcement)', () => {
      component.newItem = 'Item 1';
      const foundBefore = component.items.filter(i => i === 'Item 1').length;
      component.addItem();
      const foundAfter = component.items.filter(i => i === 'Item 1').length;
      expect(foundAfter).toBe(foundBefore + 1);
    });
  });

  describe('removeItem()', () => {
    test('should remove correct item when valid positive index passed', () => {
      component.items = ['A', 'B', 'C'];
      component.removeItem(1);
      expect(component.items).toEqual(['A', 'C']);
    });

    test('should do nothing when index is out of range (>= length)', () => {
      component.items = ['only'];
      component.removeItem(5);
      expect(component.items).toEqual(['only']);
    });

    test('should remove last item when negative index -1 is passed (splice behavior)', () => {
      component.items = ['X', 'Y', 'Z'];
      component.removeItem(-1);
      expect(component.items).toEqual(['X', 'Y']);
    });

    test('should handle negative index less than -length (removes from start per splice semantics)', () => {
      component.items = ['first', 'second', 'third'];
      // splice(-10,1) will compute start = max(len + (-10), 0) => 0
      component.removeItem(-10 as unknown as number);
      // removes the first element
      expect(component.items).toEqual(['second', 'third']);
    });
  });

  test('should toggle showDetails when toggleDetails() is called', () => {
    expect(component.showDetails).toBe(false);
    component.toggleDetails();
    expect(component.showDetails).toBe(true);
    component.toggleDetails();
    expect(component.showDetails).toBe(false);
  });

  test('getCurrentTime() returns value from Date.toLocaleTimeString()', () => {
    const spy = jest.spyOn(Date.prototype, 'toLocaleTimeString').mockReturnValue('12:34:56');
    const time = component.getCurrentTime();
    expect(time).toBe('12:34:56');
    spy.mockRestore();
  });

  test('multiple operations keep items and counter consistent', () => {
    component.items = ['one', 'two'];
    component.newItem = ' three ';
    component.addItem(); // adds 'three'
    component.increment();
    component.removeItem(0); // remove 'one'
    component.toggleDetails();

    expect(component.items).toEqual(['two', 'three']);
    expect(component.counter).toBe(1);
    expect(component.showDetails).toBe(true);
  });

  test('calling methods repeatedly remains stable and does not throw on empty arrays', () => {
    component.items = [];
    // add multiple items: newItem is cleared by addItem(), so set it before each add
    component.newItem = 'a';
    component.addItem();
    component.newItem = 'b';
    component.addItem();
    component.newItem = 'c';
    component.addItem();
    expect(component.items.length).toBe(3);

    component.removeItem(0);
    component.removeItem(0);
    component.removeItem(0);
    expect(component.items.length).toBe(0);

    // removing from empty array should not throw
    expect(() => component.removeItem(0)).not.toThrow();
  });
});
