import 'dart:io';

import "package:flutter/material.dart";
import "user_info.dart";

class PictureNotUpload extends StatefulWidget {
  const PictureNotUpload({Key? key}) : super(key: key);

  @override
  State<PictureNotUpload> createState() => _PictureNotUpload();
}

class _PictureNotUpload extends State<PictureNotUpload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(80),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            child:Icon(
              Icons.add_a_photo,
            ),
          ),
          Container(
            child: Text("main photo"),
          ),
        ],
      ),
    );
  }
  //              child: (_image!=null)?Image.file(_image!, fit: BoxFit.fill,)
//                 :
}

class PictureUploaded extends StatefulWidget {
  final File image;

  const PictureUploaded({Key? key, this.image}) : super(key: key);

  @override
  State<PictureUploaded> createState() => _PictureUploadedState();
}

class _PictureUploadedState extends State<PictureUploaded> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(80),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        color: Colors.white,
      ),
      child: FittedBox(
        child: Image.file(widget.image, fit: BoxFit.fill,)
        ),
      );
  }
}

