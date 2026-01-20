import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_model.dart';
import '../services/adzuna_service.dart';

final adzunaServiceProvider = Provider((ref) => AdzunaService());

final jobProvider =
    StateNotifierProvider<JobNotifier, List<JobModel>>((ref) {
  return JobNotifier(ref.read(adzunaServiceProvider));
});

class JobNotifier extends StateNotifier<List<JobModel>> {
  final AdzunaService service;

  String _lastKeyword = "developer";
  String _lastCountry = "in";

  JobNotifier(this.service) : super([]);

  /// 🔍 SEARCH FROM SEARCH SCREEN
  Future<void> search(String keyword, String country) async {
    _lastKeyword = keyword.isEmpty ? "developer" : keyword;
    _lastCountry = country;

    state = await service.fetchJobs(
      keyword: _lastKeyword,
      country: _lastCountry,
    );
  }

  /// 🏠 LOAD HOME RECOMMENDATION FROM HISTORY
  Future<void> loadFromHistory() async {
    state = await service.fetchJobs(
      keyword: _lastKeyword,
      country: _lastCountry,
    );
  }
}
