import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scapp/model/note_add.dart';
import 'package:scapp/model/note_edit.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final Box _notesBox = Hive.box('notesBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade200,
        elevation: 20,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const NoteAdd(),
            ),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        itemCount: _notesBox.length,
        itemBuilder: (BuildContext context, int index) {
          final note = _notesBox.getAt(index);
          return ListTile(
            title: Text(
              note.toString(),
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _notesBox.deleteAt(index);
                setState(() {});
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NoteEdit(
                    index: index,
                  ),
                ),
              ).then((value) => setState(() {}));
            },
            leading: CircleAvatar(
                backgroundColor: Colors.deepPurple.shade200,
                child: Text((index + 1).toString())),
          );
        },
      ),
    );
  }
}
