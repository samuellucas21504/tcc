import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/habit/bloc/reason/reason_bloc.dart';
import 'package:tcc/home/components/rectangular_round_button.dart';
import 'package:tcc/home/view/home_page.dart';

class ReasonForm extends StatelessWidget {
  const ReasonForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ReasonBloc(
            habitRepository: RepositoryProvider.of<HabitRepository>(context));
      },
      child: BlocListener<ReasonBloc, ReasonState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
              (route) => false,
            );
          }
        },
        child: Column(
          children: [
            _ReasonInput(),
            const SizedBox(height: 25),
            _RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class _ReasonInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReasonBloc, ReasonState>(
      buildWhen: (previous, current) => previous.reason != current.reason,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_reasonInput_textField'),
          onChanged: (reason) =>
              context.read<ReasonBloc>().add(ReasonChanged(reason)),
          decoration: InputDecoration(
            errorText: state.reason.displayError != null
                ? 'Informe seu objetivo.'
                : null,
            hintText: 'Exemplo: Parar de fumar',
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReasonBloc, ReasonState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
                child: RectangularRoundButton(
              key: key,
              onPressed: () =>
                  context.read<ReasonBloc>().add(const ReasonSubmitted()),
              isInProgess: state.status.isInProgress,
              isValid: state.isValid,
              child: const Text('Confirmar'),
            )),
          ],
        );
      },
    );
  }
}
