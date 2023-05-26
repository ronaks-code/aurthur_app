import 'package:flutter/material.dart';
import '/components/audiobook_thumbnail.dart';
import '/data/audiobooksData.dart';
import '/screens/audiobook_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void handleThumbnailPress(BuildContext context, int itemIndex) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AudiobookScreen(audiobookIndex: itemIndex),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F1F0),
      appBar: AppBar(
        title: const Text('Library',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFA8C0EE),
                Color(0xFFFFB7FD),
                Color(0xFFC58BE5),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 20.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: audiobooksData.length,
                  itemBuilder: (context, index) {
                    final audiobook = audiobooksData[index];

                    return GestureDetector(
                      child: AudiobookThumbnail(
                        title: audiobook['title'].toString(),
                        imageSource:
                            AssetImage(audiobook['imageSource'].toString()),
                        onPress: () => handleThumbnailPress(context, index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
