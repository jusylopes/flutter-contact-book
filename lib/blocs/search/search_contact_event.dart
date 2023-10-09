part of 'search_contact_bloc.dart';

abstract class SearchContactEvent extends Equatable {
  const SearchContactEvent();
}

class Search extends SearchContactEvent {
  final String query;
  const Search({
    required this.query,
  });

  @override
  List<Object> get props => [];
}
