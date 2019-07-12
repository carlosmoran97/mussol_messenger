import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User{
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final List myChats;
  final DocumentReference reference;

  User({
    Key key,
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.photoUrl,
    this.myChats,
    this.reference,
  });

}