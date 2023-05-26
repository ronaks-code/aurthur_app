import 'package:flutter/material.dart';
import '../services/api_key.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:just_audio/just_audio.dart';

class CreatorScreen extends StatefulWidget {
  const CreatorScreen({Key? key}) : super(key: key);

  @override
  _CreatorScreenState createState() => _CreatorScreenState();
}

class _CreatorScreenState extends State<CreatorScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  final TextEditingController _textEditingController = TextEditingController();
  String _selectedVoice = 'Choose Voice:';
  final bool _isGenerating = false;

  // Future<void> _generateVoice() async {
  //   setState(() {
  //     _isGenerating = true;
  //   });

  //   // Make HTTP request to ElevenLabs API
  //   const apiKey = '2a99b455173191d1f7ece6e2bafcbc7e';
  //   final text = _textEditingController.text;
  //   final selectedVoice = _selectedVoice.substring(3); // Remove "AI " from the voice name
  //   final url = 'https://api.elevenlabs.io/voice?text=$text&voice=$selectedVoice';
  //   final response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer $apiKey'});

  //   if (response.statusCode == 200) {
  //     // Successful response
  //     // TODO: Process the voice generation response and play the audio
  //     final audioUrl = response.body;
  //     final audioPlayer = AudioPlayer();
  //     await audioPlayer.play(UrlSource(audioUrl));
  //   } else {
  //     // Error occurred
  //     // TODO: Handle the error gracefully (e.g., show an error message)
  //     print('Error: ${response.statusCode}');
  //   }

  //   setState(() {
  //     _isGenerating = false;
  //   });
  // }

  // void _generateVoice() async {
  //   String selectedVoice = _selectedVoice;
  //   String apiKey = '2a99b455173191d1f7ece6e2bafcbc7e';
  //   String url = 'https://api.elevenlabs.io/v1/voice';
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $apiKey',
  //   };

  //   http.Response response = await http.get(
  //     Uri.parse(url),
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     List<dynamic> voicesData = jsonDecode(response.body);
  //     Map<String, dynamic>? selectedVoiceData;
  //     for (var voiceData in voicesData) {
  //       if (voiceData['name'] == selectedVoice) {
  //         selectedVoiceData = voiceData;
  //         break;
  //       }
  //     }

  //     if (selectedVoiceData != null) {
  //       String voiceId = selectedVoiceData['id'];
  //       String generationUrl = 'https://api.elevenlabs.io/v1/generate/$voiceId';
  //       Map<String, dynamic> requestBody = {
  //         'text': _textEditingController.text,
  //       };

  //       http.Response generationResponse = await http.post(
  //         Uri.parse(generationUrl),
  //         headers: headers,
  //         body: jsonEncode(requestBody),
  //       );

  //       if (generationResponse.statusCode == 200) {
  //         Map<String, dynamic> generationData = jsonDecode(generationResponse.body);
  //         String voiceUrl = generationData['audio_url'];

  //         AudioPlayer audioPlayer = AudioPlayer();
  //         await audioPlayer.play(UrlSource(voiceUrl));
  //       } else {
  //         print('Failed to generate voice. Status code: ${generationResponse.statusCode}');
  //       }
  //     } else {
  //       print('Selected voice not found');
  //     }
  //   } else {
  //     print('Failed to retrieve voices. Status code: ${response.statusCode}');
  //   }
  // }

  // TODO: Uncomment below
  // void _generateVoice() async {
  //   setState(() {
  //     _isGenerating = true;
  //   });

  //   // TODO: Show a pop up error message if the user doesn't select a voice
  //   String selectedVoice = _selectedVoice;
  //   String apiKey = '3b2531e3c66467ebdfb46e4bda7e18cf';
  //   String url = 'https://api.elevenlabs.io/v1/voices';
  //   Map<String, String> headers = {
  //     'Accept': 'audio/mpeg',
  //     'xi-api-key': apiKey,
  //     'Content-Type': 'application/json',
  //   };

  //   http.Response response = await http.get(
  //     Uri.parse(url),
  //     headers: headers,
  //   );

  //   // print(response.body);

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = jsonDecode(response.body);
  //     List<dynamic> voicesData = responseData['voices'];
  //     Map<String, dynamic>? selectedVoiceData;
  //     for (var voiceData in voicesData) {
  //       if (voiceData['name'] == selectedVoice) {
  //         selectedVoiceData = voiceData;
  //         break;
  //       }
  //     }

  //     // print(selectedVoiceData);

  //     if (selectedVoiceData != null) {
  //       String voiceId = selectedVoiceData['voice_id'];
  //       String generationUrl =
  //           'https://api.elevenlabs.io/v1/text-to-speech/$voiceId';
  //       // Map<String, dynamic> requestBody = {
  //       //   'text': _textEditingController.text,
  //       //   'model_id': 'eleven_monolingual_v1',
  //       //   'voice_settings': {
  //       //     'stability': 0,
  //       //     'similarity_boost': 0
  //       //   }
  //       // };
  //       Map<String, dynamic> requestBody = {
  //         'text': _textEditingController.text,
  //         'voice_id': voiceId,
  //         'voice_settings': {
  //           'stability': 0.5,
  //           'similarity_boost': 0.5,
  //         }
  //       };

  //       // print(voiceId);

  //       // print("This is request body $requestBody");
  //       // print(jsonEncode(requestBody));

  //       http.Response generationResponse = await http.post(
  //         Uri.parse(generationUrl),
  //         headers: headers,
  //         body: jsonEncode(requestBody),
  //       );

  //       // print(generationResponse.body);

  //       print('Status code: ${generationResponse.statusCode}');
  //       // print(jsonDecode(generationResponse.body)['audio_url']);

  //       // print('Raw response body: ${generationResponse.body}');
  //       // print(generationResponse.statusCode);

  //       // print('Response body: ${generationResponse.body}');
  //       // Decode the response body
  //       // dynamic decodedBody = jsonDecode(generationResponse.body);
  //       // print('Decoded body: $decodedBody');

  //       // print('Raw response body: ${generationResponse.bodyBytes}');

  //       // print("This is generation response $generationResponse");

  //       if (generationResponse.statusCode == 200) {
  //         // String responseBody = utf8.decode(generationResponse.bodyBytes);

  //         final appDir = await getApplicationDocumentsDirectory();
  //         print(appDir.path);
  //         final audioPath = '${appDir.path}/audio.mp3';
  //         final audioFile =
  //             await File(audioPath).writeAsBytes(generationResponse.bodyBytes);

  //         playAudioFile(audioPath);
  //         // Error occurs at this line
  //         // Map<String, dynamic> generationData = jsonDecode(responseBody);

  //         // String? voiceUrl = generationData['audio_url'];

  //         // if (voiceUrl != null) {
  //         //   http.Response audioResponse = await http.get(Uri.parse(voiceUrl));
  //         //   if (audioResponse.statusCode == 200) {
  //         //     final audioFile =
  //         //         await File(audioPath).writeAsBytes(audioResponse.bodyBytes);
  //         //     print(audioFile);
  //         //     print(audioFile.path);
  //         //     print(audioPath);
  //         //     playAudioFile(audioPath);
  //         //     // Now you have the audio file stored as a variable 'audioFile'
  //         //     // Do whatever you want with it
  //         //   } else {
  //         //     print(
  //         //         'Failed to download audio file. Status code: ${audioResponse.statusCode}');
  //         //   }
  //         // } else {
  //         //   print('Audio URL not found in generation response');
  //         // }
  //       } else {
  //         print(
  //             'Failed to generate voice. Status code: ${generationResponse.statusCode}');
  //       }
  //     } else {
  //       print('Selected voice not found');
  //     }
  //   } else {
  //     print('Failed to retrieve voices. Status code: ${response.statusCode}');
  //   }

  //   setState(() {
  //     _isGenerating = false;
  //   });
  // }

  // void playAudioFile(String audioFilePath) async {
  //   AudioPlayer audioPlayer = AudioPlayer();

  //   audioPlayer.play(UrlSource(audioFilePath));

  //   // You can also listen to player completion events
  //   audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  //     if (state == PlayerState.completed) {
  //       // Playback has finished
  //       // Add any necessary logic here
  //     }
  //   });
  // }
  // TODO: Uncomment to here

  // void _generateVoice() async {
  //   const scriptPath =
  //       'lib/components/elevenlabs_api.py'; // Replace with the actual path to the Python script

  //   final voice = _selectedVoice.replaceAll('Choose Voice:', '');
  //   final text = _textEditingController.text;

  //   try {
  // final result = await FlutterQpython.execute(scriptPath, arguments: [voice, text]);

  //     if (result != null) {
  //       // Do something with the result, if needed 
  //     }
  //   } on PlatformException catch (e) {
  //     print('Error executing Python script: ${e.message}');
  //   }
  // }

  Future<void> _generateVoice() async {
    String selectedVoice = _selectedVoice;
    String apiKey = API_KEY;
    String url = 'https://api.elevenlabs.io/v1/voices';
    Map<String, String> headers = {
      'accept': 'audio/mpeg',
      'xi-api-key': apiKey,
      'Content-Type': 'application/json',
    };

    http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> voicesData = responseData['voices'];
      Map<String, dynamic>? selectedVoiceData;
      for (var voiceData in voicesData) {
        if (voiceData['name'] == selectedVoice) {
          selectedVoiceData = voiceData;
          break;
        }
      }

      if (selectedVoiceData != null) {
        String voiceId = selectedVoiceData['voice_id'];
        String generationUrl =
            'https://api.elevenlabs.io/v1/text-to-speech/$voiceId';
        Map<String, dynamic> requestBody = {
          'text': _textEditingController.text,
          'voice_id': voiceId,
          'voice_settings': {
            'stability': 0.5,
            'similarity_boost': 0.5,
          }
        };

        http.Response generationResponse = await http.post(
          Uri.parse(generationUrl),
          headers: headers,
          body: json.encode(requestBody),
        );

        // print(generationResponse.statusCode);

        if (generationResponse.statusCode == 200) {
          // Handle the response
          // Uint8List audioData = response.bodyBytes;
          // File audioFile = await writeToFile(audioData);
          // playFile(audioFile);
          var bytes = generationResponse.bodyBytes;
          String dir = (await getApplicationDocumentsDirectory()).path;
          File file = File('$dir/audio.mp3');
          // print(file);
          await file.writeAsBytes(bytes);
          print(file.path);

          // Play the audio
          await playAudio(file.path);

        } else {
          // Handle the error
          throw Exception(
              'Failed to generate voice. Status code: ${generationResponse.statusCode}');
        }
      }
    }
  }

  Future<void> playAudio(String url) async {
    await audioPlayer.play(UrlSource(url));
  }

  // Future<File> writeToFile(Uint8List data) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final filePath = '${directory.path}/audio.mp3';
  //   return File(filePath).writeAsBytes(data);
  // }

  // void playFile(File audioFile) async {
  //   AudioPlayer audioPlayer = AudioPlayer();
  //   await audioPlayer.play(UrlSource(audioFile.path));
  // }

  void _handleTap() {
    FocusScope.of(context).unfocus(); // Dismiss the keyboard
  }

  void _handleVerticalDrag(DragEndDetails details) {
    if (details.primaryVelocity! > 0) {
      // Swiped downwards
      FocusScope.of(context).unfocus(); // Dismiss the keyboard
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap, // Handle tap event to dismiss keyboard
      onVerticalDragEnd:
          _handleVerticalDrag, // Handle vertical drag event to dismiss keyboard
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F1F0),
        appBar: AppBar(
          title: const Text(
            'Creator',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFC58BE5),
                  Color(0xFFFFB7FD),
                  Color(0xFFA8C0EE),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Text',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      scrollPhysics: const ClampingScrollPhysics(),
                    ),
                    const SizedBox(height: 20.0),
                    DropdownButton<String>(
                      value: _selectedVoice,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.black),
                      underline: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFA8C0EE),
                              Color(0xFFEE92D0),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedVoice = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'Choose Voice:',
                          child: Text(
                            'Choose Voice:',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: 'AI Joe Rogan',
                          child: Text('AI Joe Rogan'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'AI Morgan Freeman',
                          child: Text('AI Morgan Freeman'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'AI Barack Obama',
                          child: Text('AI Barack Obama'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'AI NELK Kyle',
                          child: Text('AI NELK Kyle'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'AI Andrew Tate',
                          child: Text('AI Andrew Tate'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'AI Pokimane',
                          child: Text('AI Pokimane'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _generateVoice,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: const Color(0xFFA8C0EE),
                ),
                child: const Text(
                  'Generate Voice',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
