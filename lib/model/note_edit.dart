import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NoteEdit extends StatefulWidget {
  final int index;
  const NoteEdit({super.key, required this.index});

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(
        text: Hive.box('notesBox').getAt(widget.index).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
        child: TextField(
          maxLines: null,
          controller: textEditingController,
          decoration: const InputDecoration(hintText: 'Edit Note'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit_note),
        onPressed: () {
          if (textEditingController.text.isNotEmpty) {
            Hive.box('notesBox')
                .putAt(widget.index, textEditingController.text);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Note updated successfully')));
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Please enter a note')));
          }
        },
      ),
    );
  }
}
