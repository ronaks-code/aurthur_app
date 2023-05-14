// import 'package:flutter/material.dart';
// import 'package:flutter_material_pickers/flutter_material_pickers.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// class AudiobookScreen extends StatefulWidget {
//   final Map<String, dynamic> audiobook;

//   const AudiobookScreen({super.key, required this.audiobook});

//   @override
//   _AudiobookScreenState createState() => _AudiobookScreenState();
// }

// class _AudiobookScreenState extends State<AudiobookScreen> {
//   final player = AudioPlayer();
//   bool isPlaying = false;
//   String audioUri = "";
//   late String selectedNarrator = "";
//   late String selectedChapter = "";

//   Future<void> playAudio(String? uri) async {
//     await player.play(AssetSource(uri!));
//     setState(() => isPlaying = true);
//   }

//   Future<void> stopAudio() async {
//     player.stop();
//     setState(() => isPlaying = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.audiobook['title']),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: Center(
//                 child: Image.asset(
//                   'assets/images/audiobook_cover.png',
//                   height: 200,
//                 ),
//               ),
//             ),
//             Text(
//               widget.audiobook['title'],
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             Text(
//               'By ${widget.audiobook['author']}',
//               style: const TextStyle(fontSize: 16),
//               textAlign: TextAlign.center,
//             ),
//             ElevatedButton(
//             onPressed: () async {
//               int index = 0;
//               if (widget.audiobook['narrators'] != null) {
//                 index = widget.audiobook['narrators'].indexWhere((narrator) => narrator['name'] == selectedNarrator);
//                 if (index == -1) {
//                   index = 0;
//                 }
//               }

//               await showMaterialScrollPicker(
//                 context: context,
//                 title: 'Select Narrator:',
//                 items: widget.audiobook['narrators']?.map((narrator) => narrator['name'])?.toList() ?? [],
//                 selectedItem: index,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedNarrator = widget.audiobook['narrators']![value]['name'];
//                     audioUri = widget.audiobook['narrators']!.firstWhere((narrator) => narrator['name'] == value)['audioUri'];
//                   });
//                   playAudio(audioUri);
//                 },
//               );
//             },
//             child: Text(selectedNarrator.isEmpty ? 'Choose Narrator' : selectedNarrator),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               int index = 0;
//               if (widget.audiobook['chapters'] != null) {
//                 index = widget.audiobook['chapters'].indexWhere((chapter) => chapter['name'] == selectedChapter);
//                 if (index == -1) {
//                   index = 0;
//                 }
//               }

//               await showMaterialScrollPicker(
//                 context: context,
//                 title: 'Select Chapter:',
//                 items: widget.audiobook['chapters']?.map((chapter) => chapter['name'])?.toList() ?? [],
//                 selectedItem: index,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedChapter = widget.audiobook['chapters']![value]['name'];
//                     audioUri = widget.audiobook['chapters']!.firstWhere((chapter) => chapter['name'] == value)['audioUri'];
//                   });
//                   playAudio(audioUri);
//                 },
//               );
//             },
//             child: Text(selectedChapter.isEmpty ? 'Choose Chapter' : selectedChapter),
//           ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   onPressed: isPlaying ? stopAudio : null,
//                   icon: Icon(
//                     isPlaying ? MaterialCommunityIcons.stop_circle_outline : MaterialCommunityIcons.play_circle_outline,
//                     size: 48,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AudiobookScreen extends StatefulWidget {
//   final dynamic audiobook;
//   const AudiobookScreen({Key? key, required this.audiobook}) : super(key: key);

//   @override
//   _AudiobookScreenState createState() => _AudiobookScreenState();
// }

// class _AudiobookScreenState extends State<AudiobookScreen> {
//   AudioPlayer? audioPlayer;
//   bool isPlaying = false;

//   Future<void> configureAudio() async {
//     await AudioPlayer().stop();
//   }

//   @override
//   void initState() {
//     super.initState();
//     configureAudio();
//   }

//   @override
//   void dispose() {
//     audioPlayer?.stop();
//     audioPlayer?.release();
//     super.dispose();
//   }

//   Future<void> playAudio(String uri) async {
//     if (audioPlayer != null) {
//       await audioPlayer!.stop();
//     }
//     audioPlayer = AudioPlayer();
//     await audioPlayer!.setUrl(uri);
//     await audioPlayer!.play(audioPlayer!.getUrl());
//     setState(() {
//       isPlaying = true;
//     });
//     audioPlayer!.onPlayerCompletion.listen((event) {
//       setState(() {
//         isPlaying = false;
//       });
//     });
//   }

//   Future<void> stopAudio() async {
//     if (audioPlayer != null) {
//       await audioPlayer!.stop();
//       setState(() {
//         isPlaying = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.audiobook['title']),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 24),
//             child: ElevatedButton(
//               onPressed: isPlaying
//                   ? stopAudio
//                   : () => playAudio(widget.audiobook['audioSource']),
//               child: Text(
//                 isPlaying ? 'Stop' : 'Play',
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   widget.audiobook['description'],
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               ),
//             ),
//           ),
//           NarratorChoice(audiobook: widget.audiobook, playAudio: playAudio),
//         ],
//       ),
//     );
//   }
// }

