import 'package:equatable/equatable.dart';
import 'package:flutter_contact_book/blocs/enum/bloc_status.dart';
import 'package:flutter_contact_book/blocs/search/search_contact_blocs_exports.dart';
import 'package:flutter_contact_book/models/contact_model.dart';
import 'package:flutter_contact_book/repositories/contact_repository.dart';

part 'register_contact_event.dart';
part 'register_contact_state.dart';

class RegisterContactBloc
    extends Bloc<RegisterContactEvent, RegisterContactState> {
  RegisterContactBloc({required this.repository})
      : super(const RegisterContactState(status: BlocStatus.initial)) {
    on<GetAllContacts>(_onGetAllContact);
    on<CreateContact>(_onAddContact);
    on<UpdateContact>(_onUpdateContact);
    on<DeleteContact>(_onDeleteContact);
  }

  final ContactRepository repository;

  void _onGetAllContact(
      GetAllContacts event, Emitter<RegisterContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      final List<ContactModel> allContacts =
          await repository.fetchAllContactsSorted();

      emit(state.copyWith(status: BlocStatus.success, data: allContacts));
    } catch (error) {
      emit(state.copyWith(
          status: BlocStatus.error, errorMessage: error.toString()));
    }
  }

  void _onAddContact(
      CreateContact event, Emitter<RegisterContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await repository.addContact(event.newContact);
      final updatedCeps = await repository.fetchAllContacts();
      add(const GetAllContacts());

      emit(state.copyWith(status: BlocStatus.success, data: updatedCeps));
    } catch (error) {
      emit(state.copyWith(
        status: BlocStatus.error,
        errorMessage: '$error',
      ));
    }
  }

  void _onUpdateContact(
      UpdateContact event, Emitter<RegisterContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await repository.updateContact(event.updatedContact);
      emit(state.copyWith(status: BlocStatus.success, ));
      add(const GetAllContacts());

    } catch (error) {
      emit(state.copyWith(
        status: BlocStatus.error,
        errorMessage: '$error',
      ));
    }
  }

  void _onDeleteContact(
      DeleteContact event, Emitter<RegisterContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await repository.deleteContact(event.objectId);
      final updatedContacts = state.data
          .where((contact) => contact.objectId != event.objectId)
          .toList();

      emit(state.copyWith(
        status: BlocStatus.success,
        data: updatedContacts,
      ));

      add(const GetAllContacts());
    } catch (error) {
      emit(state.copyWith(
        status: BlocStatus.error,
        errorMessage: '$error',
      ));
    }
  }
}
