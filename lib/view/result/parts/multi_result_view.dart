import 'package:flutter/material.dart';
import 'package:github_viewer/model/user_model.dart';
import 'package:github_viewer/view/result/widget/single_user_card.dart';

class MultiResultView extends StatelessWidget {
  final List<UserModel> users;
  final Function onTapUser;

  const MultiResultView(
      {Key? key, required this.users, required this.onTapUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        final curUser = users[index];

        return SingleUserCard(
          user: curUser,
          handleTap: onTapUser,
        );
      },
      itemCount: users.length,
    );
  }
}
