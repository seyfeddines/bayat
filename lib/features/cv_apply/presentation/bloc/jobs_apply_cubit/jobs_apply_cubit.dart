import 'package:bayat/features/cv_apply/data/datasources/cv_apply_remoute_data_source.dart';
import 'package:bayat/features/cv_apply/domain/entities/jobsentity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'jobs_apply_state.dart';
import '../../../data/repositories/cv_applyrepostries_impl.dart';
import '../../../domain/usecases/GetAllJobs.dart';

class JobsApplyCubit extends Cubit<JobsAplyState> {
  JobsApplyCubit() : super(JobsAplyInit());

  List<JobEntity> _allJobs = [];

  Future<void> loadAllJobs(int id) async {
    emit(JobsAplyLoading());
    print("get data =================");

    final jobsOrFailure = await GetJobsUseCase(
      repostriet: CvaplyRepostriesImpl(remoteDataSpirce: CvapplyRemoteDataSpirce()
      ),
    ).call(id: id);

    jobsOrFailure.fold(
          (failure) {
        if (failure.errMessage == "No Internet Connection") {
          emit(const JobsAplyNoInternet());
        } else {
          emit(JobsAplyFailure(failure.errMessage));
        }
      },
          (jobsApi) {
        _allJobs = jobsApi;
        emit(JobsAplyLoaded(jobsApi));
      },
    );
  }

  void filterJobs(String query) {
    if (state is JobsAplyLoaded) {
      if (query.isEmpty) {
        emit(JobsAplyLoaded(_allJobs));
      } else {
        final filtered = _allJobs
            .where((job) =>
        job.title.toLowerCase().contains(query.toLowerCase()) ||
            job.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(JobsAplyLoaded(filtered));
      }
    }
  }
}
