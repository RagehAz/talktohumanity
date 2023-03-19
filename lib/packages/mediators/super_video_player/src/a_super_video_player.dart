part of super_video_player;

class SuperVideoPlayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperVideoPlayer({
    @required this.width,
    this.file,
    this.url,
    this.autoPlay = false,
    this.asset,
    this.loop = false,
    this.aspectRatio,
    Key key
  }) : super(key: key);
  // --------------------
  final String url;
  final File file;
  final double width;
  final bool autoPlay;
  final String asset;
  final bool loop;
  final double aspectRatio;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// ASSET OR FILE
    if (asset != null || file != null){
        return FileAndURLVideoPlayer(
          width: width,
          asset: asset,
          file: file,
          autoPlay: autoPlay,
          loop: loop,
          aspectRatio: aspectRatio,
        );
    }

    /// URL
    else if (url != null){

      final bool _isYoutubeLink = VideoModel.checkIsValidYoutubeLink(url);

      /// YOUTUBE URL
      if (_isYoutubeLink == true){
        return YoutubeVideoPlayer(
          videoID: VideoModel.extractVideoIDFromYoutubeURL(url),
          width: width,
          autoPlay: autoPlay,
          /// LOOPING WAS NOT CONNECTED HERE
        );
      }

      /// MP4 URL
      else {
        return FileAndURLVideoPlayer(
          url: url,
          width: width,
          autoPlay: autoPlay,
          loop: loop,
          // height: height,
          // aspectRatio: aspectRatio,
        );
      }

    }

    /// NOTHING
    else {
      return VideoBox(
        width: width,
        aspectRatio: aspectRatio,
      );
    }

  }

}
