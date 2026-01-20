import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/job_model.dart';

final savedProvider =
    AsyncNotifierProvider<SavedNotifier, List<JobModel>>(() {
  return SavedNotifier();
});

class SavedNotifier extends AsyncNotifier<List<JobModel>> {
  @override
  Future<List<JobModel>> build() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return [];
    try {
      final response = await Supabase.instance.client
          .from('bookmarks')
          .select('job_data')
          .eq('user_id', user.id);
      final jobs = (response as List<dynamic>)
          .map((e) => JobModel.fromJson(e['job_data'] as Map<String, dynamic>))
          .toList();
      return jobs;
    } catch (e) {
      throw e;
    }
  }

  Future<void> toggle(JobModel job) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    final currentJobs = state.value ?? [];
    final isSaved = currentJobs.any((j) => j.id == job.id);
    try {
      if (isSaved) {
        await Supabase.instance.client
            .from('bookmarks')
            .delete()
            .eq('user_id', user.id)
            .eq('job_data->>id', job.id);
        state = AsyncValue.data(currentJobs.where((j) => j.id != job.id).toList());
      } else {
        await Supabase.instance.client
            .from('bookmarks')
            .insert({'user_id': user.id, 'job_data': job.toJson()});
        state = AsyncValue.data([...currentJobs, job]);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
