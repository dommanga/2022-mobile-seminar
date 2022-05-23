import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'movie_api.g.dart';

@RestApi(baseUrl: "https://www.tvmaze.com/")
abstract class MovieRestClient {
  factory MovieRestClient(Dio dio, {String baseUrl}) = _MovieRestClient;

  @GET("/singlesearch/shows")
  Future<MovieInfo> getMovieInfo(
      @Query("q") String q,
      );
}

@JsonSerializable()
class MovieInfo {
  int? id;
  String? name;
  String? language;
  int? runtime;

  MovieInfo({
    this.id, this.name, this.language, this.runtime
});

  factory MovieInfo.fromJson(Map<String, dynamic> json) => _$MovieInfoFromJson(json);
}
