# RetrofitでAPIを叩く

## 必要なパッケージを追加
バージョンを合わせないと競合が起きるので、FreezedとRetrofitに関係したパッケージは、適正なバージョンに合わせる

## ListViewを使った例
```dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_app/models/post.dart';
import 'package:retrofit_app/service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Retrofit App',
        ),
      ),
      body: FutureBuilder(
        future: apiService.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data as List<Post>;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
```

## ListTilを使わない例
```dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_app/models/post.dart';
import 'package:retrofit_app/service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Retrofit App',
        ),
      ),
      body: _body(apiService: apiService),
    );
  }
}

class _body extends StatelessWidget {
  const _body({
    super.key,
    required this.apiService,
  });

  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final posts = snapshot.data as List<Post>;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black38,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      post.body,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
```