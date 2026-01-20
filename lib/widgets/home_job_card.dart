import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_model.dart';
import '../screens/job_details_screen.dart';
import '../providers/saved_provider.dart';

class HomeJobCard extends ConsumerWidget {
  final JobModel job;
  const HomeJobCard(this.job, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedJobsAsync = ref.watch(savedProvider);
    final isSaved = savedJobsAsync.maybeWhen(
      data: (jobs) => jobs.any((j) => j.id == job.id),
      orElse: () => false,
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF1FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Recommended", style: TextStyle(fontSize: 11)),
              GestureDetector(
                onTap: () => ref.read(savedProvider.notifier).toggle(job),
                child: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const CircleAvatar(
            backgroundColor: Colors.indigo,
            child: Icon(Icons.work, color: Colors.white),
          ),

          const SizedBox(height: 10),

          Flexible(
            child: Text(job.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),

          const SizedBox(height: 6),

          Flexible(
            child: Text(job.company,
                style: const TextStyle(color: Colors.blue)),
          ),

          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  job.salaryMin != null
                      ? "₹${job.salaryMin}"
                      : "₹--",
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobDetailsScreen(job)),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text("Details",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              )
            ],
          ),

          const SizedBox(height: 4),

          Text(job.location,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
