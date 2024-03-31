import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://127.0.0.1:8000/note-taking/categories/",
        ),
      );
      print(response);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // return data;
        // if (data.containsKey('jobs')) {
        //   setState(() {
        //     jobs = data['jobs'];
        //     tjobs = List.from(jobs); // Store a copy of the original list
        //   });
        // } else {
        //   throw Exception('Jobs not found in the response');
        // }
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      print('Error fetching jobs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Text("zdf"),
          ElevatedButton(
              onPressed: () {
                fetchJobs();
              },
              child: Text("data"))
        ]),
      ),
    );
  }
}
