import 'package:flutter/material.dart';
// import '../../../../core/models/task.dart';
// import '../../../../core/services/id_generator.dart';
// import '../../domain/task_usecases.dart';

/// Page with form for creating new tasks.
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  
  // Form field controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  // Form values
  int _priority = 2; // Default to medium
  DateTime? _deadline;
  int? _estimatedTime;
  String? _category;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        actions: [
          // Save button
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveTask,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter task title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Description field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  hintText: 'Enter task description',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              
              // TODO: Add priority selector (dropdown or segmented buttons)
              Text('Priority: $_priority', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              
              // TODO: Add deadline picker
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(_deadline == null 
                    ? 'Set deadline' 
                    : 'Deadline: ${_deadline!.toString()}'),
                onTap: _pickDeadline,
              ),
              const SizedBox(height: 16),
              
              // TODO: Add estimated time picker
              // TODO: Add category selector/input
              
              const SizedBox(height: 32),
              
              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTask,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Create Task'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDeadline() async {
    // TODO: Show date and time picker
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (date != null) {
      // TODO: Also pick time
      setState(() {
        _deadline = date;
      });
    }
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    // TODO: Create Task object with IdGenerator
    // TODO: Call TaskUseCases.repository.createTask()
    // TODO: Navigate back to task list
    
    // final task = Task(
    //   id: IdGenerator.generate(),
    //   title: _titleController.text,
    //   description: _descriptionController.text.isEmpty 
    //       ? null 
    //       : _descriptionController.text,
    //   createdAt: DateTime.now(),
    //   updatedAt: DateTime.now(),
    //   priority: _priority,
    //   deadline: _deadline,
    //   estimatedTime: _estimatedTime,
    //   category: _category,
    // );
    
    // await _taskUseCases.repository.createTask(task);
    // AppRoutes.navigateBack(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task creation not yet implemented')),
    );
  }
}
