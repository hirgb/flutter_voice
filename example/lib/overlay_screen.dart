import 'package:flutter/material.dart';
import 'package:voice/voice.dart';

class OverLayScreen extends StatefulWidget {
  @override
  _OverLayScreenState createState() => _OverLayScreenState();
}

class _OverLayScreenState extends State<OverLayScreen> {
  startRecord() {
    print("#开始录制");
  }

  stopRecord(data) {
    print("#结束束录制");
    print("#音频文件位置" + data.path);
    print("#音频录制时长" + data.audioTimeLength.toString());
  }

  @override
  void initState() {
    super.initState();
    VoiceRecorder.init(startCallBack: startRecord, stopCallBack: stopRecord);
  }

  @override
  Widget build(BuildContext context) {
    return Voice(
      child: Scaffold(
        appBar: AppBar(
          title: Text("仿微信发送语音"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.voice_chat, size: 36),
                onTapDown: (td) => VoiceRecorder.start(),
                onTapUp: (tu) => VoiceRecorder.stop(),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    VoiceRecorder.dispose();
    super.dispose();
  }
}
