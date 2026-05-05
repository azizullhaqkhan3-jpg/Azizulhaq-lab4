import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentCourseApp(),
  ));
}

class StudentCourseApp extends StatefulWidget {
  const StudentCourseApp({super.key});

  @override
  State<StudentCourseApp> createState() => _StudentCourseAppState();
}

class _StudentCourseAppState extends State<StudentCourseApp> {

  int selectedIndex = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController courseController = TextEditingController();

  String studentName = "";

  List<String> courses = [
    "Flutter",
    "Python",
    "Java",
  ];

  //  HOME 
  Widget buildHomeTab() {
    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10)
              ],
            ),
            child: Column(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.white,
                    child: const Icon(Icons.school, size: 70),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Welcome Student",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Manage your courses easily",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // COURSES (CRUD)
  Widget buildCoursesTab() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [

          // Add Course Input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: courseController,
                  decoration: const InputDecoration(
                    labelText: "Add Course",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (courseController.text.isNotEmpty) {
                      courses.add(courseController.text);
                      courseController.clear();
                    }
                  });
                },
                child: const Text("Add"),
              )
            ],
          ),

          const SizedBox(height: 15),

          // Course List (CRUD)
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(courses[index]),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // EDIT
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () {
                            courseController.text = courses[index];
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Edit Course"),
                                content: TextField(
                                  controller: courseController,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        courses[index] =
                                            courseController.text;
                                        courseController.clear();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Save"),
                                  )
                                ],
                              ),
                            );
                          },
                        ),

                        // DELETE
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              courses.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //  PROFILE 
  Widget buildProfileTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Enter Name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              setState(() {
                studentName = nameController.text;
              });
            },
            child: const Text("Save"),
          ),

          const SizedBox(height: 20),

          Text(
            studentName.isEmpty
                ? "No Name Entered"
                : "Hello, $studentName , How are you Welcome to Students App👋",
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  // MAIN UI 
  @override
  Widget build(BuildContext context) {

    final pages = [
      buildHomeTab(),
      buildCoursesTab(),
      buildProfileTab()
    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text("Student Course App"),
        backgroundColor: Colors.blue,
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
          Icon(Icons.notifications),
          SizedBox(width: 10),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              title: const Text("Home"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text("Courses"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      body: pages[selectedIndex],

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add course clicked")),
          );
        },
        child: const Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}