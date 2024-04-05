import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NoteAdd extends StatefulWidget {
  const NoteAdd({super.key});

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_textEditingController.text.isNotEmpty) {
            final Box notesBox = Hive.box('notesBox');
            notesBox.add(_textEditingController.text);
            _textEditingController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Note saved',style: TextStyle(fontWeight: FontWeight.bold),)));
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Please enter a note',style: TextStyle(fontWeight: FontWeight.bold),),
            ));
          }
        },
      ),
      appBar: AppBar(
        title: const Text(
          'Not add',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
        child: TextField(
          controller: _textEditingController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Notunuzu buraya yazın',
          ),
        ),
      ),
    );
  }
}
