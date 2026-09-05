import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TaskService } from '../../services/task.service';
import { Task } from '../../models/task.model';

@Component({
  selector: 'app-task-dashboard',
  standalone: true,
  imports: [CommonModule, FormsModule], // FormsModule requis pour les inputs
  templateUrl: './task-dashboard.component.html'
})
export class TaskDashboardComponent implements OnInit {
  private taskService = inject(TaskService);
  
  tasks: Task[] = [];
  newTask: Task = { name: '', description: '', startTime: '', endTime: '' };

  ngOnInit() {
    this.loadTasks();
  }

  loadTasks() {
    this.taskService.getTasks().subscribe({
      next: (data) => this.tasks = data,
      error: (err) => console.error('Erreur API (K8s Service injoignable?)', err)
    });
  }

  addTask() {
    if (!this.newTask.name) return;
    this.taskService.createTask(this.newTask).subscribe(() => {
      this.loadTasks(); // Recharge la liste
      this.newTask = { name: '', description: '', startTime: '', endTime: '' }; // Reset
    });
  }

  deleteTask(id: string) {
    if(confirm('Supprimer cette tâche ?')) {
      this.taskService.deleteTask(id).subscribe(() => this.loadTasks());
    }
  }
}