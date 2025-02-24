import 'package:flutter/material.dart';
import 'package:spotifys/core/configs/components/is_loading.dart';
import 'package:spotifys/presentation/home/pages/audio_player.dart';

class Song {
  final String title;
  final String artist;
  final String assetPath;
  final String imagePath;

  Song({required this.title, required this.artist, required this.assetPath, required this.imagePath});
}

class LikedSongsScreen extends StatelessWidget {
  final List<Song> likedSongs = [
    Song(
      title: "Creep",
      artist: "Radiohead",
      assetPath: "assets/songs/1.mp3",
      imagePath: "assets/images/1.jpg",
    ),
    Song(
      title: "Maps",
      artist: "Maroon 5",
      assetPath: "assets/songs/2.mp3",
      imagePath: "assets/images/2.jpg",
    ),
    Song(
      title: "Sugar",
      artist: "Maroon 5",
      assetPath: "assets/songs/3.mp3",
      imagePath: "assets/images/3.jpg",
    ),
    Song(
      title: "Where Is My Mind",
      artist: "Pixies",
      assetPath: "assets/songs/4.mp3",
      imagePath: "assets/images/4.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black, // لون مطابق لـ Spotify
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 30), // أيقونة الرجوع مثل Spotify
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Liked Songs",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24, 
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // جعل العنوان في المنتصف مثل Spotify
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 30), // أيقونة القائمة مثل Spotify
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView.builder(
          itemCount: likedSongs.length,
          itemBuilder: (context, index) {
            Song song = likedSongs[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                contentPadding: EdgeInsets.zero, // إزالة التباعد الافتراضي لجعل الشكل مطابقًا لـ Spotify
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(song.imagePath, width: 55, height: 55, fit: BoxFit.cover),
                ),
                title: Text(
                  song.title,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  song.artist,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                trailing: Icon(Icons.more_vert, color: Colors.white, size: 26), // زر الخيارات مثل Spotify
                
                onTap: () {
                  
                  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AudioPlayerScreen(
        title: song.title,
        artist: song.artist,
        imagePath: song.imagePath,
        audioPath: song.assetPath, // إضافة مسار الصوت
      ),
    ),
  );
                  
                
                  // يمكنك لاحقًا إضافة تشغيل الصوت هنا
                },
              ),
            );
          },
        ),
      ),
    );
  }
}