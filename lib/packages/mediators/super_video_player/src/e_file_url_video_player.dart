part of super_video_player;

class FileAndURLVideoPlayer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FileAndURLVideoPlayer({
    this.file,
    this.asset,
    this.url,
    this.controller,
    this.width,
    this.autoPlay = false,
    this.loop = false,
    this.aspectRatio,
    Key key
  }) : super(key: key);
  // --------------------
  final String url;
  final String asset;
  final File file;
  final VideoPlayerController controller;
  final double width;
  final bool autoPlay;
  final bool loop;
  final double aspectRatio;
  /// --------------------------------------------------------------------------
  @override
  _FileAndURLVideoPlayerState createState() => _FileAndURLVideoPlayerState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static VideoPlayerController initializeVideoController({
    @required ValueNotifier<VideoPlayerValue> videoValue,
    @required bool mounted,
    String url,
    String asset,
    File file,
    bool addListener = true,
    bool autoPlay = false,
    bool loop = false,
  }) {
    VideoPlayerController _output;

    final String _link = url ??
        'https://commondatastorage.googleapis'
            '.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

    final VideoPlayerOptions _options = VideoPlayerOptions(
      mixWithOthers: true,
      // allowBackgroundPlayback: false,
    );

    if (url != null) {
      _output = VideoPlayerController.network(_link,
          videoPlayerOptions: _options
      );
    }

    if (asset != null) {
      _output = VideoPlayerController.asset(asset,
          videoPlayerOptions: _options
      );
    }

    if (file != null) {
      _output = VideoPlayerController.file(file,
          videoPlayerOptions: _options
      );
    }

    _output..initialize()..setVolume(1);

    if (loop == true){
      _output.setLooping(true);
    }


    if (addListener == true) {
      _output.addListener(() => _listenToVideo(
            mounted: mounted,
            videoValue: videoValue,
            videoPlayerController: _output,
          ));
    }

    if (autoPlay == true){
      _output.play();
    }
    else {
      _output.pause();
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void _listenToVideo({
    @required ValueNotifier<VideoPlayerValue> videoValue,
    @required VideoPlayerController videoPlayerController,
    @required bool mounted,
  }) {
    setNotifier(
      notifier: videoValue,
      mounted: mounted,
      value: videoPlayerController.value,
      addPostFrameCallBack: true,
    );
  }
  // --------------------------------------------------------------------------
}

class _FileAndURLVideoPlayerState extends State<FileAndURLVideoPlayer> {
  // --------------------------------------------------------------------------
  final ValueNotifier<VideoPlayerValue> _videoValue = ValueNotifier(null);
  final ValueNotifier<bool> _isChangingVolume = ValueNotifier(false);
  VideoPlayerController _videoPlayerController;
  // --------------------
  double _volume = 1;
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _videoPlayerController = widget.controller ?? FileAndURLVideoPlayer.initializeVideoController(
      url: widget.url,
      file: widget.file,
      videoValue: _videoValue,
      mounted: mounted,
      autoPlay: widget.autoPlay,
      asset: widget.asset,
      loop: widget.loop,
      // addListener: true,
    );

  }
  // --------------------
  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _isChangingVolume.dispose();
    _videoValue.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// CONTROLS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _play() {

    setState(() {
      _videoPlayerController?.play();
      _videoPlayerController?.setLooping(true);
    });
    // _value.isPlaying.log();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _pause() {

    setState(() {
      _videoPlayerController?.pause();
      _videoPlayerController?.setLooping(false);
    });
    // _value.isPlaying.log();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _setVolume(double volume) async {

    if (_volume != volume){
      setState(() {
        _videoPlayerController?.setVolume(volume);
        _volume = volume;
      });
    }

  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  Future<void> _increaseVolume() async {

    final bool _canIncrease = _volume < _maxVolume;

    blog('canIncrease : $_canIncrease : _volume : $_volume : _maxVolume : $_maxVolume');

    if (_canIncrease){
      await _setVolume(
        _fixVolume(
          num: _volume + 0.1,
          isIncreasing: true,
        ),
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _decreaseVolume() async {

    if (_volume > 0){
      await _setVolume(
        _fixVolume(
          num: _volume - 0.1,
          isIncreasing: false,
        ),
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _fixVolume({
    @required double num,
    @required bool isIncreasing,
  }){

    /// INCREASING
    if (isIncreasing){
      final double _n = (num * 10).ceilToDouble();
      return Numeric.removeFractions(number: _n) / 10;
    }

    /// DECREASING
    else {
      final double _n = (num * 10).floorToDouble();
      return Numeric.removeFractions(number: _n) / 10;
    }

  }
   */
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
    return VideoViewer(
          onPlay: _play,
          onPause: _pause,
          width: widget.width ?? Scale.screenWidth(context),
          aspectRatio: widget.aspectRatio,
          videoPlayerController: _videoPlayerController,
          videoValue: _videoValue,
          onVolumeChanged: _setVolume,
          isChangingVolume: _isChangingVolume,
        );
    // --------------------

  }

}
