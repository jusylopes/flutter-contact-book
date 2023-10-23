import 'package:flutter/material.dart';
import 'package:flutter_contact_book/blocs/enum/bloc_status.dart';
import 'package:flutter_contact_book/blocs/search/search_contact_blocs_exports.dart';
import 'package:flutter_contact_book/components/contact_card.dart';
import 'package:flutter_contact_book/components/custom_circular_progress_indicator.dart';
import 'package:flutter_contact_book/components/curom_error_message_app.dart';
import 'package:flutter_contact_book/models/contact_model.dart';
import 'package:flutter_contact_book/utils/colors.dart';

class ContactSearch extends SearchDelegate {
  ContactSearch({
    String hintText = 'name...',
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<SearchContactBloc>(context, listen: false)
        .add(Search(query: query));
    return BlocBuilder<SearchContactBloc, SearchContactState>(
      builder: (context, state) {
        switch (state.status) {
          case BlocStatus.initial:
            return const Center();
          case BlocStatus.loading:
            return const CustomCircularProgressIndicator();
          case BlocStatus.success:
            final contacts = state.contacts;

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final ContactModel contact = contacts[index];
                final Color backgroundColorListTile = index.isEven
                    ? AppColors.primaryColor
                    : AppColors.colorBackground;

                return CardContact(
                  backgroundColorListTile: backgroundColorListTile,
                  contact: contact,
                );
              },
            );

          case BlocStatus.error:
            return CustomErrorMessageApp(
              errorMessage: state.errorMessage!,
            );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Column();
  }
}
