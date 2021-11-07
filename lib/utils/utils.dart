import 'package:flutter/material.dart';

class Utils{
  static showSnackBar(BuildContext context, String message,
      {SnackBarAction? snackBarAction, int? durationInMiliseconds}) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      action: snackBarAction,
      duration: Duration(milliseconds: durationInMiliseconds?? 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } 
}