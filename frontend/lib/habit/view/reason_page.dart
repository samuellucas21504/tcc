import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/habit/view/reason_form.dart';
import 'package:tcc/home/components/padded_scrollview.dart';
import 'package:tcc/home/components/texts/description_text.dart';

class ReasonPage extends StatelessWidget {
  const ReasonPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ReasonPage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return SafeArea(
      child: Scaffold(
        body: PaddedScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DescriptionText(
                'Olá ${user.name}! Que bom que você se interessou em nosso aplicativo!',
              ),
              const SizedBox(height: 10),
              const DescriptionText(
                  'Antes de começar a utilizar o aplicativo, é importante entendermos o por que de você querer utilizar esse aplicativo!'),
              const SizedBox(height: 15),
              const DescriptionText('Explique, qual o seu objetivo?'),
              const SizedBox(height: 15),
              const ReasonForm(),
            ],
          ),
        ),
      ),
    );
  }
}
