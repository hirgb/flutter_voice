import 'package:flutter/material.dart';
import './voice_recorder.dart';

class Voice extends StatefulWidget {
  final Widget child;

  const Voice({Key key, @required this.child}) : super(key: key);

  @override
  _VoiceState createState() {
    return _VoiceState();
  }
}

class _VoiceState extends State<Voice> {
  @override
  Widget build(BuildContext context) {
    VoiceRecorder.instance.context = context;
    return widget.child;
  }
}
