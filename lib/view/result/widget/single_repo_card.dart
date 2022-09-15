import 'package:flutter/material.dart';
import 'package:github_viewer/model/repo_model.dart';
import 'package:github_viewer/view/result/widget/public_private.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SingleRepoCard extends StatelessWidget {
  final RepoModel repo;
  const SingleRepoCard({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => handleTap(context),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  repo.name,
                  style: tTheme.bodyText1,
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: 256.0,
                  child: Text(
                    repo.htmlUrl,
                    style: tTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            PublicPrivate(isPrivate: repo.private),
          ],
        ),
      ),
    );
  }

  void handleTap(BuildContext context) async {
    if (await canLaunchUrlString(repo.htmlUrl)) {
      await launchUrlString(repo.htmlUrl);
    } else {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text('No app'),
          content:
              Text("It seems like you don't have an app to open this content"),
        ),
      );
    }
  }
}
