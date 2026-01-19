import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_model.dart';

final savedProvider =
    StateNotifierProvider<SavedNotifier, List<JobModel>>((ref) {
  return SavedNotifier();
});

class SavedNotifier extends StateNotifier<List<JobModel>> {
  SavedNotifier() : super([]);

  void toggle(JobModel job) {
    if (state.contains(job)) {
      state = [...state]..remove(job);
    } else {
      state = [...state, job];
    }
  }
}
