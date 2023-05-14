import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '/data/audiobooksData.dart';

class AudiobookScreen extends StatefulWidget {
  final int? audiobookIndex;

  const AudiobookScreen({Key? key, required this.audiobookIndex})
      : super(key: key);

  @override
  _AudiobookScreenState createState() => _AudiobookScreenState();
}

class _AudiobookScreenState extends State<AudiobookScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String selectedNarrator = "Choose Narrator:";
  bool modalVisible = false;

  @override
  void initState() {
    super.initState();
    configureAudio();
  }

  void configureAudio() async {
    audioPlayer = AudioPlayer();
    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    // Listen to the player state changes
    audioPlayer.onPlayerStateChanged.listen((PlayerState playerState) {
      if (playerState == PlayerState.stopped ||
          playerState == PlayerState.completed) {
        setState(() {
          isPlaying = false;
        });
      } else if (playerState == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      }
    });
  }

  void playAudio(String url) async {
    // Stop the current audio
    await stopAudio();
    // Play the new audio
    await audioPlayer.play(UrlSource(url));
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void restartAudio() {
  setState(() {
    audioPlayer.stop();
    audioPlayer.seek(const Duration(milliseconds: 0));
    isPlaying = false;
    selectedNarrator = 'Choose Narrator:';
  });
}


  Future<void> pauseAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();

      setState(() {
        isPlaying = false;
      });
    }
  }

  Future<void> resumeAudio() async {
    if (!isPlaying) {
      await audioPlayer.resume();

      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    stopAudio();
  }

  @override
  Widget build(BuildContext context) {
    final audiobook = audiobooksData[widget.audiobookIndex!];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Audiobook'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 280,
                child: Image.asset(
                  audiobook['imageSource'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Text(
                  audiobook['title'].toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    height: 2,
                    color: Colors.black,
                    fontFamily: 'Zapfino',
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'By ${audiobook['author'].toString()}',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 122, 122, 122),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 64.0,
                child: Text(
                  audiobook['description'].toString(),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              DropdownButton<String>(
                value: selectedNarrator,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
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
                    selectedNarrator = newValue!;
                  });
                  // add playAudio funtion with null check
                  playAudio(
                    (audiobook['narrators'] as List<dynamic>).firstWhere(
                        (element) =>
                            element['name'].toString() ==
                            selectedNarrator)['audioUri'],
                  );
                },
                items: [    const DropdownMenuItem<String>(      value: 'Choose Narrator:',      child: Text(        'Choose Narrator:',        style: TextStyle(          color: Colors.grey,        ),      ),    ),    ...((audiobook['narrators'] as List<dynamic>)
                      .map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value['name'].toString(),
                      child: Text(
                        value['name'].toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList()),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => restartAudio(),
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFA8C0EE), 
                            Color(0xFFFFB7FD)
                          ],
                        ).createShader(rect);
                      },
                      child: const Icon(
                        Icons.restart_alt,
                        size: 60.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: isPlaying ? pauseAudio : resumeAudio,
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFA8C0EE), Color(0xFFFFB7FD)],
                        ).createShader(rect);
                      },
                      child: isPlaying
                          ? const Icon(
                              Icons.pause,
                              size: 60.0,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.play_arrow,
                              size: 60.0,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
