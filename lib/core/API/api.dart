
import 'package:mobile_listing_app/model/filter_model.dart';
import 'package:mobile_listing_app/model/home_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../model/search_model.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://dev2be.oruphones.com/api/v1/global/assignment/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("getListings")
  Future<HomeListingModel> getHomeData(@Query("page") int page,@Query("limit") int limit);
  
  @GET("getFilters")
  Future<FilterModel> getFilters(@Query("isLimited") bool limit);
  
  @POST("searchModel")
  Future<SearchModel> getSearch(@Body() Map<String, dynamic> body);


}
