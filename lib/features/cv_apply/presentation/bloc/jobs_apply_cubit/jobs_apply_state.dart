import 'package:bayat/features/cv_apply/domain/entities/jobsentity.dart';
import 'package:equatable/equatable.dart';

sealed class JobsAplyState extends Equatable {
  const JobsAplyState();

  @override
  List<Object?> get props => [];
}

class JobsAplyInit extends JobsAplyState {}

class JobsAplyLoading extends JobsAplyState {}

class JobsAplyLoaded extends JobsAplyState {
  final List<JobEntity> jobs;
  const JobsAplyLoaded(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class JobsAplyFiltered extends JobsAplyState {
  final List<JobEntity> filteredJobs;
  const JobsAplyFiltered(this.filteredJobs);

  @override
  List<Object?> get props => [filteredJobs];
}

class JobsAplyFailure extends JobsAplyState {
  final String message;
  const JobsAplyFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class JobsAplyNoInternet extends JobsAplyState {
  const JobsAplyNoInternet();
}