// class NarratorChoice extends StatefulWidget {
//   final dynamic audiobook;
//   final Function(String) playAudio;
//   const NarratorChoice(
//       {Key? key, required this.audiobook, required this.playAudio})
//       : super(key: key);

//   @override
//   _NarratorChoiceState createState() => _NarratorChoiceState();
// }

// class _NarratorChoiceState extends State<NarratorChoice> {
//   late String selectedNarrator;

//   @override
//   void initState() {
//     super.initState();
//     selectedNarrator = 'Choose Narrator:';
//   }

//   void chooseNarrator(String narratorName, String audioUri) async {
//     selectedNarrator = narratorName;
//     setState(() {}); // Redraw the widget to reflect the selected narrator
//     await widget.playAudio(audioUri);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             selectedNarrator,
//             style: Theme.of(context).textTheme.headline6,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             child: SizedBox(
//               height: 120,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: widget.audiobook['narrators'].length,
//                 itemBuilder: (context, index) {
//                   final narrator = widget.audiobook['narrators'][index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: GestureDetector(
//                       onTap: () => chooseNarrator(
//                           narrator['name'], narrator['audioUri']),
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: AssetImage(narrator['avatar']),
//                             radius: 40,
//                           ),
//                           Text(narrator['name']),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AudiobookScreen extends StatefulWidget {
  int audiobookIndex;
  AudiobookScreen({Key? key, required this.audiobookIndex}) : super(key : key);

  @override
  _AudiobookScreenState createState() => _AudiobookScreenState(audiobookIndex);
}

class _AudiobookScreenState extends State<AudiobookScreen> {
  int audiobookIndex;
  _AudiobookScreenState(this.audiobookIndex);
  final player = AudioPlayer();
  bool isPlaying = false;
  String audioUri = "";
  late String selectedNarrator = "";
  late String selectedChapter = "";

  Future<void> playAudio(String? uri) async {
    if (uri == null) return; // add null check
    await player.play(AssetSource(uri));
    setState(() => isPlaying = true);
  }

  Future<void> stopAudio() async {
    player.stop();
    setState(() => isPlaying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audiobook['title']),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/audiobook_cover.png',
                  height: 200,
                ),
              ),
            ),
            Text(
              widget.audiobook['title'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              'By ${widget.audiobook['author']}',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () async {
                int index = 0;
                if (widget.audiobook['narrators'] != null) {
                  index = widget.audiobook['narrators'].indexWhere(
                      (narrator) => narrator['name'] == selectedNarrator);
                  if (index == -1) {
                    index = 0;
                  }
                }

                await showMaterialScrollPicker(
                  context: context,
                  title: 'Select Narrator:',
                  items: widget.audiobook['narrators']
                          ?.map((narrator) => narrator['name'])
                          ?.toList() ??
                      [],
                  selectedItem: index,
                  onChanged: (value) {
                    setState(() {
                      selectedNarrator =
                          widget.audiobook['narrators']![value]['name'];
                      audioUri = widget.audiobook['narrators']!.firstWhere(
                          (narrator) => narrator['name'] == value)['audioUri'];
                    });
                    playAudio(audioUri);
                  },
                );
              },
              child: Text(selectedNarrator.isEmpty
                  ? 'Choose Narrator'
                  : selectedNarrator),
            ),
            ElevatedButton(
              onPressed: () async {
                int index = 0;
                if (widget.audiobook['chapters'] != null) {
                  index = widget.audiobook['chapters'].indexWhere(
                      (chapter) => chapter['name'] == selectedChapter);
                  if (index == -1) {
                    index = 0;
                  }
                }

                await showMaterialScrollPicker(
                  context: context,
                  title: 'Select Chapter:',
                  items: widget.audiobook['chapters']
                          ?.map((chapter) => chapter['name'])
                          ?.toList() ??
                      [],
                  selectedItem: index,
                  onChanged: (value) {
                    setState(() {
                      selectedChapter =
                          widget.audiobook['chapters']![value]['name'];
                      audioUri = widget.audiobook['chapters']!.firstWhere(
                          (chapter) => chapter['name'] == value)['audioUri'];
                    });
                    playAudio(audioUri);
                  },
                );
              },
              child: Text(
                  selectedChapter.isEmpty ? 'Choose Chapter' : selectedChapter),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: isPlaying ? stopAudio : null,
                  icon: Icon(
                    isPlaying
                        ? MaterialCommunityIcons.stop_circle_outline
                        : MaterialCommunityIcons.play_circle_outline,
                    size: 48,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
