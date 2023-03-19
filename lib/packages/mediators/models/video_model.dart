part of mediators;

@immutable
class VideoModel {
  // -----------------------------------------------------------------------------
  const VideoModel({
    @required this.id,
    @required this.title,
    @required this.url,
    @required this.captions,
    @required this.createdAt,
    @required this.isTranslated,
});
  // -----------------------------------------------------------------------------
  final String id;
  final String title;
  final String url;
  final List<CaptionModel> captions;
  final DateTime createdAt;
  final bool isTranslated;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return {
      'id': id,
      'title': title,
      'url': url,
      'captions': CaptionModel.cipherCaptions(captions: captions),
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'isTranslated': isTranslated,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static VideoModel decipher({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    if (map == null) {
      return null;
    }

    else {
      return VideoModel(
        id: map['id'],
        title: map['title'],
        url: map['url'],
        captions: CaptionModel.decipherCaptions(maps: map['captions']),
        createdAt: Timers.decipherTime(
          time: map['createdAt'],
          fromJSON: fromJSON,
        ),
        isTranslated: map['isTranslated'],
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<VideoModel> decipherMaps({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<VideoModel> _output = <VideoModel>[];

    if (Mapper.checkCanLoopList(maps) == true) {
      for (final Map<String, dynamic> map in maps) {
        final VideoModel _video = decipher(
          map: map,
          fromJSON: fromJSON,
        );
        _output.add(_video);
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String fixVideoTitle(String title){
    return TextMod.fixSearchText(TextMod.fixCountryName(title));
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<VideoModel> removeVideoFromVideos({
    @required List<VideoModel> videos,
    @required String videoID,
  }){
    final List<VideoModel> _output = <VideoModel>[ ...?videos ];

    if (Mapper.checkCanLoopList(videos) == true && videoID != null){
      _output.removeWhere((element) => element.id == videoID);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// AI TESTED
  static String extractVideoIDFromYoutubeURL(String youtubeURL) {
    String _output;

    if (checkIsValidYoutubeLink(youtubeURL) == true) {

      final youtubeLinkPattern = RegExp(
          r'^(https?\:\/\/)?(www\.youtube\.com\/watch\?v=|m\.youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)');

      final match = youtubeLinkPattern.firstMatch(youtubeURL);

      _output = match.group(3);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TIMES

  // --------------------
  /// TESTED : WORKS PERFECT
  static String calculateSuperTimeDifferenceString({
    @required DateTime from,
    @required DateTime to,
  }) {
    String _string = '...';

    if (from != null){
      final int _seconds = Timers.calculateTimeDifferenceInSeconds(from: from, to: to);

      if (_seconds < 60){
        _string = '$_seconds s';
      }

      /// MINUTE = 60 s
      else if (_seconds >= 60 && _seconds < 3600){
        final int _minutes = Timers.calculateTimeDifferenceInMinutes(from: from, to: to);
        _string = '$_minutes m';
      }

      /// HOUR = 3'600 s
      else if (_seconds >= 3600 && _seconds < 86400){
        final int _hours = Timers.calculateTimeDifferenceInHours(from: from, to: to);
        _string = '$_hours h';
      }

      /// DAY = 86'400 s
      else if (_seconds >= 86400 && _seconds < 604800){
        final int _days = Timers.calculateTimeDifferenceInDays(from: from, to: to);
        _string = '$_days d';
      }

      /// WEEK = 604'800 s
      else if (_seconds >= 604800 && _seconds < 2592000){
        final int _weeks = Timers.calculateTimeDifferenceInWeeks(from: from, to: to);
        _string = '$_weeks w';
      }

      /// MONTH = 2'592'000 s
      else if (_seconds >= 2592000 && _seconds < 31536000){
        final int _months = Timers.calculateTimeDifferenceInMonths(from: from, to: to);
        _string = '$_months m';
      }

      /// YEAR = 31'536'000 s
      else {
        final int _years = Timers.calculateTimeDifferenceInYears(from: from, to: to);
        _string = '$_years y';
      }

    }

    return '$_string ago';
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// AI TESTED
  static bool checkIsValidYoutubeVideoID(String videoID) {
    final youtubeVideoIdPattern = RegExp(r'^[a-zA-Z0-9_-]+$');
    return youtubeVideoIdPattern.hasMatch(videoID) && videoID.length <= 11;
  }
  // --------------------
  /// AI TESTED
  static bool checkIsValidYoutubeLink(String link) {
    final youtubeLinkPattern = RegExp(
        r'^(https?\:\/\/)?(www\.youtube\.com\/watch\?v=|m\.youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]+)');
    return youtubeLinkPattern.hasMatch(link);
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVideoModelsAreIdentical(VideoModel model1, VideoModel model2){
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }

    else if (model1 != null && model2 != null) {
      if (
      model1.id == model2.id &&
      model1.title == model2.title &&
      model1.url == model2.url &&
      CaptionModel.checkCaptionsListsAreIdentical(captions1: model1.captions, captions2: model2.captions) == true &&
      Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.second, time1: model1.createdAt, time2: model2.createdAt)
    ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is VideoModel){
      _areIdentical = checkVideoModelsAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      url.hashCode^
      title.hashCode;
  // -----------------------------------------------------------------------------
}
