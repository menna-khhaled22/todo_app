import 'package:flutter/material.dart';
import '../db_helper.dart';

class NotesListScreen extends StatefulWidget {
  static const routeName = '/notes-list';
  @override
  _NotesListScreenState createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    final data = await DBHelper.fetchNotes();
    setState(() {
      _notes = data;
    });
  }

  void _deleteNote(String id) async {
    await DBHelper.deleteNote(id);
    _loadNotes(); // تحديث بعد الحذف
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Notes')),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(_notes[i]['title']),
          subtitle: Text(_notes[i]['content']),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteNote(_notes[i]['id']),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/add'),
      ),
    );
  }
}
