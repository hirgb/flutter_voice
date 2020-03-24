import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  Indicator({Key key}) : super(key: key);

  @override
  IndicatorState createState() => IndicatorState();
}

class IndicatorState extends State<Indicator> {
  String voiceIco = "images/voice_volume_1.png";

  ///默认隐藏状态
  bool voiceState = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pos = Positioned(
      top: MediaQuery.of(context).size.height * 0.5 - 80,
      left: MediaQuery.of(context).size.width * 0.5 - 80,
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Opacity(
            opacity: 0.6,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Container(
                padding: EdgeInsets.all(30),
                child: new Image.asset(
                  voiceIco,
                  width: 100,
                  height: 100,
                  package: 'flutter_plugin_record',
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return pos;
  }

  updateStatus(double voiceData) {
    setState(() {
      if (voiceData > 0 && voiceData < 0.1) {
        voiceIco = "images/voice_volume_2.png";
      } else if (voiceData > 0.2 && voiceData < 0.3) {
        voiceIco = "images/voice_volume_3.png";
      } else if (voiceData > 0.3 && voiceData < 0.4) {
        voiceIco = "images/voice_volume_4.png";
      } else if (voiceData > 0.4 && voiceData < 0.5) {
        voiceIco = "images/voice_volume_5.png";
      } else if (voiceData > 0.5 && voiceData < 0.6) {
        voiceIco = "images/voice_volume_6.png";
      } else if (voiceData > 0.6 && voiceData < 0.7) {
        voiceIco = "images/voice_volume_7.png";
      } else if (voiceData > 0.7 && voiceData < 1) {
        voiceIco = "images/voice_volume_7.png";
      } else {
        voiceIco = "images/voice_volume_1.png";
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
