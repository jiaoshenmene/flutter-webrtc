import 'dart:async';

import 'package:flutter/services.dart';
import 'utils.dart';

class MediaStreamTrack {
  MethodChannel _channel = WebRTC.methodChannel();
  String _trackId;
  String _label;
  String _kind;
  bool _enabled;

  MediaStreamTrack(this._trackId, this._label, this._kind, this._enabled);

  set enabled(bool enabled) {
    _channel.invokeMethod('mediaStreamTrackSetEnable',
        <String, dynamic>{'trackId': _trackId, 'enabled': enabled});
    _enabled = enabled;
  }

  bool get enabled => _enabled;

  String get label => _label;

  String get kind => _kind;

  String get id => _trackId;

  ///Future contains isFrontCamera
  ///Throws error if switching camera failed
  Future<bool> switchCamera() => _channel.invokeMethod(
        'mediaStreamTrackSwitchCamera',
        <String, dynamic>{'trackId': _trackId},
      );

  Future<bool> switchAudioPort() => _channel.invokeMethod(
      'mediaStreamTrackSwitchAudioPort',
      <String, dynamic>{'trackId': _trackId});

  void setVolume(double volume) async {
    await _channel.invokeMethod(
      'setVolume',
      <String, dynamic>{'trackId': _trackId, 'volume': volume},
    );
  }

  captureFrame(String filePath) => _channel.invokeMethod(
        'captureFrame',
        <String, dynamic>{'trackId': _trackId, 'path': filePath},
      );

  Future<void> dispose() async {
    await _channel.invokeMethod(
      'trackDispose',
      <String, dynamic>{'trackId': _trackId},
    );
  }
}
