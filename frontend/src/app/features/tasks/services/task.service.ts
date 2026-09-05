import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../../environments/environment';
import { Task } from '../models/task.model';

@Injectable({ providedIn: 'root' })
export class TaskService {
  // environment.apiUrl pointera vers l'URL du Service Kubernetes ou l'ALB AWS
  private apiUrl = `${environment.apiUrl}/task`; 

  constructor(private http: HttpClient) {}

  getTasks() { return this.http.get<Task[]>(`${this.apiUrl}/all`); }
  createTask(task: Task) { return this.http.post<Task>(this.apiUrl, task); }
  deleteTask(id: string) { return this.http.delete(`${this.apiUrl}/${id}`); }
}