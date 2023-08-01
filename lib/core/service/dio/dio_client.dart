import 'package:chairil/core/app/endpoint.dart';
import 'package:chairil/domain/models/response_api.dart';
import 'package:chairil/domain/models/user_detail.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'dio_client.g.dart';

@RestApi(baseUrl: '')
abstract class DioClient {
  factory DioClient(Dio dio, {String baseUrl}) = _DioClient;

  @GET(Endpoint.user)
  Future<ResponseApi> userList({@Query('page') int? page, @Query('limit') int? limit});

  @GET(Endpoint.user)
  Future<UserDetail> userDetail(@Path() String id);

  @GET(Endpoint.user)
  Future<ResponseApi> userPost(@Path() String id, {@Query('limit') int? limit, @Query('page') int? page});

  @GET(Endpoint.post)
  Future<ResponseApi> postList({@Query('page') int? page, @Query('limit') int? limit});

  @GET(Endpoint.tag)
  Future<ResponseApi> postListTag(@Path('tag') String? tag, {@Query('page') int? page, @Query('limit') int? limit});

  @GET(Endpoint.post)
  Future<ResponseApi> postComments(@Path('id') String? id, {@Query('limit') int? limit});
}
