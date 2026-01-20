import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_model.dart';
import '../providers/saved_provider.dart';
import '../screens/job_details_screen.dart';

class JobCard extends ConsumerWidget {
  final JobModel job;
  const JobCard(this.job, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedAsync = ref.watch(savedProvider);
    final saved = savedAsync.maybeWhen(
      data: (jobs) => jobs.any((j) => j.id == job.id),
      orElse: () => false,
    );

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => JobDetailsScreen(job)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6)
          ],
        ),
        child: Row(
          children: [

            /// LEFT ICON
            const CircleAvatar(
              backgroundColor: Color(0xFF3F51B5),
              child: Icon(Icons.work, color: Colors.white),
            ),

            const SizedBox(width: 12),

            /// TITLE INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(job.company,
                      style: const TextStyle(color: Colors.blue)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(job.location,
                            style:
                                const TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// SALARY + BOOKMARK
            Column(
              children: [
                Text(
                  job.salaryMin != null
                      ? "₹${job.salaryMin}"
                      : "₹ --",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                IconButton(
                  icon: Icon(
                    saved ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  onPressed: () =>
                      ref.read(savedProvider.notifier).toggle(job),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
