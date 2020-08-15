import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/auth/auth_bloc.dart';
import 'package:flutter_prismahr/app/components/listview_group.dart';
import 'package:flutter_prismahr/app/components/listview_group_title.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/account_info/components/account_completion_card.dart';
import 'package:flutter_prismahr/app/views/account_info/components/dark_mode_switch.dart';
import 'package:flutter_prismahr/app/views/account_info/components/header.dart';
import 'package:flutter_prismahr/app/views/account_info/components/profile_menu.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: <Widget>[
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return ProfileHeader(
                    avatarUrl: state.user.avatar,
                    username: state.user.name,
                    role: 'Co-Founder',
                    company: 'PT. Prisma Tech Indonesia',
                  );
                }
                return Container();
              },
            ),
            Hero(
              tag: 'account-completion',
              child: AccountCompletionCard(),
            ),
            ListViewGroup(
              title: ListViewGroupTitle(title: 'Account Information'),
              items: <Widget>[
                ProfileMenu(
                  icon: 'assets/icons/icon-user-circle.svg',
                  label: 'Personal',
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.ACCOUNT_INFO_PERSONAL);
                  },
                ),
                ProfileMenu(
                  iconBackground: Color(0xFFF3548D),
                  icon: 'assets/icons/icon-id-badge.svg',
                  label: 'Employment',
                  onTap: () {
                    // Get.toNamed(Routes.EMPLOYMENT_INFO);
                  },
                ),
                ProfileMenu(
                  iconBackground: Color(0xFF9A5BFF),
                  icon: 'assets/icons/icon-contacts.svg',
                  label: 'Contacts',
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.CONTACT_INFO);
                  },
                ),
                ProfileMenu(
                  iconBackground: Color(0xFF00D166),
                  icon: 'assets/icons/icon-book-reader.svg',
                  label: 'Educations',
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.EDUCATION_INFO);
                  },
                ),
                ProfileMenu(
                  iconBackground: Color(0xFF57109F),
                  icon: 'assets/icons/icon-briefcase.svg',
                  iconHeight: 15.75,
                  label: 'Working Experiences',
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.EXPERIENCE_INFO);
                  },
                ),
                ProfileMenu(
                  iconBackground: Color(0xFF28CEE8),
                  icon: 'assets/icons/icon-credit-card.svg',
                  iconWidth: 18,
                  iconHeight: 14,
                  label: 'Payroll',
                  onTap: () {
                    // TODO: Add navigator for payroll
                  },
                ),
              ],
            ),
            ListViewGroup(
              title: ListViewGroupTitle(title: 'Settings'),
              items: <Widget>[
                ProfileMenu(
                  iconBackground: Color(0xFF2DB9B0),
                  icon: 'assets/icons/icon-bell.svg',
                  label: 'Notifications',
                  onTap: () {
                    // TODO: Add navigator for settings
                  },
                ),
                ProfileMenu(
                  iconBackground: Color(0xFF555D5C),
                  icon: 'assets/icons/icon-moon.svg',
                  label: 'Dark Mode',
                  trailing: DarkModeSwitch(),
                ),
                ProfileMenu(
                  iconBackground: Color(0xFFFF894B),
                  icon: 'assets/icons/icon-paint.svg',
                  label: 'Color Scheme',
                  onTap: () {
                    // TODO: Add navigator for color scheme
                  },
                ),
              ],
            ),
            ListViewGroup(
              title: ListViewGroupTitle(title: 'Help & Support'),
              items: <Widget>[
                ProfileMenu(
                  icon: 'assets/icons/icon-book.svg',
                  label: 'Official Documentation',
                  onTap: () {
                    // TODO: Add navigator for documentation
                  },
                ),
                ProfileMenu(
                  iconBackground: Color(0xFF9D99B9),
                  icon: 'assets/icons/icon-info.svg',
                  label: 'About this app',
                  onTap: () {
                    // TODO: Add navigator for about this app
                  },
                ),
                ProfileMenu(
                  iconBackground: Color(0xFFE82828),
                  icon: 'assets/icons/icon-bug.svg',
                  label: 'Report a bug',
                  onTap: () {
                    // TODO: Add navigator for report bug
                  },
                ),
              ],
            ),
            FlatButton(
              child: Text(
                "Sign out",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xffe82828),
                ),
              ),
              onPressed: () {
                // TODO: Add navigator for sign out
              },
            ),
            Column(
              children: <Widget>[
                Text(
                  "PrismaHR v1.0.0",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Color(0xff9d99b9),
                  ),
                ),
                Text(
                  "Copyright © 2020 Prisma Tech Indonesia\nAll Rights Reserved",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: Color(0xff9d99b9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
