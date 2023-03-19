part of super_video_player;

class SuperVideoPlayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperVideoPlayer({
    @required this.width,
    this.file,
    this.url,
    this.autoPlay = false,
    Key key
  }) : super(key: key);
  // --------------------
  final String url;
  final File file;
  final double width;
  final bool autoPlay;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// URL
    if (url != null){

      final bool _isYoutubeLink = VideoModel.checkIsValidYoutubeLink(url);

      /// YOUTUBE URL
      if (_isYoutubeLink == true){
        return YoutubeVideoPlayer(
          videoID: VideoModel.extractVideoIDFromYoutubeURL(url),
          width: width,
          autoPlay: autoPlay,
        );
      }

      /// MP4 URL
      else {
        return FileAndURLVideoPlayer(
          url: url,
          width: width,
          autoPlay: autoPlay,
        );
      }

    }

    /// FILE
    else if (file != null){
      return FileAndURLVideoPlayer(
        file: file,
        width: width,
        autoPlay: autoPlay,
      );
    }

    /// NOTHING
    else {
      return VideoBox(
        width: width,
      );
    }

  }

}
