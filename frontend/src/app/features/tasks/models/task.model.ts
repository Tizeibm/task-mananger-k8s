export interface Task {
  id?: string;
  name: string;
  description: string;
  startTime: string; // Utilisé comme format HH:mm
  endTime: string;
}