import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit_app/models/post.dart';
part 'api_service.g.dart';

final apiFutureProvider = FutureProvider((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.getPosts();
});

final apiServiceProvider = Provider((ref) => ApiService(Dio(BaseOptions(contentType: "application/json"))));

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/posts')
  Future<List<Post>> getPosts();
}