import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/card_with_progress_indicator.dart';

class AccountCompletionCard extends StatelessWidget {
  const AccountCompletionCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CardWithProgressIndicator(
        indicatorValue: 50,
        title: 'Account Completion',
        subtitle: 'Please complete your profile to use\n'
            'all available features.',
      ),
    );
  }
}
