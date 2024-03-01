import 'package:flutter/material.dart';

class UserAlerts {
  final String message;
  final String? status;

  const UserAlerts({
    required this.message,
    required this.status,
  });

  static show(
    BuildContext context,
    String message,
    String status,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        backgroundColor: status == 'success' ? Colors.green : Colors.red,
        //behavior: SnackBarBehavior.floating,
        content: Text(message),
        duration: const Duration(seconds: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
          ),
        ),
        //backgroundColor: Colors.redAccent,
        action: SnackBarAction(
          textColor: const Color(0xFFFAF2FB),
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}
