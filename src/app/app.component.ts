import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'Angular Demo App';

  someMethod() {
    // Simple method for testing purposes
    const message = 'Method executed';
    return message;
  }

  getAngularVersion(): string {
    return '16.x';
  }
}
