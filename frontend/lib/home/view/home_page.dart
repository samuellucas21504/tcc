import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/home/components/menu_button.dart';
import 'package:tcc/home/components/streak_calendar/streak_calendar.dart';
import 'package:tcc/home/components/text_button.dart';
import 'package:tcc/home/components/text_section.dart';
import 'package:tcc/home/components/texts/title_text.dart';
import 'package:tcc/config/colors.dart';
import 'package:tcc/config/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.165;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return MenuButton(onPressed: Scaffold.of(context).openDrawer);
        }),
      ),
      drawer: Builder(builder: (context) {
        final user =
            context.select((AuthenticationBloc bloc) => bloc.state.user);
        return Drawer(
          child: Theme(
            data: Themes.themeWithTransparentDivider(context),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: ThemeColors.highlight,
                      size: 48,
                    ),
                  ),
                ),
                Text(
                  user.name,
                  textAlign: TextAlign.center,
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    print('Teste');
                  },
                ),
                ListTile(
                  title: const Text('Sair'),
                  onTap: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                  },
                )
              ],
            ),
          ),
        );
      }),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          final user =
              context.select((AuthenticationBloc bloc) => bloc.state.user);

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const TextSection(
                      title: 'A razão de sua motivação é:',
                      description:
                          'Ganhar músculos para carregar meu filho no colo.',
                    ),
                    const TextSection(
                      title: 'Frase de hoje:',
                      description:
                          'Cada pequeno passo na academia é um investimento no seu futuro, naqueles momentos preciosos em que seu filho olhará para você com admiração e confiança, sabendo que sempre poderá contar com você para levantá-lo. Mantenha-se firme, cada músculo que você constrói é uma promessa de apoio e amor.',
                    ),
                    const SizedBox(height: 12),
                    const TitleText(
                      'Voce ainda não marcou hoje como feito',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    InteractiveButton(
                      onPressed: () => print(user.token),
                      text: 'Marcar dia feito',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(),
                    ),
                    const TitleText(
                      'Seu progresso',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () => print('1'),
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        const Expanded(
                          flex: 6,
                          child: StreakCalendar(),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () => print('1'),
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 125,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
