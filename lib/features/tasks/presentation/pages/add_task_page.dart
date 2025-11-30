import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/routes.dart';
import '../../../../core/models/task.dart';
import '../../../../core/services/id_generator.dart';

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
  final _estimatedDurationController = TextEditingController();

  // Form values
  int _priority = 3; // Default to medium (1-5 scale)
  DateTime? _deadline;
  TimeOfDay? _deadlineTime;
  double? _estimatedDuration;

  @override
  void initState() {
    super.initState();
    // TODO: In production, inject repository via dependency injection (Provider, GetIt, etc.)
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _estimatedDurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Task')),
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

              // Priority selector
              const Text(
                'Priority',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Low', style: TextStyle(fontSize: 12)),
                  Expanded(
                    child: Slider(
                      value: _priority.toDouble(),
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _getPriorityLabel(_priority),
                      onChanged: (value) {
                        setState(() {
                          _priority = value.toInt();
                        });
                      },
                    ),
                  ),
                  const Text('High', style: TextStyle(fontSize: 12)),
                ],
              ),
              Center(
                child: Chip(
                  label: Text(_getPriorityLabel(_priority)),
                  backgroundColor: _getPriorityColor(_priority),
                ),
              ),
              const SizedBox(height: 16),

              // Deadline picker
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today),
                title: Text(
                  _deadline == null
                      ? 'Set deadline (optional)'
                      : _formatDeadline(),
                ),
                trailing: _deadline != null
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          setState(() {
                            _deadline = null;
                            _deadlineTime = null;
                          });
                        },
                      )
                    : null,
                onTap: _pickDeadline,
              ),
              const SizedBox(height: 16),

              // Estimated duration picker
              TextFormField(
                controller: _estimatedDurationController,
                decoration: const InputDecoration(
                  labelText: 'Estimated Duration (optional)',
                  hintText: 'Enter duration in hours',
                  suffixText: 'hours',
                  prefixIcon: Icon(Icons.timer_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChanged: (value) {
                  setState(() {
                    _estimatedDuration = value.isEmpty
                        ? null
                        : double.tryParse(value);
                  });
                },
              ),
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
    // Show date picker
    final date = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (date != null) {
      // Also pick time
      if (!mounted) return;
      final time = await showTimePicker(
        context: context,
        initialTime: _deadlineTime ?? TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          _deadline = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
          _deadlineTime = time;
        });
      }
    }
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();
    final task = Task(
      id: IdGenerator.generate(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      createdAt: now,
      updatedAt: now,
      priority: _priority,
      deadline: _deadline,
      estimatedDuration: _estimatedDuration,
      isCompleted: false,
    );

    try {
      // TODO: In production, inject repository via dependency injection
      // For now, showing the pattern - repository would need to be accessible
      // await _repository.createTask(task);

      // Show success message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task "${task.title}" created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to task list
      AppRoutes.navigateBack(context);
    } catch (e) {
      // Show error message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating task: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getPriorityLabel(int priority) {
    switch (priority) {
      case 1:
        return 'Very Low';
      case 2:
        return 'Low';
      case 3:
        return 'Medium';
      case 4:
        return 'High';
      case 5:
        return 'Very High';
      default:
        return 'Medium';
    }
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.blue.shade100;
      case 2:
        return Colors.green.shade100;
      case 3:
        return Colors.orange.shade100;
      case 4:
        return Colors.deepOrange.shade100;
      case 5:
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  String _formatDeadline() {
    if (_deadline == null) return '';

    final date = _deadline!;
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final month = months[date.month - 1];
    final day = date.day;
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$month $day, $year at $hour:$minute';
  }
}
