import 'package:flutter/material.dart';

import 'core/network/http_client.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/datasources/product_cache_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/viewmodels/product_viewmodel.dart';
import 'presentation/pages/product_page.dart';

void main() {
  runApp(const MyApp());
}

/// Main application widget that sets up dependency injection.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set up dependency injection (manual DI)

    // 1. Create HttpClient
    final httpClient = HttpClient();

    // 2. Create datasources
    final remoteDatasource = ProductRemoteDatasource(httpClient: httpClient);
    final cacheDatasource = ProductCacheDatasource();

    // 3. Create repository
    final repository = ProductRepositoryImpl(
      remoteDatasource: remoteDatasource,
      cacheDatasource: cacheDatasource,
    );

    // 4. Create ViewModel
    final viewModel = ProductViewModel(repository: repository);

    // 5. Load products on startup
    viewModel.loadProducts();

    return MaterialApp(
      title: 'Products App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductPage(viewModel: viewModel),
    );
  }
}
