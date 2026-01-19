import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/saved_provider.dart';
import '../widgets/job_card.dart';
import '../widgets/common_header.dart';

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedProvider);

    return Scaffold(
      body: Column(
        children: [
          CommonHeader(title: "Saved Jobs"),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: saved.length,
              itemBuilder: (_, i) => JobCard(saved[i]),
            ),
          ),
        ],
      ),
    );
  }
}
