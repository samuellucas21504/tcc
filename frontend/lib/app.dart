import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/authentication/view/register/register_page.dart';
import 'package:tcc/config/themes.dart';
import 'package:tcc/habit/view/reason_page.dart';

import 'package:tcc/splash/view/splash_page.dart';
import 'package:tcc/home/view/home_page.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final HabitRepository _habitRepository;
  final StorageRepository _storageRepository = StorageRepository();

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository(storageRepository: _storageRepository);
    _habitRepository = HabitRepository(
      authenticationRepository: _authenticationRepository,
      userRepository: _userRepository,
      storageRepository: _storageRepository,
    );
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _habitRepository)
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
          habitRepository: _habitRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: Themes.main,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                if (state.user.habitRegistered) {
                  _navigator.pushAndRemoveUntil(
                    HomePage.route(),
                    (route) => false,
                  );
                } else {
                  _navigator.pushAndRemoveUntil(
                    ReasonPage.route(),
                    (route) => false,
                  );
                }

              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(
                  RegisterPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
