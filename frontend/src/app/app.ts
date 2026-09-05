import { Component } from '@angular/core';
import { TaskDashboardComponent } from './features/tasks/components/task-dashboard/task-dashboard.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [TaskDashboardComponent],
  template: `<app-task-dashboard></app-task-dashboard>`
})
export class App {}
