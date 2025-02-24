import 'package:flutter/material.dart';
import 'package:spotifys/core/configs/components/is_loading.dart';
import 'package:spotifys/presentation/home/pages/liked_song_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_outlined),
            activeIcon: Icon(Icons.library_music),
            label: 'Your Library',
          ),
        ],
      ),
    );
  }
}

// شاشة الصفحة الرئيسية (Home)


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // إعدادات التطبيق
              },
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"), // صورة البروفايل
              radius: 18,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم "Good morning"
            Text(
              "Good morning",
              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // قائمة التشغيل السريعة
            _quickPlaylists(),

            SizedBox(height: 20),

            // قسم "Made for You"
            _sectionTitle("Made for You"),
            _horizontalList([
              _playlistItem("Daily Mix 1", "assets/images/4.jpg"),
              _playlistItem("Discover Weekly", "assets/images/5.jpg"),
              _playlistItem("Release Radar", "assets/images/6.jpg"),
            ]),

            SizedBox(height: 20),

            // قسم "Your Top Mixes"
            _sectionTitle("Your Top Mixes"),
            _horizontalList([
              _playlistItem("Top Hits", "assets/images/1.jpg"),
              _playlistItem("Chill Mix", "assets/images/2.jpg"),
              _playlistItem("Workout Mix", "assets/images/3.jpg"),
            ]),
          ],
        ),
      ),
    );
  }

  // عنصر عنوان القسم (Made for You, Your Top Mixes)
  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  // قائمة التشغيل الأفقية
  Widget _horizontalList(List<Widget> items) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items,
      ),
    );
  }

  // عنصر قائمة تشغيل أفقي
  Widget _playlistItem(String title, String imagePath) {
    return Padding(
      padding: EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath, width: 120, height: 120, fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  // قسم "Good morning" مع قوائم التشغيل السريعة
  Widget _quickPlaylists() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _quickPlaylistItem("Liked Songs", Icons.favorite, Colors.purple),
            _quickPlaylistItem("Chill Vibes", Icons.music_note, Colors.blue),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _quickPlaylistItem("Top Hits", Icons.trending_up, Colors.red),
            _quickPlaylistItem("Workout", Icons.fitness_center, Colors.green),
          ],
        ),
      ],
    );
  }
  // عنصر قائمة تشغيل سريعة (Good morning section)
  Widget _quickPlaylistItem(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            SizedBox(width: 10),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// شاشة البحث (Search)
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[900],
            hintText: 'What do you want to listen to?',
            hintStyle: TextStyle(color: Colors.white60),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2, // جعل الأعمدة 3
          childAspectRatio: 2.5, // زيادة حجم الكاردات
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            GenreCard(title: "Pop", color: Colors.pink),
            GenreCard(title: "Hip-Hop", color: Colors.blue),
            GenreCard(title: "Rock", color: Colors.red),
            GenreCard(title: "Jazz", color: Colors.orange),
            GenreCard(title: "Classical", color: Colors.green),
            GenreCard(title: "EDM", color: Colors.purple),
            GenreCard(title: "Reggae", color: Colors.teal),
            GenreCard(title: "Blues", color: Colors.indigo),
            GenreCard(title: "Country", color: Colors.brown),
            GenreCard(title: "Soul", color: Colors.amber),
            GenreCard(title: "R&B", color: Colors.pinkAccent),
            GenreCard(title: "Pop Rock", color: Colors.deepOrange),
            GenreCard(title: "Alternative", color: Colors.cyan),
            GenreCard(title: "Acoustic", color: Colors.greenAccent),
            GenreCard(title: "Indie", color: Colors.blueGrey),
            GenreCard(title: "Punk", color: Colors.purpleAccent),
            GenreCard(title: "Folk", color: Colors.lime),
            GenreCard(title: "Disco", color: Colors.yellow),
            GenreCard(title: "House", color: Colors.deepPurple),
            GenreCard(title: "Techno", color: Colors.blueGrey),
            GenreCard(title: "Trance", color: Colors.orangeAccent),
            GenreCard(title: "Reggaeton", color: Colors.green),
            GenreCard(title: "Ska", color: Colors.redAccent),
            GenreCard(title: "Trap", color: Colors.amberAccent),
            GenreCard(title: "K-Pop", color: Colors.pink),
            GenreCard(title: "Funk", color: Colors.cyanAccent),
            GenreCard(title: "Dancehall", color: Colors.purple),
            GenreCard(title: "Experimental", color: Colors.brown),
            GenreCard(title: "Industrial", color: Colors.green),
            GenreCard(title: "Post-Rock", color: Colors.orange),
            GenreCard(title: "Ambient", color: Colors.blue),
            GenreCard(title: "Chillwave", color: Colors.indigo),
          ],
        ),
      ),
    );
  }
}
// شاشة المكتبة (Your Library)


class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "Your Library",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // إضافة قائمة تشغيل جديدة
            },
          ),
          IconButton(
            icon: Icon(Icons.sort, color: Colors.white),
            onPressed: () {
              // خيارات الفرز
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // شريط التصفية (Playlists, Artists, Albums, Podcasts)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _filterButton("Playlists"),
                _filterButton("Artists"),
                _filterButton("Albums"),
                _filterButton("Podcasts"),
              ],
            ),
          ),
          SizedBox(height: 10),
          
          // قائمة التشغيل (Your Library Items)
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
  _libraryItem(context, "Liked Songs", "Playlist • 340 songs", Icons.favorite, Colors.purple),
  _libraryItem(context, "Daily Mix 1", "Playlist • Made for you", Icons.music_note, Colors.green),
  _libraryItem(context, "Chill Vibes", "Playlist • 50 songs", Icons.album, Colors.blue),
  _libraryItem(context, "Top 2024", "Playlist • Your most played", Icons.trending_up, Colors.red),
  _libraryItem(context, "Podcast: Tech Talk", "Podcast • 25 episodes", Icons.podcasts, Colors.orange),
],
            ),
          ),
        ],
      ),
    );
  }

  // زر التصفية العلوي (Playlists, Artists, Albums, Podcasts)
  Widget _filterButton(String label) {
    return TextButton(
      onPressed: () {},
      child: Text(label, style: TextStyle(color: Colors.white70, fontSize: 16)),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }

  // عنصر في قائمة المكتبة (Playlist أو Podcast)
  Widget _libraryItem(BuildContext context,String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.white70, fontSize: 14)),
      
      onTap: () {
        showLoading(context, () async {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => LikedSongsScreen()),
  );
        });
}

        // الانتقال إلى تفاصيل العنصر
      
    );
  }
}
// عنصر كارت الفئات الموسيقية (Genres & Moods)
class GenreCard extends StatelessWidget {
  final String title;
  final Color color;

  GenreCard({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}