import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:tcc/drawer/views/drawer.dart';
import 'package:tcc/drawer/components/menu_button.dart';
import 'package:tcc/components/padded_scrollview.dart';
import 'package:tcc/home/view/habit_records_calendar.dart';
import 'package:tcc/home/components/text_section.dart';
import 'package:tcc/home/components/texts/title_text.dart';
import 'package:tcc/home/cubit/habit_cubit.dart';
import 'package:tcc/home/cubit/habit_record_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        settings: const RouteSettings(name: 'home_page'),
        builder: (_) {
          return BlocProvider(
            create: (context) => HabitCubit(
                repository: RepositoryProvider.of<HabitRepository>(context)),
            child: const HomePage(),
          );
        });
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HabitCubit>(context).fetchHabit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuButton(),
      ),
      drawer: const CustomDrawer(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return PaddedScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _habitSection(context),
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
                BlocProvider(
                  create: (context) {
                    return HabitRecordCubit(
                      repository:
                          RepositoryProvider.of<HabitRepository>(context),
                    );
                  },
                  child: const HabitRecordsCalendar(),
                ),
                const SizedBox(
                  height: 125,
                ),
              ],
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _habitSection(BuildContext context) {
    return BlocBuilder<HabitCubit, HabitState>(builder: (context, state) {
      if (state is HabitLoaded) {
        final habit = state.habit;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextSection(
              title: 'A razão de sua motivação é:',
              description: "${habit.reason}.",
            ),
            TextSection(
              title: 'Frase de hoje:',
              description: habit.motivation!,
            ),
            const SizedBox(height: 12),
          ],
        );
      }

      return const SizedBox();
    });
  }
}
