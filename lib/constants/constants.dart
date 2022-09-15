/*
enum ResultState {
  loading,
  loaded,
  failure;
}
*/

import 'package:flutter/material.dart';

enum ResultPageTabs {
  profile,
  repositories;

  String get appBarTitle {
    switch (this) {
      case ResultPageTabs.profile:
        return 'Profile';
      case ResultPageTabs.repositories:
        return 'Repositories';
    }
  }

  String get navBarName {
    switch (this) {
      case ResultPageTabs.profile:
        return 'Profile';
      case ResultPageTabs.repositories:
        return 'Repos';
    }
  }

  IconData get navIcon {
    switch (this) {
      case ResultPageTabs.profile:
        return Icons.person_outlined;
      case ResultPageTabs.repositories:
        return Icons.library_books_outlined;
    }
  }

  int get myIndex {
    switch (this) {
      case ResultPageTabs.profile:
        return 0;
      case ResultPageTabs.repositories:
        return 1;
    }
  }
}
