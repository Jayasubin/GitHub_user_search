import 'package:github_viewer/model/repo_model.dart';

class UserModel {
  String name;
  int id;
  String? avatarUrl;
  String? reposUrl;
  bool reposLoaded;
  List<RepoModel> repos;

  int get repoCount => repos.length;

  UserModel({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.reposUrl,
    this.reposLoaded = false,
    this.repos = const <RepoModel>[],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["login"],
      avatarUrl: json["avatar_url"],
      reposUrl: json["repos_url"],
    );
  }

  void addRepos(List<RepoModel> repos) {
    repos.addAll(repos);
  }
}
