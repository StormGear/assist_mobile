import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:typesense/typesense.dart';

Future<void> typesense(String query) async {
  // Replace with your configuration
  final host = "velwu7fhs6c8bajqp-1.a1.typesense.net",
      protocol = Protocol.https;
  String? typesenseApiKey = dotenv.env['SEARCH_KEY'];
  final config = Configuration(
    // Api key
    typesenseApiKey ?? '',
    nodes: {
      Node(
        protocol,
        host,
        port: 443,
      )
    },
    numRetries: 3, // A total of 4 tries (1 original try + 3 retries)
    connectionTimeout: const Duration(seconds: 5),
  );

  final client = Client(config);

  final searchParameters = {
    'q': query,
    'query_by': 'name,description',
    'filter_by': '',
    'sort_by': '',
  };

  try {
    var response = await client
        .collection('service_categories')
        .documents
        .search(searchParameters);
    var results = response['hits'].map((e) => e['document']).toList();
    log('Response: $results');
  } catch (e) {
    log("Error: $e");
  }
}
