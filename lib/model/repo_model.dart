class RepoModel {
  int id;
  String name;
  bool private;
  String htmlUrl;

  RepoModel({
    required this.id,
    required this.name,
    required this.private,
    required this.htmlUrl,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json["id"],
      name: json["name"],
      private: json["private"],
      htmlUrl: json["html_url"],
    );
  }
}
