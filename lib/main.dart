import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact_book/blocs/register/register_contact_bloc.dart';
import 'package:flutter_contact_book/blocs/search/search_contact_blocs_exports.dart';
import 'package:flutter_contact_book/repositories/contact_repository.dart';
import 'package:flutter_contact_book/screens/home_screen.dart';
import 'package:flutter_contact_book/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterContactBloc>(
          create: (_) => RegisterContactBloc(
            repository: ContactRepository(
              dio: Dio(),
            ),
          ),
        ),
        BlocProvider<SearchContactBloc>(
          create: (_) => SearchContactBloc(
            repository: ContactRepository(
              dio: Dio(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contact Book',
        theme: AppTheme.light,
        home: const HomeScreen(),
      ),
    );
  }
}
