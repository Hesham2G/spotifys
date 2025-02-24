import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String title;
  final String artist;
  final String imagePath;
  final String audioPath;
  final List<String>? playlist; // قائمة التشغيل
  final int currentIndex; // الفهرس الحالي

  const AudioPlayerScreen({
    super.key,
    required this.title,
    required this.artist,
    required this.imagePath,
    required this.audioPath,
    this.playlist,
    this.currentIndex = 0,
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late final AudioPlayer _audioPlayer;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isShuffle = false;
  bool _isRepeat = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioPlayer();
    _loadCurrentAudio();
  }

  void _setupAudioPlayer() {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _playNextAutomatically(); // تشغيل الأغنية التالية عند الانتهاء
      }
      if (mounted) setState(() {});
    });

    _audioPlayer.positionStream.listen((position) {
      if (mounted) setState(() => _position = position);
    });

    _audioPlayer.durationStream.listen((duration) {
      if (mounted) setState(() => _duration = duration ?? Duration.zero);
    });
  }

  Future<void> _loadCurrentAudio() async {
    try {
      await _audioPlayer.setAsset(widget.audioPath);
      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) setState(() {
        _errorMessage = "فشل تحميل الصوت";
        _isLoading = false;
      });
    }
  }

  void _playNextAutomatically() async {
    if (widget.playlist == null) return;

    int nextIndex = _isShuffle 
        ? _getRandomIndex() 
        : (widget.currentIndex + 1) % widget.playlist!.length;

    if (_isRepeat) nextIndex = widget.currentIndex;

    if (nextIndex != widget.currentIndex) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AudioPlayerScreen(
            title: widget.title,
            artist: widget.artist,
            imagePath: widget.imagePath,
            audioPath: widget.playlist![nextIndex],
            playlist: widget.playlist,
            currentIndex: nextIndex,
          ),
        ),
      );
    }
  }

  int _getRandomIndex() => DateTime.now().millisecond % widget.playlist!.length;

  Future<void> _togglePlayPause() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause(); // إيقاف الصوت
      } else {
        await _audioPlayer.play(); // تشغيل الصوت
      }
      if (mounted) setState(() {}); // تحديث واجهة المستخدم بعد التغيير
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = "خطأ في التشغيل");
      }
    }
  }

  void _seekTo(double seconds) => _audioPlayer.seek(Duration(seconds: seconds.toInt()));

  void _playNext() => _playNextAutomatically();

  void _playPrevious() {
    if (widget.playlist == null) return;
    int prevIndex = (widget.currentIndex - 1) % widget.playlist!.length;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AudioPlayerScreen(
          title: widget.title,
          artist: widget.artist,
          imagePath: widget.imagePath,
          audioPath: widget.playlist![prevIndex],
          playlist: widget.playlist,
          currentIndex: prevIndex,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 35),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator(color: Colors.white));
    if (_errorMessage != null) return Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)));

    return Column(
      children: [
        const SizedBox(height: 20),
        _buildAlbumArt(),
        const SizedBox(height: 30),
        _buildSongInfo(),
        const SizedBox(height: 20),
        _buildProgressBar(),
        const SizedBox(height: 30),
        _buildMainControls(),
        const SizedBox(height: 30),
        _buildSecondaryControls(),
      ],
    );
  }

  Widget _buildAlbumArt() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            spreadRadius: -10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          widget.imagePath,
          width: 300,
          height: 300,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[800],
            child: const Icon(Icons.music_note, size: 100, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            widget.artist,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Slider(
            value: _position.inSeconds.toDouble(),
            min: 0,
            max: _duration.inSeconds.toDouble(),
            activeColor: Colors.white,
            inactiveColor: Colors.white24,
            onChanged: _seekTo,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_position), style: const TextStyle(color: Colors.white)),
              Text(_formatDuration(_duration), style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
          onPressed: _playPrevious,
        ),
        const SizedBox(width: 20),
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: IconButton(
            icon: Icon(
              _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
              color: Colors.black,
              size: 40,
            ),
            onPressed: _togglePlayPause,
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
          onPressed: _playNext,
        ),
      ],
    );
  }

  Widget _buildSecondaryControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white, size: 30),
          onPressed: () {},
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: Icon(Icons.shuffle, color: _isShuffle ? Colors.green : Colors.white, size: 30),
          onPressed: () => setState(() => _isShuffle = !_isShuffle),
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: Icon(Icons.repeat, color: _isRepeat ? Colors.green : Colors.white, size: 30),
          onPressed: () => setState(() => _isRepeat = !_isRepeat),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}';
  }
}