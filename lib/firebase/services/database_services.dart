import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final Timestamp timeStamp;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.timeStamp,
  });
}

class DatabaseServices {
  final CollectionReference todoCollection = FirebaseFirestore.instance
      .collection('todos');

  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentReference> addTodoItem({
    required String title,
    required String description,
    required bool completed,
    required Timestamp timeStamp,
  }) async {
    if (user == null) throw Exception('User not signed in');

    return await todoCollection.add({
      'title': title,
      'description': description,
      'completed': completed,
      'timeStamp': timeStamp,
      'uid': user!.uid,
    });
  }

  Future<void> updateTodo(String id, String title, String description) async {
    return await todoCollection.doc(id).update({
      'title': title,
      'description': description,
    });
  }

  // Update the status
  Future<void> updateTodoStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({'completed': completed});
  }

  // Delete a todo item
  Future<void> deleteTodo(String id) async {
    return await todoCollection.doc(id).delete();
  }

  // Stream for pending todos
  Stream<List<Todo>> get pendingTodos {
    if (user == null) throw Exception('User not signed in');

    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  // Stream for completed todos
  Stream<List<Todo>> get completedTodos {
    if (user == null) throw Exception('User not signed in');

    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  // Helper method to convert Firestore snapshot into a list of Todo objects
  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return Todo(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        completed: doc['completed'] ?? false,
        timeStamp: doc['timeStamp'] ?? Timestamp.now(),
      );
    }).toList();
  }
}
