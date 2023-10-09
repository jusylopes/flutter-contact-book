part of 'search_contact_bloc.dart';

class SearchContactState extends Equatable {
  const SearchContactState({
    required this.status,
    required this.contacts,
    this.errorMessage,
  });

  final BlocStatus status;
  final List<ContactModel> contacts;
  final String? errorMessage;

  SearchContactState copyWith({
    BlocStatus? status,
    List<ContactModel>? contacts,
    String? errorMessage,
  }) {
    return SearchContactState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, contacts, errorMessage];
}
