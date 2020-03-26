import 'package:flutter/material.dart';
import 'package:flutter_plugin_record/flutter_plugin_record.dart';
import './indicator.dart';

class VoiceRecorder {
  BuildContext context;

  Indicator _indicator;
  GlobalKey<IndicatorState> _indicatorKey;
  FlutterPluginRecord recordPlugin;
  Function startCallback;
  Function stopCallback;

  OverlayEntry _overlayEntry;

  static VoiceRecorder _instance;

  factory VoiceRecorder() => _getInstance();
  static VoiceRecorder get instance => _getInstance();

  VoiceRecorder._internal() {}

  static VoiceRecorder _getInstance() {
    if (_instance == null) {
      _instance = VoiceRecorder._internal();
    }
    return _instance;
  }

  static start({Function startCallback}) {
    _getInstance().startCallback = startCallback;
    if (_getInstance()._indicator == null) {
      GlobalKey<IndicatorState> indicatorKey = GlobalKey<IndicatorState>();
      Widget indicator = Indicator(
        key: indicatorKey,
      );

      _getInstance()._indicatorKey = indicatorKey;
      _getInstance()._indicator = indicator;
    }
    _getInstance()._show(_getInstance()._indicator);

    _getInstance().recordPlugin.start();
  }

  static stop({Function stopCallback}) async {
    _getInstance().stopCallback = stopCallback;
    _getInstance()._hide();
    if (_getInstance().recordPlugin != null) {
      await _getInstance().recordPlugin.stop();
      dispose();
    }
  }

  static dispose() {
    removeCallback();
    if (_getInstance().recordPlugin != null) {
      _getInstance().recordPlugin.dispose();
      _getInstance().recordPlugin = null;
    }
  }

  static removeCallback() {
    _getInstance().startCallback = null;
    _getInstance().stopCallback = null;
  }

  _show(Widget w) {
    if (_overlayEntry == null) {
      _overlayEntry = new OverlayEntry(builder: (BuildContext context) {
        return w;
      });
      Overlay.of(context).insert(_overlayEntry);
    }
  }

  _hide() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }

  ///初始化语音录制的方法
  static init() {
    if (_getInstance().recordPlugin == null) {
      _getInstance().recordPlugin = new FlutterPluginRecord();

      ///初始化方法的监听
      _getInstance().recordPlugin.responseFromInit.listen((data) {
        if (data) {
          print("初始化成功");
        } else {
          print("初始化失败");
        }
      });

      /// 开始录制或结束录制的监听
      _getInstance().recordPlugin.response.listen((data) {
        if (data.msg == "onStop") {
          ///结束录制时会返回录制文件的地址方便上传服务器
          print("onStop  " + data.path);
          if (_getInstance().stopCallback != null) {
            _getInstance().stopCallback(data);
          }
        } else if (data.msg == "onStart") {
          print("onStart --");
          if (_getInstance().startCallback != null) {
            _getInstance().startCallback();
          }
        }
      });

      ///录制过程监听录制的声音的大小 方便做语音动画显示图片的样式
      _getInstance().recordPlugin.responseFromAmplitude.listen((data) {
        var voiceData = double.parse(data.msg);
        _getInstance()._indicatorKey.currentState?.updateStatus(voiceData);
        print("振幅大小   " + voiceData.toString());
      });
      _getInstance().recordPlugin.init();
    }
  }
}
