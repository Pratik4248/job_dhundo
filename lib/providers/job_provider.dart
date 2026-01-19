import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_model.dart';
import '../services/adzuna_service.dart';

final adzunaServiceProvider = Provider((ref) => AdzunaService());

final jobProvider = StateNotifierProvider<JobNotifier, List<JobModel>>((ref) {
  return JobNotifier(ref.read(adzunaServiceProvider));
});

class JobNotifier extends StateNotifier<List<JobModel>> {
  final AdzunaService service;

  JobNotifier(this.service) : super([]);

  Future<void> search(String keyword, String country) async {
    state = await service.fetchJobs(keyword: keyword, country: country);
  }
}
