import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/firebase/services/database_services.dart';

class PendingWidgets extends StatefulWidget {
  const PendingWidgets({super.key});

  @override
  State<PendingWidgets> createState() => _PendingWidgetsState();
}

class _PendingWidgetsState extends State<PendingWidgets> {
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;
  final DatabaseServices databaseServices = DatabaseServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Column();
    //Work here
  }
}
