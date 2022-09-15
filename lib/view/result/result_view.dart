import 'package:flutter/material.dart';
import 'package:github_viewer/constants/constants.dart';
import 'package:github_viewer/model/user_model.dart';
import 'package:github_viewer/view/result/parts/multi_result_view.dart';
import 'package:github_viewer/view/result/parts/profile_view.dart';
import 'package:github_viewer/view/result/parts/repository_view.dart';

class ResultView extends StatefulWidget {
  final List<UserModel> users;
  const ResultView({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  UserModel? currentUser;
  late ResultPageTabs currentTab;

  @override
  void initState() {
    super.initState();

    currentUser = widget.users.length == 1 ? widget.users[0] : null;
    currentTab = ResultPageTabs.profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(currentUser != null ? currentTab.appBarTitle : 'Select user'),
      ),
      body: currentUser != null
          ? getBody(widget.users[0])
          : MultiResultView(
              users: widget.users,
              onTapUser: onTapUser,
            ),
      bottomNavigationBar: currentUser != null
          ? BottomNavigationBar(
              items: getItems(),
              currentIndex: currentTab.myIndex,
              type: BottomNavigationBarType.shifting,
              showSelectedLabels: true,
              onTap: onTapNavBar,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.blueGrey,
            )
          : null,
    );
  }

  List<BottomNavigationBarItem> getItems() {
    var items = <BottomNavigationBarItem>[];

    items.addAll(
      ResultPageTabs.values.map(
        (value) => BottomNavigationBarItem(
          icon: Icon(value.navIcon),
          label: value.navBarName,
        ),
      ),
    );

    return items;
  }

  void onTapUser(UserModel user) {
    setState(() {
      currentUser = user;
    });
  }

  Widget getBody(UserModel user) {
    if (currentTab == ResultPageTabs.profile) {
      return ProfileView(user: user);
    } else {
      return RepositoryView(reposUrl: user.reposUrl ?? '');
    }
  }

  void onTapNavBar(int index) {
    setState(() {
      currentTab =
          ResultPageTabs.values.singleWhere((value) => value.myIndex == index);
    });
  }
}
