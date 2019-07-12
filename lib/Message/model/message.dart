import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message{
  final DateTime dateSended;
  final DocumentReference from;
  final DocumentReference to;
  final String content;
  final DocumentReference chat;
  Message({
    Key key,
    @required this.dateSended,
    @required this.from,
    @required this.to,
    @required this.content,
    @required this.chat,
  });
}