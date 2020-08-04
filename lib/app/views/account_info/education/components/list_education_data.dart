import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/components/listview_group.dart';
import 'package:flutter_prismahr/app/components/listview_group_title.dart';
import 'package:flutter_prismahr/app/data/models/account_info/education_model.dart';
import 'package:flutter_prismahr/app/views/account_info/education/components/education_card.dart';

class ListEducationData extends StatelessWidget {
  final List<EducationModel> educations;

  const ListEducationData({
    Key key,
    @required this.educations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListViewGroup(
      title: ListViewGroupTitle(title: 'My educations'),
      items: this
          .educations
          .map((education) => EducationCard(education: education))
          .toList(),
    );
  }
}
