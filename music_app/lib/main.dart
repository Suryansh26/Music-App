import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:convert';

import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlanSDK Flutter',
      home: MyHomePage(title: 'AlanSDK Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    /// Init Alan Button with project key from Alan Studio - https://studio.alan.app
    AlanVoice.addButton(
        "8e0b083e795c924d64635bba9c3571f42e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// ... or init Alan Button with project key and additional params
    // var params = jsonEncode({"uuid":"111-222-333-444"});
    // AlanVoice.addButton("8e0b083e795c924d64635bba9c3571f42e956eca572e1d8b807a3e2338fdd0dc/stage", authJson: params);

    /// Set log level - "all", "none"
    AlanVoice.setLogLevel("none");

    /// Add button state handler
    AlanVoice.onButtonState.add((state) {
      debugPrint("got new button state ${state.name}");
    });

    /// Add command handler
    AlanVoice.onCommand.add((command) {
      debugPrint("got new command ${command.toString()}");
    });

    /// Add event handler
    AlanVoice.onEvent.add((event) {
      debugPrint("got new event ${event.data.toString()}");
    });

    /// Activate Alan Buttons
    void _activate() {
      AlanVoice.activate();
    }

    /// Deactivate Alan Button
    void _deactivate() {
      AlanVoice.deactivate();
    }

    /// Play any text via Alan Button
    void _playText() {
      /// Provide text as string param
      AlanVoice.playText("Hello from Alan");
    }

    /// Execute any command locally (and handle it with onCommand callback)
    void _playCommand() {
      /// Provide any params with json
      var command = jsonEncode({"command": "commandName"});
      AlanVoice.playCommand(command);
    }

    /// Call project API from Alan Studio script
    void _callProjectApi() {
      /// Provide any params with json
      var params = jsonEncode({"apiParams": "paramsValue"});
      AlanVoice.callProjectApi("projectAPI", params);
    }

    /// Set visual state in Alan Studio script
    void _setVisualState() {
      /// Provide any params with json
      var visualState = jsonEncode({"visualState": "stateValue"});
      AlanVoice.setVisualState(visualState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Text(
          'Alan Button Example',
        ));
  }
}
