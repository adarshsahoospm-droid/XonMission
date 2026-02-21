import 'package:flutter/material.dart';

/// Placeholder until candidate features are defined.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Candidate app',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
