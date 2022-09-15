import 'package:flutter/material.dart';
import 'package:github_viewer/model/user_model.dart';

class SingleUserCard extends StatelessWidget {
  final UserModel user;
  final Function handleTap;
  const SingleUserCard({
    Key? key,
    required this.user,
    required this.handleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => handleTap(user),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user.name,
                  style: tTheme.bodyText1,
                ),
                const SizedBox(height: 8.0),
                Text(
                  user.id.toString(),
                  style: tTheme.bodyText1,
                ),
              ],
            ),
            CircleAvatar(
              radius: 32,
              backgroundColor: const Color(0xFFF9F9F9),
              foregroundImage:
                  user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
              child: const Icon(
                Icons.person_rounded,
                size: 48.0,
                color: Colors.lightBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Future<void> getImage() async {}

  void handleTap(){}*/
}
