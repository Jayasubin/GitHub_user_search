import 'package:flutter/material.dart';
import 'package:github_viewer/model/user_model.dart';
import 'package:github_viewer/service/http_service.dart';
import 'package:github_viewer/view/result/result_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = '';
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search User'),
      ),
      body: (!isSearching)
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    //autofocus: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type a user name'),
                    cursorHeight: 24.0,
                    onChanged: (String? input) {
                      if (input != null && input.isNotEmpty) query = input;
                    },
                    onSubmitted: (_) => handleSearch(),
                    textInputAction: TextInputAction.search,
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: handleSearch,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text('Search'),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  bool validate() {
    if (query.length < 3) return false;

    return true;
  }

  void handleSearch() async {
    if (!validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please check your query'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() => isSearching = true);
    //FocusManager.instance.primaryFocus?.unfocus();

    final List<UserModel>? users = await HttpService().searchUsers(query);
    query = '';

    setState(() => isSearching = false);

    if (!mounted) return;

    if (users != null && users.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultView(users: users),
        ),
      );
      return;
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No data'),
          content: const Text('No users found for that query'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
