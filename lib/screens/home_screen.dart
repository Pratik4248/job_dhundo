import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/job_provider.dart';
import '../widgets/common_header.dart';
import '../widgets/home_job_card.dart';

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
      ref.read(jobProvider.notifier).loadFromHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobProvider);

    final user = Supabase.instance.client.auth.currentUser;
    String name = "User!";
    if (user != null &&
        user.userMetadata != null &&
        user.userMetadata!['full_name'] != null) {
      name = user.userMetadata!['full_name'];
    }

    final title = "Hello, $name";

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: Column(
        children: [

          /// 🔹 USER HEADER (UNCHANGED)
          CommonHeader(title: title),

          const SizedBox(height: 10),

          /// 🔹 RECOMMENDATION TITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recommended for you",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// 🔹 GRID JOB CARDS
          Expanded(
            child: jobs.isEmpty
                ? const Center(
                    child: Text(
                      "Search jobs to get personalized recommendations",
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: jobs.length,
                    itemBuilder: (_, i) => HomeJobCard(jobs[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
