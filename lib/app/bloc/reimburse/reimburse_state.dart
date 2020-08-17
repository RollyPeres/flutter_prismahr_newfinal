part of 'reimburse_bloc.dart';

abstract class ReimburseState extends Equatable {
  const ReimburseState();

  @override
  List<Object> get props => [];
}

class ReimburseInitial extends ReimburseState {}

class ReimburseLoading extends ReimburseState {}

class ReimburseEmpty extends ReimburseState {}

class ReimburseLoaded extends ReimburseState {
  final List<Reimburse> data;
  const ReimburseLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ReimburseLoaded { data: $data }';
}

class ReimburseFailure extends ReimburseState {
  final String error;
  const ReimburseFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ReimburseFailure { error: $error }';
}

class ReimburseCreated extends ReimburseState {
  final Reimburse data;
  const ReimburseCreated({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ReimburseCreated { data: $data }';
}
