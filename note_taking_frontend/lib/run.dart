import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

String globaluserid = "";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartingScreen(),
    );
  }
}

class LoginOptions extends StatelessWidget {
  const LoginOptions({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 350,
            height: 450,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 130, bottom: 15),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Radius of the button
                              ),
                              fixedSize: Size(250, 75), // Size of the button
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0), // Radius of the button
                            ),
                            fixedSize: Size(250, 75), // Size of the button
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool allInputsFilled = false;

  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginOptions()));
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 350,
            height: 400,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Enter your details",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: SizedBox(
                            width: 272,
                            height: 62,
                            child: TextField(
                              onChanged: (_) {
                                validateAllInputsFilled();
                              },
                              controller: userIdController,
                              decoration: InputDecoration(
                                hintText: "User id",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      // color: Color.fromRGBO(14, 100, 209, 100),
                                      ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      // color: Color.fromRGBO(14, 100, 209, 1),
                                      ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  // color: const Color.fromRGBO(173, 176, 191, 100),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: SizedBox(
                            width: 272,
                            height: 62,
                            child: TextField(
                              onChanged: (_) {
                                validateAllInputsFilled();
                              },
                              obscureText: !isPasswordVisible,
                              controller: passwordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    // color: const Color.fromRGBO(173, 176, 191, 100),
                                  ),
                                ),
                                hintText: "Password",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      // color: Color.fromRGBO(14, 100, 209, 100),
                                      ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      // color: Color.fromRGBO(14, 100, 209, 1),
                                      ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  // color: const Color.fromRGBO(173, 176, 191, 100),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (allInputsFilled) {
                                String userId = userIdController.text;
                                String password = passwordController.text;

                                // Make a GET request to the backend
                                Uri url = Uri.parse(
                                    'http://127.0.0.1:8000/note-taking/users/$userId/');
                                var response = await http.get(url);

                                if (response.statusCode == 200) {
                                  // Parse the response JSON
                                  Map<String, dynamic> responseData =
                                      jsonDecode(response.body);
                                  String correctPassword =
                                      responseData['password'];

                                  // Check if the password matches
                                  if (password == correctPassword) {
                                    globaluserid = userId;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Dashboard(
                                                  globalUserId: userId,
                                                )));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Invalid password or userid'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Failed to fetch user data'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Enter all fields'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(fontSize: 15),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Radius of the button
                              ),
                              fixedSize:
                                  const Size(185, 65), // Size of the button
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateAllInputsFilled() {
    setState(() {
      allInputsFilled = passwordController.text.isNotEmpty &&
          userIdController.text.isNotEmpty;
    });
  }
}

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Jot",
                  style: TextStyle(fontSize: 45),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginOptions()));
                      },
                      child: Text("Lets get started")),
                )
              ]),
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  final String globalUserId;

  const Dashboard({Key? key, required this.globalUserId}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions(String globalUserId) => <Widget>[
        TodoApp(),
        CategoriesList(
          userId: globalUserId,
        ),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions(widget.globalUserId).elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'ToDo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Notes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CategoriesList extends StatefulWidget {
  final String userId;

  CategoriesList({required this.userId});

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    String apiUrl =
        'http://127.0.0.1:8000/note-taking/users/${widget.userId}/categories/';

    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        print(apiUrl);
        categories = List<Map<String, dynamic>>.from(data);
        print(categories);
      });
    }
  }

  void _addNewCategory(BuildContext context) {
    TextEditingController _categoryNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Category'),
          content: TextField(
            controller: _categoryNameController,
            decoration: InputDecoration(hintText: 'Enter category name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String categoryName = _categoryNameController.text;
                if (categoryName.isNotEmpty) {
                  String apiUrl =
                      'http://127.0.0.1:8000/note-taking/categories/';
                  var response = await http.post(
                    Uri.parse(apiUrl),
                    body: json.encode(
                        {'category_name': categoryName, 'user': widget.userId}),
                    headers: {'Content-Type': 'application/json'},
                  );

                  if (response.statusCode == 201) {
                    _fetchCategories(); // Refresh the list of categories
                    Navigator.of(context).pop();
                  }
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(categories[index]["category_name"]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesList(
                    categoryId: categories[index]["id"],
                    userId: widget.userId,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewCategory(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CategoryBox extends StatefulWidget {
  final String categoryName;
  final VoidCallback? onTap;

  const CategoryBox({Key? key, required this.categoryName, this.onTap})
      : super(key: key);

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
      child: GestureDetector(
        onTap: widget.onTap,
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
      ),
    );
  }
}

class NotesList extends StatelessWidget {
  final int categoryId;
  final String userId;

  const NotesList({Key? key, required this.categoryId, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> notes = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text('Notes'),
            ),
            body: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]["heading"]),
                  subtitle: Text(notes[index]["text"]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteTakingScreen(
                          noteId: notes[index]["id"],
                          categoryId: categoryId,
                          initialTitle: notes[index]["heading"],
                          initialContent: notes[index]["text"],
                          userid: userId,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteTakingScreen(
                      categoryId: categoryId,
                      userid: userId,
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> _fetchNotes() async {
    String apiUrl =
        'http://127.0.0.1:8000/note-taking/users/${userId}/categories/$categoryId/notes/';

    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to fetch notes');
    }
  }
}

class NoteTakingScreen extends StatefulWidget {
  final int? noteId;
  final int categoryId;
  final String? initialTitle;
  final String? initialContent;
  final String userid;

  const NoteTakingScreen({
    Key? key,
    this.noteId,
    required this.categoryId,
    required this.userid,
    this.initialTitle,
    this.initialContent,
  }) : super(key: key);

  @override
  _NoteTakingScreenState createState() => _NoteTakingScreenState();
}

class _NoteTakingScreenState extends State<NoteTakingScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? '';
    _contentController.text = widget.initialContent ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _titleController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter note title',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CategoriesList(userId: widget.userid),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveNote();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: NoteContent(contentController: _contentController),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showUrlDialog(context);
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Future<void> _showUrlDialog(BuildContext context) async {
    TextEditingController _urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter URL'),
          content: TextField(
            controller: _urlController,
            decoration: InputDecoration(hintText: 'URL'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String url = _urlController.text;

                // Send request to API endpoint
                var response = await http.post(
                  Uri.parse('http://127.0.0.1:8000/note-taking/extract-text/'),
                  body: json.encode({"image_url": url}),
                  headers: {'Content-Type': 'application/json'},
                );

                if (response.statusCode == 200) {
                  // Parse the response
                  Map<String, dynamic> responseData =
                      json.decode(response.body);
                  String extractedText = responseData['extracted_text'];
                  print(extractedText);
                  // Append the extracted text to the content
                  String currentContent = _contentController.text;
                  String updatedContent = '$currentContent\n$extractedText';

                  print(updatedContent);

                  setState(() {
                    _contentController.text = updatedContent;
                  });

                  // Save the updated content to the backend
                  // _saveNote();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to extract text!')),
                  );
                }

                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveNote() async {
    String apiUrl =
        'http://127.0.0.1:8000/note-taking/users/${widget.userid}/categories/${widget.categoryId}/notes/';
    int noteId = widget.noteId ?? 0;

    var response = await http.put(
      Uri.parse('$apiUrl$noteId/'), // Use Uri.parse to construct the URL
      body: json.encode({
        'heading': _titleController.text,
        'text': _contentController.text,
        'tags': '123',
        'category': widget.categoryId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note saved!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save note!')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

class NoteContent extends StatefulWidget {
  final TextEditingController contentController;

  const NoteContent({Key? key, required this.contentController})
      : super(key: key);

  @override
  _NoteContentState createState() => _NoteContentState();
}

class _NoteContentState extends State<NoteContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
      ),
      child: TextField(
        controller: widget.contentController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Write your note here...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}

class FlashCardScreen extends StatefulWidget {
  @override
  _FlashCardScreenState createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  List<Map<String, String>> flashcards = [
    {
      'What is Flutter?':
          'Flutter is a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.'
    },
    {
      'What is Dart?':
          'Dart is a client-optimized programming language for apps on multiple platforms.'
    },
    // Add more questions and answers as needed
  ];

  int currentIndex = 0;
  bool isQuestionDisplayed = true;

  void showAnswer() {
    setState(() {
      isQuestionDisplayed = false;
    });
  }

  void showQuestion() {
    setState(() {
      isQuestionDisplayed = true;
    });
  }

  void goToNextCard() {
    setState(() {
      if (currentIndex < flashcards.length - 1) {
        currentIndex++;
        isQuestionDisplayed = true;
      }
    });
  }

  void goToPreviousCard() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        isQuestionDisplayed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flash Cards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isQuestionDisplayed) {
                    showAnswer();
                  } else {
                    showQuestion();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      isQuestionDisplayed
                          ? flashcards[currentIndex].keys.first
                          : flashcards[currentIndex].values.first,
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: goToPreviousCard,
                  child: Icon(Icons.arrow_back),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
                ElevatedButton(
                  onPressed: goToNextCard,
                  child: Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Map<String, dynamic>> tasks = [
    {"work": "Task 1", "status": 0},
    {"work": "Task 2", "status": 0},
    {"work": "Task 3", "status": 0},
    // Add more tasks as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Sort tasks so that completed tasks come after incomplete tasks
    tasks.sort((a, b) => a['status'].compareTo(b['status']));

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              tasks[index]['work'] ?? '',
              style: TextStyle(
                decoration: tasks[index]['status'] == 1
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            leading: Checkbox(
              value: tasks[index]['status'] == 1,
              onChanged: (value) {
                setState(() {
                  tasks[index]['status'] = value! ? 1 : 0;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String newTask = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(hintText: 'Enter task name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.add({"work": newTask, "status": 0});
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
