// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tcc/challenges/bloc/challenges_bloc.dart';
import 'package:tcc/challenges/views/challenges_page.dart';
import 'package:tcc/components/padded_scrollview.dart';

class CreateChallengeView extends StatefulWidget {
  const CreateChallengeView({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        settings: const RouteSettings(name: 'create_challenge_page'),
        builder: (_) {
          return BlocProvider<ChallengesBloc>(
            create: (context) =>
                ChallengesBloc(repository: RepositoryProvider.of(context)),
            child: const CreateChallengeView(),
          );
        });
  }

  @override
  State<StatefulWidget> createState() => _CreateChallengeViewState();
}

class _CreateChallengeViewState extends State<CreateChallengeView> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateFormat format = DateFormat('dd/MM/yyyy');
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void handleSubmitButton() {
    context.read<ChallengesBloc>().add(ChallengeCreationRequest(
          _textController.text,
          selectedDate,
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7000)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<ChallengesBloc, ChallengesState>(
      listener: (context, state) {
        if (state.status == ChallengesStatus.newChallenge) {
          Navigator.popUntil(
              context,
              (route) =>
                  ChallengesPage.route().settings.name == route.settings.name);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
          title: const Text('Criar desafio'),
        ),
        body: SafeArea(
          child: PaddedScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _textController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome não pode ser nulo.';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Desafio',
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.background,
                          foregroundColor: colorScheme.onBackground,
                          side: BorderSide(color: colorScheme.onPrimary),
                        ),
                        child: const Text('Selecionar data de fim do desafio'),
                      ),
                    )
                  ]),
                  Text(
                      'Data do fim do desafio: ${format.format(selectedDate)}'),
                  const SizedBox(height: 25),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            handleSubmitButton()
                        },
                        child: const Text('Criar o desafio'),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
