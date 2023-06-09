import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class WordDetailsScreen extends StatelessWidget {
  const WordDetailsScreen({super.key});

  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
