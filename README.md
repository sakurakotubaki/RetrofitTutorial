# RetrofitでAPIを叩く

## 必要なパッケージを追加
バージョンを合わせないと競合が起きるので、FreezedとRetrofitに関係したパッケージは、適正なバージョンに合わせる
```yaml
# This file configures the analyzer, which statically analyzes Dart code to
# check for errors, warnings, and lints.
#
# The issues identified by the analyzer are surfaced in the UI of Dart-enabled
# IDEs (https://dart.dev/tools#ides-and-editors). The analyzer can also be
# invoked from the command line by running `flutter analyze`.

# The following line activates a set of recommended lints for Flutter apps,
# packages, and plugins designed to encourage good coding practices.
include: package:flutter_lints/flutter.yaml

linter:
  # The lint rules applied to this project can be customized in the
  # section below to disable rules from the `package:flutter_lints/flutter.yaml`
  # included above or to enable additional rules. A list of all available lints
  # and their documentation is published at
  # https://dart-lang.github.io/linter/lints/index.html.
  #
  # Instead of disabling a lint rule for the entire project in the
  # section below, it can also be suppressed for a single line of code
  # or a specific dart file by using the `// ignore: name_of_lint` and
  # `// ignore_for_file: name_of_lint` syntax on the line or in the file
  # producing the lint.
  rules:
    # avoid_print: false  # Uncomment to disable the `avoid_print` rule
    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule

# Additional information about this file can be found at
# https://dart.dev/guides/language/analysis-options
```

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