import 'package:google_generative_ai/google_generative_ai.dart';

class AIHandler {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: "AIzaSyDirJSA6GrpOw40XMVFTVG5uSw5TZ28Oc0",
  );

  Future<String> getResponse(String message) async {
    try {
      final prompt = message;
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return (response.text!);
    } catch (e) {
      return 'Bad response: ${e.toString()}';
    }
  }
}
