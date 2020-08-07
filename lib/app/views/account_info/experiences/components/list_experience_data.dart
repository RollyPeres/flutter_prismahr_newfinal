import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/listview_group.dart';
import 'package:flutter_prismahr/app/components/listview_group_title.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_model.dart';
import 'package:flutter_prismahr/app/views/account_info/experiences/components/experience_card.dart';

class ListExperienceData extends StatelessWidget {
  final List<Experience> experiences;

  const ListExperienceData({
    Key key,
    @required this.experiences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListViewGroup(
      title: ListViewGroupTitle(title: 'My working experiences'),
      items: this
          .experiences
          .map((experience) => ExperienceCard(experience: experience))
          .toList(),
    );
  }
}
