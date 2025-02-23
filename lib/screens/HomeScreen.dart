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

class _HomescreenState extends State<Homescreen> {
  int btnindex = 0;

  final widgets = [PendingWidgets(), CompletedWidgets()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        title: Text('To-Do-App', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await AuthServices().signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      btnindex = 0;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: btnindex == 0 ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: btnindex == 0 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color: btnindex == 0 ? Colors.white : Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      btnindex = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: btnindex == 1 ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: btnindex == 0 ? 14 : 16,
                          fontWeight: FontWeight.w500,
                          color: btnindex == 1 ? Colors.white : Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            widgets[btnindex],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
