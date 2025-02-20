import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Todo {
  final String title;
  final String description;
  final bool completed;
  final String id;
  final Timestamp timeStamp;

  // Constructor
  Todo({
    required this.title,
    required this.description,
    required this.completed,
    required this.id,
    required this.timeStamp,
  });
}
