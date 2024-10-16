import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:system_auth/config.dart';
import 'package:system_auth/screens/home/profile/userprofile.dart';
import 'package:system_auth/screens/home/topics.dart';
import 'package:system_auth/trialpages/settings.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _PamelaState();
}

class _PamelaState extends State<Homepage> {
  int _selectedIndex = 0;
  late Future<List<Subject>> _subjectsFuture;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _firstName;

  @override
  void initState() {
    super.initState();
    _subjectsFuture = _fetchSubjects();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final sessionCookie = await _storage.read(key: 'session_cookie');
      if (sessionCookie == null) {
        throw Exception('No session cookie found');
      }

      final response = await http.get(
        Uri.parse('$BASE_URL/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': sessionCookie,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final username = data['username'] as String;
        setState(() {
          _firstName = username.split(' ')[0]; // Get the first name from the username
        });
      } else {
        print('Failed to load user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<List<Subject>> _fetchSubjects() async {
    try {
      final sessionCookie = await _storage.read(key: 'session_cookie');
      if (sessionCookie == null) {
        throw Exception('No session cookie found');
      }

      final response = await http.get(
        Uri.parse('$BASE_URL/subjects'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': sessionCookie,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Subject.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load subjects. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching subjects: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F2),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(subjectsFuture: _subjectsFuture, firstName: _firstName),
          const ProfilePage(),
           SettingsPage(),
          
           
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF6200EE),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 23, 21, 178),
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Future<List<Subject>> subjectsFuture;
  final String? firstName;

  const HomeScreen({Key? key, required this.subjectsFuture, this.firstName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '👋 Hi there ${firstName ?? 'User'},',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        'Great to see you again!',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Colors.lime,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 42.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildStatSection(),
              const SizedBox(height: 20),
              _buildCourseSection(),
              const SizedBox(height: 20),
              _buildSubjectsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(4, 133, 162, 1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSingleStatCard('0', 'Points Earned', Colors.orange),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildSingleStatCard(String value, String label, Color color) {
    String imagePath = 'assets/star.gif'; // Default static image

    // Use different image paths based on the label or any other identifier
    if (label == 'Exp. Points') {
      imagePath = 'assets/star.gif'; // Replace with your static image for Exp. Points
    } else if (label == 'Questions Done') {
      imagePath = 'assets/soma1.png'; // Replace with your static image for Ranking
    }

    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 32,
          height: 32,
          color: color,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCourseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Practice More'),
        _buildDailyQuizCard(),
        const SizedBox(height: 20),
        _buildSectionTitle('Subjects'),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.brown,
      ),
    );
  }

  Widget _buildDailyQuizCard() {
    double quizProgress = 0.1; // Replace with actual progress value

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily Quiz',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                'Predictable Questions',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: 45.0,
            lineWidth: 12.0,
            animation: true,
            percent: quizProgress,
            center: Text(
              '${(quizProgress * 100).toInt()}%',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            progressColor: Colors.lime,
            backgroundColor: Colors.white,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsSection(BuildContext context) {
    return FutureBuilder<List<Subject>>(
      future: subjectsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching subjects: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No subjects available.'));
        } else {
          return _buildSubjectsList(snapshot.data!, context);
        }
      },
    );
  }

  Widget _buildSubjectsList(List<Subject> subjects, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopicsPage(
                  subjectId: subject.id,
                  subjectName: subject.name ?? 'No name',
                ),
              ),
            );
          },
          child: Card(
            child: ListTile(
              title: Text(
                subject.name ?? 'No name',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
              subtitle: Text(
                subject.description ?? '0 questions done',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        );
      },
    );
  }
}


class Subject {
  final String? name;
  final String? description;
  final int id;
  final int grade;

  Subject({this.name, this.description, required this.id, required this.grade});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      name: json['name'] as String?,
      description: json['description'] as String?,
      id: json['id'],
      grade: json['grade'],
    );
  }
}





