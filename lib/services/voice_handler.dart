import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart';

class VoiceHandler {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  Future<void> startListening({
    required Function(String) onResult,
    required Function onComplete,
  }) async {
    _speechToText.listen(
      onResult: (result) {
        onResult(result.recognizedWords);

        if (result.finalResult) {
          onComplete();
        }
      },
    );
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  SpeechToText get speechToText => _speechToText;
  bool get isEnabled => _speechEnabled;
}
