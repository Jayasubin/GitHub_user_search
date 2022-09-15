import 'dart:convert';
import 'dart:developer';

import 'package:github_viewer/model/repo_model.dart';
import 'package:github_viewer/model/user_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static final HttpService _singleton = HttpService._();

  HttpService._();

  factory HttpService() => _singleton;

  //
  String _fullUrlForName(String query) =>
      "https://api.github.com/search/users?q=$query in:name";

  //
  Future<List<UserModel>?> searchUsers(String query) async {
    var fullUrl = _fullUrlForName(query);
    log('fullUrl: $fullUrl');

    var decoded = await getResponseJson(fullUrl);

    if (decoded != null) {
      if (decoded["total_count"] > 0 && !decoded["incomplete_results"]) {
        log("Got at least one result");

        try {
          List items = decoded["items"];

          var result = List<UserModel>.from(
            items.map((item) => UserModel.fromJson(item)),
          );

          return result;
        } catch (e) {
          log("Caught while create: $e");

          return null;
        }
      } else {
        log("No items in result");

        return [];
      }
    } else {
      return null;
    }
  }

  Future<List<RepoModel>?> getRepositories(String url) async {
    log('RepoUrl: $url');

    List? responseJson = await getResponseJson(url) as List?;

    if (responseJson != null) {
      try {
        var result = List<RepoModel>.from(
          responseJson.map((item) => RepoModel.fromJson(item)),
        );

        return result;
      } catch (e) {
        log("Caught while create: $e");

        return null;
      }
    } else {
      return null;
    }
  }

  Future<dynamic> getResponseJson(String query) async {
    try {
      log("Querying...");

      var url = Uri.parse(query);

      var response = await http.get(url);

      log('Response : $response');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Query Success...");

        var decoded = jsonDecode(response.body);
        log(decoded.toString());

        return decoded;
      } else {
        log("Status code was ${response.statusCode}");

        return null;
      }
    } catch (e) {
      log("Caught while get: $e");

      return null;
    }
  }
}
