
import 'package:dio/dio.dart';
import 'package:mobile_listing_app/model/filter_model.dart';
import 'package:mobile_listing_app/model/home_model.dart';
import 'package:mobile_listing_app/model/search_model.dart';

import '../API/api.dart';

class HomeRepository {
  final dio = Dio();

  Future<HomeListingModel> getHomeData(int page,int limit) async {
    final client = RestClient(dio);
    return client.getHomeData(page,limit);
  }  
  
  Future<FilterModel> getFilters(bool limit) async {
    final client = RestClient(dio);
    return client.getFilters(limit);
  }  
  
  Future<SearchModel> getSearch(Map<String,dynamic> body) async {
    final client = RestClient(dio);
    return client.getSearch(body);
  }
}
