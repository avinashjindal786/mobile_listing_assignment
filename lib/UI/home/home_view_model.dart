import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_listing_app/model/filter_model.dart';
import 'package:mobile_listing_app/model/home_model.dart';
import 'package:mobile_listing_app/model/search_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import '../../core/repo/home_repository.dart';

class HomeViewModel extends BaseViewModel {
  RefreshController topPostsRefreshController = RefreshController(initialRefresh: false);

  int page = 1;
  int limit = 10;

  changePageNumber() {
    page += 1;
    notifyListeners();
  }

  init() async {
    setBusy(true);
    await getHomeData();
    await getFilters();
    setBusy(false);
  }

  bool search = false;
  TextEditingController searchController = TextEditingController();

  changeSearchOption(bool val) {
    search = val;
    notifyListeners();
  }

  SearchModel? searchModel;
  HomeListingModel? homeListingModel;
  FilterModel? filterModel;
  List<Listing> list = [];

  Future getHomeData() async {
    try {
      log("$page $limit");
      homeListingModel = await HomeRepository().getHomeData(page, limit);

      changePageNumber();
      if (homeListingModel!.listings!.isEmpty) {
        topPostsRefreshController.loadNoData();
      } else {
        list.addAll(homeListingModel!.listings!);
        topPostsRefreshController.loadComplete();
      }
      notifyListeners();
    } catch (e) {
      topPostsRefreshController.loadFailed();
    }
  }

  Future getFilters() async {
    try {
      filterModel = await HomeRepository().getFilters(true);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future getSearch(String val) async {
    try {
      setBusy(true);
      searchModel = await HomeRepository().getSearch({"searchModel": val});
      log(searchModel!.makes!.toList().toString());
      setBusy(false);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
