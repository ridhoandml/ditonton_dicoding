import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:http/http.dart' as http;

abstract class TVRemoteDataSource {
  // TODO: Step 2 -> Buat API GET
  Future<List<TVModel>> getOnTheAirTVShows();
  Future<List<TVModel>> getPopularTVShows();
  Future<List<TVModel>> getTopRatedTVShows();
  Future<TVDetailResponse> getTVShowDetail(int id);
  Future<List<TVModel>> getTVShowsRecomendation(int id);
  Future<List<TVModel>> searchTVShows(String query);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVModel>> getOnTheAirTVShows() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTVShows() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTVShows() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVDetailResponse> getTVShowDetail(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TVDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<TVModel>> getTVShowsRecomendation(int id) async{
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if(response.statusCode == 200){
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  Future<List<TVModel>> searchTVShows(String query) async{
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if(response.statusCode == 200){
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
