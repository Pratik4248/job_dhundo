import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/job_model.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobModel job;
  const JobDetailsScreen(this.job, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        title: Text(
          job.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// COMPANY
            Text(
              job.company,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),

            const SizedBox(height: 6),

            /// LOCATION
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    job.location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),

            /// SALARY
            if (job.salaryMin != null || job.salaryMax != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const Icon(Icons.currency_rupee,
                        size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      "${job.salaryMin ?? ''} - ${job.salaryMax ?? ''}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            /// DESCRIPTION TITLE
            const Text(
              "Job Description",
              style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            /// DESCRIPTION CARD (auto height)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Text(
                job.description.isNotEmpty
                    ? job.description
                    : "No description available.",
                style: const TextStyle(height: 1.5),
              ),
            ),

            const SizedBox(height: 80), // space for apply button
          ],
        ),
      ),

      /// APPLY BUTTON FIXED
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => launchUrl(
              Uri.parse(job.redirectUrl),
              mode: LaunchMode.externalApplication,
            ),
            child: const Text(
              "Apply on Website",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
