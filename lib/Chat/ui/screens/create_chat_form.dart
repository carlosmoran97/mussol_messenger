import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Chat/model/chat.dart';
import 'package:messenger/Chat/bloc/chat_bloc.dart';

class CreateChatForm extends StatefulWidget {

  final List<DocumentReference> users;
  CreateChatForm({
    Key key,
    @required this.users,
  });

  @override
  _CreateChatFormState createState() => _CreateChatFormState();
}

class _CreateChatFormState extends State<CreateChatForm> {

  final _formKey = GlobalKey<FormState>();
  String subject = "";
  String content  = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Crear nuevo chat'),
      content: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.subject,
                ),
                hintText: 'Asunto'
              ),
              validator: (String value){
                if(value.isEmpty){
                  return 'Este campo es obligatorio';
                }
                return null;
              },
              onSaved: (String value){
                subject = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.message,
                ),
                hintText: 'Mensaje'
              ),
              maxLines: 4,
              validator: (String value){
                if(value.isEmpty){
                  return 'Este campo es obligatorio';
                }
                return null;
              },
              onSaved: (String value){
                content = value;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: (){
            if(_formKey.currentState.validate()){
              _formKey.currentState.save();
              Navigator.pop(context);
              Chat chat = Chat(
                subject: subject,
                users: widget.users
              );
              chatBloc.createFirebaseChat(chat, content);
              Navigator.pop(context);
            }
          },
          child: Text(
            'Enviar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).primaryColor,
        ),
        RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.red,
        ),
      ],
    );
  }
}
