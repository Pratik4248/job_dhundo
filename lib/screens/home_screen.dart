import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/job_provider.dart';
import '../widgets/job_card.dart';
import '../widgets/common_header.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ref.read(jobProvider.notifier).loadTrending();
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobProvider);
    final user = Supabase.instance.client.auth.currentUser;
    String name = 'User!';
    if (user != null && user.userMetadata != null && user.userMetadata!['full_name'] != null) {
      name = user.userMetadata!['full_name'];
    }
    final title = "Hello, $name";
return Scaffold(
  body: Column(
    children: [

      /// HEADER
      CommonHeader(title: title),

      const SizedBox(height: 10),

      /// RECOMMENDATION TITLE
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Recommendation",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),

      /// JOB LIST
      Expanded(
        child: ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (_, i) => JobCard(jobs[i]),
        ),
      ),
    ],
  ),
);

  }
}
