import 'package:fit_fusion/bloc/authBloc/auth_bloc.dart';
import 'package:fit_fusion/bloc/quote/quote_bloc.dart';
import 'package:fit_fusion/data/repository/quote_repo.dart';
import 'package:fit_fusion/data/repository/user_repo.dart';
import 'package:fit_fusion/presentation/auth/sign_up.dart';
import 'package:fit_fusion/presentation/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => QuoteRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              RepositoryProvider.of<UserRepository>(context),
            )..add(LoginStatus()),
          ),
          BlocProvider(
            create: (context) => QuoteBloc(
              RepositoryProvider.of<QuoteRepository>(context),
            )..add(LoadQuotesEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Fitness App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return HomePage();
              }
              return const SignUpPage();
            },
          ),
        ),
      ),
    );
  }
}
