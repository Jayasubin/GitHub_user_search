import 'package:flutter/material.dart';
import 'package:github_viewer/model/user_model.dart';

class ProfileView extends StatelessWidget {
  final UserModel user;
  const ProfileView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            color: Colors.white,
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 96,
              backgroundColor: const Color(0xFFF9F9F9),
              foregroundImage:
                  user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
              child: const Icon(
                Icons.person_rounded,
                size: 64.0,
                color: Colors.lightBlue,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: tTheme.titleLarge,
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Description: '),
                  const SizedBox(height: 8.0),
                  Text('Repositories: ${user.repoCount}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
