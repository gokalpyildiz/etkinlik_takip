import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  events,
  users;

  CollectionReference get reference => FirebaseFirestore.instance.collection(name);
}
