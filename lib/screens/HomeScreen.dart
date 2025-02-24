import 'package:flutter/material.dart';
import 'package:todoapp/firebase/services/auth_services.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/widgets/completed_widgets.dart';
import 'package:todoapp/widgets/pending_widgets.dart';
import 'package:todoapp/widgets/taskDialog.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State {
  int btnindex = 0;

  final widgets = [PendingWidgets(), CompletedWidgets()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Karya Zenith',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              // Show confirmation dialog
              bool confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF1A1F38),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C27B0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ) ?? false;
              
              if (confirm) {
                await AuthServices().signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF2E1437).withOpacity(0.9),
              const Color(0xFF0A0E21).withOpacity(0.95),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: Text(
                  btnindex == 0 ? 'My Tasks' : 'Completed Tasks',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                child: Text(
                  btnindex == 0
                      ? 'Manage your priorities effectively'
                      : 'Tasks you\'ve accomplished',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1F38).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.purple.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                btnindex = 0;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: btnindex == 0
                                    ? const Color(0xFF9C27B0)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: btnindex == 0
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFF9C27B0)
                                              .withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  'Pending',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: btnindex == 0
                                        ? Colors.white
                                        : Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                btnindex = 1;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: btnindex == 1
                                    ? const Color(0xFF9C27B0)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: btnindex == 1
                                    ? [
                                        BoxShadow(
                                          color: const Color(0xFF9C27B0)
                                              .withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: btnindex == 1
                                        ? Colors.white
                                        : Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(child: widgets[btnindex]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskDialog(context);
        },
        backgroundColor: const Color(0xFF9C27B0),
        child: const Icon(Icons.add, color: Colors.white),
        elevation: 6,
      ),
    );
  }
}