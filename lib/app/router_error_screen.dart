import 'package:flutter/material.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message ?? 'Route error!'),
      ),
    );
  }
}