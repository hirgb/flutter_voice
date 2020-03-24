# voice

更方便的仿微信录音的插件

插件支持android 和IOS

## 插件提供的功能

- 录制语音
- 提供录制开始的监听
- 提供录制结束的监听
- 提供类似微信语音对话的录制组件

> 如需要使用基础功能请使用flutter_plugin_record插件。

本插件在flutter_plugin_record基础上进行了再次开发，主要进行了以下改进：

- 用户可以自定义触发控件
- 插件对自身功能进行取舍，只提供录制时组件和相关监听api

## 使用方法

1. 引入
    ```
    dependencies:
      voice: ^0.0.1
    ```
2. 在使用的页面进行导入package
   ```
   import 'package:voice/voice.dart';
   ```
3. 在使用的页面进行Voice包裹，并绑定事件
   ```
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
   ```
4. 初始化
   ```
    @override
    void initState() {
      super.initState();
      VoiceRecorder.init(startCallBack: startRecord, stopCallBack: stopRecord);
    }
   ```
5. 退出页面时销毁
   ```
   @override
   void dispose() {
     VoiceRecorder.dispose();
     super.dispose();
   }
   ```