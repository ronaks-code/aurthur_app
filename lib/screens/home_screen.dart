import 'package:flutter/material.dart';
import 'package:aurthur_app/components/audiobook_thumbnail.dart';
import 'package:aurthur_app/data/audiobooksData.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  void handleThumbnailPress(BuildContext context, Map<String, dynamic> item) {
    Navigator.pushNamed(context, '/audiobook', arguments: item);
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 60.0 + statusBarHeight,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.5),
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [Color(0xFFBD6DFA), Color(0xFFEE92D0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    'Library',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
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
                      // onTap: () => handleThumbnailPress(context, audiobook),
                      child: AudiobookThumbnail(
                        title: audiobook['title'].toString(),
                        imageSource: AssetImage(audiobook['imageSource'].toString()),
                        onPress: () => handleThumbnailPress(context, audiobook),
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
