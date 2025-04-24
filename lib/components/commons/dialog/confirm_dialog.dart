import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onConfirm;
  final String confirmButtonText;
  final String cancelButtonText;

  const DeleteConfirmationDialog({
    Key? key,
    this.title = 'Xác nhận xóa',
    this.content = 'Bạn có chắc chắn muốn xóa mục này không?',
    required this.onConfirm,
    this.confirmButtonText = 'Xóa',
    this.cancelButtonText = 'Hủy',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            cancelButtonText,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(
            confirmButtonText,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  // Hiển thị dialog xác nhận xóa
  static Future<void> show({
    required BuildContext context,
    String title = 'Xác nhận xóa',
    String content = 'Bạn có chắc chắn muốn xóa mục này không?',
    required Function onConfirm,
    String confirmButtonText = 'Xóa',
    String cancelButtonText = 'Hủy',
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => DeleteConfirmationDialog(
        title: title,
        content: content,
        onConfirm: onConfirm,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
      ),
    );
  }
}