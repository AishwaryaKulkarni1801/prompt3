import { Component } from '@angular/core';

// No unused placeholder variables remain.

@Component({
  selector: 'app-demo',
  templateUrl: './demo.component.html',
  styleUrls: ['./demo.component.scss']
})
export class DemoComponent {
  title = 'Demo Component';
  message = 'Welcome to the demo section!';
  counter = 0;
  items: string[] = ['Item 1', 'Item 2', 'Item 3'];
  newItem = '';
  showDetails = false;

  // Unused private variable (prefixed with underscore)
  private _unusedPrivateVar = 'unused';

  increment() {
    this.counter++;
  }

  decrement() {
    this.counter--;
  }

  reset() {
    this.counter = 0;
  }

  addItem() {
    if (this.newItem.trim()) {
      this.items.push(this.newItem.trim());
      this.newItem = '';
    }
  }

  removeItem(index: number) {
  this.items.splice(index, 1);
  }

  toggleDetails() {
  this.showDetails = !this.showDetails;
  }

  getCurrentTime(): string {
    return new Date().toLocaleTimeString();
  }
}
