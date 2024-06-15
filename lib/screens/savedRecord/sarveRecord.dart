import 'package:flutter/material.dart';

class SavedRecordView extends StatefulWidget {
  const SavedRecordView({super.key});

  @override
  State<SavedRecordView> createState() => _SavedRecordViewState();
}

class _SavedRecordViewState extends State<SavedRecordView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("It's SavedRecord"),
    );
  }
}
