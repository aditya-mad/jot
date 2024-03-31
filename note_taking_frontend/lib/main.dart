import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchCategories(
              'http://127.0.0.1:8000/note-taking/users/1/categories/'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CategoriesList(categories: snapshot.data!, userId: '1233');
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                      'Failed to load categories. Error: ${snapshot.error}'));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchCategories(String url) async {
    final response = await http.get(Uri.parse(url));
    print("hello");
    if (response.statusCode == 200) {
      final List<dynamic> categories = jsonDecode(response.body);
      print("hello");
      categories.forEach((category) {
        print('Category ID: ${category['id']}');
        print('Category Name: ${category['category_name']}');
        print('User ID: ${category['user']}');
        print('');
      });
      return categories.cast<Map<String, dynamic>>();
    } else {
      throw Exception(
          'Failed to load categories. Error: ${response.statusCode}');
    }
  }
}

class CategoriesList extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final String userId;

  CategoriesList({required this.categories, required this.userId});

  @override
  Widget build(BuildContext context) {
    final userCategories =
        categories.where((category) => category["user"] == userId).toList();

    return ListView.builder(
      itemCount: (userCategories.length / 2).ceil(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (index * 2 < userCategories.length)
                _buildCategoryBox(userCategories[index * 2], index * 2),
              if (index * 2 + 1 < userCategories.length)
                _buildCategoryBox(userCategories[index * 2 + 1], index * 2 + 1),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryBox(Map<String, dynamic> category, int index) {
    return CategoryBox(
      categoryName: category["category_name"],
    );
  }
}

class CategoryBox extends StatefulWidget {
  final String categoryName;

  const CategoryBox({Key? key, required this.categoryName}) : super(key: key);

  @override
  _CategoryBoxState createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: _isHovered
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.translationValues(0, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.grey.withOpacity(0.5)
                  : Colors.transparent,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(20),
        child: Text(
          widget.categoryName,
          style: TextStyle(
            color: _isHovered ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }
}
