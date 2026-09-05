package com.todo.list;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/task")
@RequiredArgsConstructor
@CrossOrigin(origins = "*")
class TaskController {

    private final TaskService taskService;

    @PostMapping
    public Task save(@RequestBody Task task) {
        return taskService.save(task);
    }

    @PutMapping("/{id}")
    public Task update(@PathVariable UUID id, @RequestBody Task task) {
        return taskService.update(id, task);
    }

    @GetMapping("/all")
    public List<Task> getAll() {
        return taskService.findAll();
    }

    @GetMapping("/{id}")
    public Task get(@PathVariable UUID id) {
        return taskService.findById(id);
    }

    @GetMapping("/name/{name}")
    public Task getByName(@PathVariable String name) {
        return taskService.findByName(name);
    }
    @DeleteMapping("/{id}")
    public void delete(@PathVariable UUID id) {
         taskService.deleteById(id);
    }

}
