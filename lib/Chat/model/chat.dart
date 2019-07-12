import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat{
  final String id;
  final String subject;
  final DocumentReference lastMessage;
  final List<dynamic> users;
  final DocumentReference reference;

  Chat({
    Key key,
    @required this.subject,
    @required this.users,
    this.id,
    this.lastMessage,
    this.reference
  });

}