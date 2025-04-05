import 'package:flutter/material.dart';

extension Show on BuildContext {
  Future<T?> showBottomSheetDialog<T>(
    Widget child, {
    ShapeBorder? shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
  }) {
    return showModalBottomSheet<T>(
      context: this,
      shape: shape,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Wrap(children: [child]),
        );
      },
      isScrollControlled: true,
    );
  }


  void showErrorSnakeBar(String msg){
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(msg)));
  }
}
