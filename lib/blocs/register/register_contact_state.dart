part of 'register_contact_bloc.dart';

class RegisterContactState<T> extends Equatable {
  const RegisterContactState({
    required this.status,
    this.data,
    this.errorMessage,
  });

  final BlocStatus status;
  final T? data;
  final String? errorMessage;

  RegisterContactState copyWith({
    BlocStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return RegisterContactState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
