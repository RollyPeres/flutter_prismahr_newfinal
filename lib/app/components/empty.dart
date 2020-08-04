import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Empty extends StatelessWidget {
  final String title;
  final String subtitle;

  const Empty({
    Key key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: 350,
            child: Lottie.asset('assets/lottie/empty.json'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Text(
            this.title ?? 'No Data',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            this.subtitle ??
                'We couldn\'t find any information related to your account.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
