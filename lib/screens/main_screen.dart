import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/item_model.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final AudioPlayer audioPlayer = AudioPlayer();
  int? _playingIndex;

  List<Item> items = [
    Item(
      name: "Forest Sounds",
      imagePath: "lib/meditation_images/forest.jpeg",
      audioPath: "meditation_audios/forest.mp3",
    ),
    Item(
        name: "Night Sounds",
        imagePath: "lib/meditation_images/night.jpeg",
        audioPath: "lib/meditation_audios/night.mp3"),
    Item(
        name: "Ocean Breeze",
        imagePath: "lib/meditation_images/ocean.jpeg",
        audioPath: "lib/meditation_audios/ocean.mp3"),
    Item(
        name: "Waterfall Sounds",
        imagePath: "lib/meditation_images/waterfall.jpeg",
        audioPath: "lib/meditation_audios/waterfall.mp3"),
    Item(
        name: "Wind Sounds",
        imagePath: "lib/meditation_images/wind.jpeg",
        audioPath: "lib/meditation_audios/waterfall.mp3")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(items[index].imagePath)
                  ),
                ),
                child: ListTile (
                  leading: BorderedText(
                    strokeWidth: 4,
                    strokeColor: Colors.black,
                    child: Text(items[index].name,
                      style: GoogleFonts.lato(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                      icon: _playingIndex == index
                          ? FaIcon(Icons.stop_circle_outlined, size: 40,)
                          : FaIcon(Icons.play_circle_outlined, size: 40,),
                      onPressed: () async {

                        if (_playingIndex == index) {
                          setState(() {
                            _playingIndex = null;
                          });

                          audioPlayer.stop();
                        }
                        else {

                          try {
                            await audioPlayer.setAsset(items[index].audioPath);

                            audioPlayer.play();

                            setState(() {
                              _playingIndex = index;
                            });
                          }
                          on SocketException {
                            print("No Internet Connection");
                          }
                          catch (error) {
                            print(error);
                          }


                        }

                      },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
