import 'package:flutter/material.dart';
import 'package:flutter_contact_book/blocs/enum/bloc_status.dart';
import 'package:flutter_contact_book/blocs/register/register_contact_bloc.dart';
import 'package:flutter_contact_book/blocs/search/search_contact_blocs_exports.dart';
import 'package:flutter_contact_book/components/contact_card.dart';
import 'package:flutter_contact_book/components/contact_search.dart';
import 'package:flutter_contact_book/components/curom_error_message_app.dart';
import 'package:flutter_contact_book/components/custom_circular_progress_indicator.dart';
import 'package:flutter_contact_book/models/contact_model.dart';
import 'package:flutter_contact_book/screens/contact_register_screen.dart';
import 'package:flutter_contact_book/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RegisterContactBloc>().add(const GetAllContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Contacts',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              color: Colors.black,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ContactSearch(),
                );
              },
            ),
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<RegisterContactBloc, RegisterContactState>(
          builder: (context, state) {
            switch (state.status) {
              case BlocStatus.initial:
                return const Center();
              case BlocStatus.loading:
                return const CustomCircularProgressIndicator();
              case BlocStatus.success:
                final contacts = state.data;

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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ContactRegisterScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
