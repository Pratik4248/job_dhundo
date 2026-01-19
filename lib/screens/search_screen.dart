import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/job_provider.dart';
import '../widgets/job_card.dart';
import '../widgets/common_header.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final controller = TextEditingController();
  String country = "in";

  final countries = {
    "in": "India",
    "gb": "United Kingdom",
    "us": "United States",
    "au": "Australia",
  };

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobProvider);

    return Scaffold(
      backgroundColor:  Colors.white,
      body: Column(
        children: [
          CommonHeader(title: "Search Jobs"),

          /// 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Search jobs...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: country,
                      items: countries.entries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(e.value),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => country = v!),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search_sharp),
                    onPressed: () => ref
                        .read(jobProvider.notifier)
                        .search(controller.text, country),
                  )
                ],
              ),
            ),
          ),

          /// 📋 Job List
          Expanded(
            child: jobs.isEmpty
                ? const Center(
                    child: Text("Search jobs to see results"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: jobs.length,
                    itemBuilder: (_, i) => JobCard(jobs[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
