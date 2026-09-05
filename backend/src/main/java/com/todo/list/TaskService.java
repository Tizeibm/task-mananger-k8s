package com.todo.list;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.management.RuntimeErrorException;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
class TaskService {

    private final TaskRepository taskRepository;

    public Task save(Task task) {

        return taskRepository.save(task);
    }
    public Task update(UUID id,Task task) {
        Task currentTask = taskRepository.findById(id).orElseThrow();
        currentTask.setName(task.getName());
        currentTask.setDescription(task.getDescription());
        currentTask.setEndTime(task.getEndTime());
        currentTask.setStartTime(task.getStartTime());
        return taskRepository.save(currentTask);
    }
    public List<Task> findAll() {
        return taskRepository.findAll();
    }
    public Task findByName(String name) {
        return taskRepository.findByName(name);
    }
    public Task findById(UUID id) {
        return taskRepository.findById(id).orElseThrow();
    }
    public void deleteById(UUID id) {
        Task currentTask = taskRepository.findById(id).orElseThrow();
        taskRepository.delete(currentTask);
    }


}
