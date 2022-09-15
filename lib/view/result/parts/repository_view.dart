import 'package:flutter/material.dart';
import 'package:github_viewer/model/repo_model.dart';
import 'package:github_viewer/service/http_service.dart';
import 'package:github_viewer/view/result/widget/single_repo_card.dart';

class RepositoryView extends StatelessWidget {
  final String reposUrl;
  const RepositoryView({
    Key? key,
    required this.reposUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HttpService().getRepositories(reposUrl),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final List<RepoModel> repos = snapshot.data;

            return ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemBuilder: (context, index) {
                final curRepo = repos[index];

                return SingleRepoCard(repo: curRepo);
              },
              itemCount: repos.length,
            );
          } else {
            return const Center(
              child: Text('No data received'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
