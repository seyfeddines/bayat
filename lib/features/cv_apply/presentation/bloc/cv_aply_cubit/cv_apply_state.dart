import 'package:bayat/features/cv_apply/domain/entities/CategoryEntity.dart';
import 'package:equatable/equatable.dart';

sealed class CvApplyState extends Equatable {
  const CvApplyState();

  @override
  List<Object?> get props => [];
}

// 🔹 Initial state (before anything happens)
class CvApplyInitial extends CvApplyState {}

// 🔹 Loading state
class CvApplyLoading extends CvApplyState {}

// 🔹 Success: categories loaded
class CvApplyLoaded extends CvApplyState {
  final List<CategoryEntity> categories;

  const CvApplyLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

// 🔹 Failure: general error
class CvApplyFailure extends CvApplyState {
  final String message;

  const CvApplyFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// 🔹 No Internet connection
class CvApplyNoInternet extends CvApplyState {
  const CvApplyNoInternet();
}
