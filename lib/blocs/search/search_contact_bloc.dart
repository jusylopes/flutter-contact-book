
import 'package:equatable/equatable.dart';
import 'package:flutter_contact_book/blocs/enum/bloc_status.dart';
import 'package:flutter_contact_book/blocs/search/search_contact_blocs_exports.dart';
import 'package:flutter_contact_book/models/contact_model.dart';
import 'package:flutter_contact_book/repositories/contact_repository.dart';

part 'search_contact_event.dart';
part 'search_contact_state.dart';

class SearchContactBloc extends Bloc<SearchContactEvent, SearchContactState> {
  SearchContactBloc({required this.repository})
      : super(const SearchContactState(
            status: BlocStatus.initial, contacts: [])) {
    on<Search>(_onSearch);
  }

  final ContactRepository repository;

  void _onSearch(Search event, Emitter<SearchContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      List<ContactModel> contactsList =
          await repository.searchContact(query: event.query);
      emit(state.copyWith(status: BlocStatus.success, contacts: contactsList));
    } catch (error) {
      emit(state.copyWith(
          status: BlocStatus.error, errorMessage: 'Error loading data...'));
    }
  }
}
