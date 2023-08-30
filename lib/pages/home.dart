import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit_app/service/api_service.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiService = ref.watch(apiFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Retrofit Riverpod',
        ),
      ),
      body: apiService.when(
        data: (data) {
          final posts = data;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
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
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      post.body,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
       error: (e, s) => Center(
          child: Text(e.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        ),
    );
  }
}
