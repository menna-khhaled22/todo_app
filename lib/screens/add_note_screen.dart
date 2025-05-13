import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../db_helper.dart';

class AddNoteScreen extends StatefulWidget {
  static const routeName = '/add-note';
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      // عرض رسالة تنبيه
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('من فضلك املأ كل الحقول')),
      );
      return;
    }

    final id = Uuid().v4(); // إنشاء ID فريد لكل ملاحظة

    await DBHelper.insertNote(id, title, content);

    Navigator.pop(context); // الرجوع لقائمة الملاحظات
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة ملاحظة')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'عنوان الملاحظة'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'المحتوى'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('حفظ'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
