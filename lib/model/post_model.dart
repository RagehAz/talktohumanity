import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:space_time/space_time.dart';
import 'package:stringer/stringer.dart';

@immutable
class PostModel {
  // --------------------------------------------------------------------------
  const PostModel({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.bio,
    @required this.headline,
    @required this.body,
    @required this.pic,
    @required this.time,
    @required this.likes,
    @required this.views,
  });
  // --------------------------------------------------------------------------
  final String id;
  final String name;
  final String email;
  final String bio;
  final String headline;
  final String body;
  final String pic;
  final DateTime time;
  final int likes;
  final int views;
  // --------------------------------------------------------------------------

  /// CYPHER

  // --------------------
  ///
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return {
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'headline': headline,
      'body': body,
      'pic': pic,
      'timeStamp': Timers.cipherTime(time: time, toJSON: toJSON),
      'likes': likes,
      'views': views,
    };
  }
  // --------------------
  ///
  static PostModel decipherPost({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }){
    PostModel _post;

    if (map != null){

      _post = PostModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        bio: map['bio'],
        headline: map['headline'],
        body: map['body'],
        pic: map['pic'],
        time: Timers.decipherTime(time: map['time'], fromJSON: fromJSON),
        likes: map['likes'],
        views: map['views'],
      );

    }

    return _post;
  }
  // --------------------
  ///
  static List<Map<String, dynamic>> cipherPosts({
    @required List<PostModel> posts,
    @required bool toJSON,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (Mapper.checkCanLoopList(posts) == true){

      for (final PostModel post in posts){

        final Map<String, dynamic> _map = post.toMap(toJSON: toJSON);
        _output.add(_map);

      }

    }

    return _output;
  }
  // --------------------
  ///
  static List<PostModel> decipherPosts({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }){
    final List<PostModel> _output = [];

    if (Mapper.checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){

        final PostModel _post = decipherPost(map: map, fromJSON: fromJSON);
        _output.add(_post);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ORGANIZERS

  // --------------------
  ///
  static Map<String, dynamic> organizePostsInMap({
    @required List<PostModel> posts,
  }){

    /// SHOULD LOOK LIKE THIS
    /// {
    ///   '03_2023' : <PostModel>[];
    ///   '02_2023' : <PostModel>[];
    ///   '01_2023' : <PostModel>[];
    ///   '12_2022' : <PostModel>[];
    /// }

    final Map<String, dynamic> _output = {};

    if (Mapper.checkCanLoopList(posts) == true){

      final List<PostModel> _ordered = orderPosts(
        posts: posts,
        ascending: false,
      );

      for (final PostModel post in _ordered){

        final String _key = generateOrganizerMapKey(time: post.time);

        final List<dynamic> _posts = _output[_key];

        if (Mapper.checkCanLoopList(_posts) == true){
          final List<PostModel> _list = [..._posts, post];
          _output[_key] = _list;
        }
        else{
          _output[_key] = [post];
        }

      }

    }

    return _output;
  }
  // --------------------
  ///
  static List<PostModel> orderPosts({
    @required List<PostModel> posts,
    @required bool ascending,
  }){
    final List<PostModel> _output = [];

    if (Mapper.checkCanLoopList(posts) == true){

       posts.sort((a, b) => ascending ?
       a.time.compareTo(b.time)
           :
       b.time.compareTo(a.time));

       _output.addAll(posts);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ORGANIZER KEY

    // --------------------
  /// AI TESTED
  static String generateOrganizerMapKey({
    @required DateTime time,
  }){
    String _output;

    /// STRING SHOULD LOOK LIKE
    // '03_2023'
    // '02_2023'
    // '01_2023'
    // '12_2022'

    if (time != null){

      if (time.month >= 1 && time.month <= 12){
        final int _month = time.month;
        final String _mm = Numeric.formatNumberWithinDigits(num: _month, digits: 2);
        final String _yyyy = '${time.year}';
        _output = '${_mm}_$_yyyy';
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String getMonthFromOrganizerKey({
    @required String organizerKey, // key '03_2023'
  }){
    String _output;

    if (TextCheck.isEmpty(organizerKey) == false){
      if (TextCheck.stringContainsSubString(string: organizerKey, subString: '_') == true) {
        final String _cleaned = TextMod.removeTextAfterLastSpecialCharacter(organizerKey, '_');
        if (_cleaned?.length == 2) {
          final int _month = Numeric.transformStringToInt(_cleaned);
          if (_month != null && _month <= 12){
            _output = _cleaned;
          }
        }
      }
    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String getYearFromOrganizerKey({
    @required String organizerKey, // key '03_2023'
  }) {
    String _output;

    if (TextCheck.isEmpty(organizerKey) == false) {
      if (TextCheck.stringContainsSubString(string: organizerKey, subString: '_') == true) {
        final String _cleaned = TextMod.removeTextBeforeFirstSpecialCharacter
          (organizerKey, '_');
        if (_cleaned?.length == 4) {
          final int _year = Numeric.transformStringToInt(_cleaned);
          if (_year != null){
            _output = _cleaned;
          }
        }
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static bool checkPostsIncludePost({
    @required List<PostModel> posts,
    @required PostModel post,
  }){
    bool _includes = false;

    if (Mapper.checkCanLoopList(posts) == true){

      final PostModel _foundPost = getPostModelFromPostModels(
        id: post.id,
        posts: posts,
      );

      _includes = _foundPost != null;
    }

    return _includes;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static PostModel getPostModelFromPostModels({
    @required List<PostModel> posts,
    @required String id,
  }){
    PostModel _output;

    if (Mapper.checkCanLoopList(posts) == true){

      _output = posts.firstWhere((element) => element.id == id, orElse: () => null);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  ///
  void blogPost(){
    blog('POST : ($time) : $id : $name : $email : $bio : $pic : likes: $likes : views: $views');
    blog('     : -> $headline : $body');
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  ///
  static List<PostModel> dummyPosts() {
    return <PostModel>[
      PostModel(
        id: 'a',
        name: 'Niel Degras Tyson',
        email: 'Neil@hotmail.com',
        bio: 'Astophysicist',
        headline: 'The science of everything',
        body: 'The science is the root of all knowledge',
        pic: Iconz.dvDonaldDuck,
        time: Timers.createDate(year: 2023, month: 03, day: 15),
        likes: 1354354,
        views: 20132540,
      ),
      PostModel(
        id: 'b',
        name: 'Rageh Azzazy',
        email: 'rageh@hotmail.com',
        bio: 'Architect',
        headline: 'The architecture of internet',
        body: 'The architecture is the construct of all ideas',
        pic: Iconz.dvRageh,
        time: Timers.createDate(year: 2023, month: 03, day: 18),
        likes: 154354,
        views: 2013540,
      ),
      PostModel(
        id: 'c',
        name: 'A7mad',
        email: 'a7mad@hotmail.com',
        bio: 'CEO',
        headline: 'The CEO of drop shipping',
        body: 'The trading is the construct of all ideas',
        pic: Iconz.dvRageh,
        time: Timers.createDate(year: 2023, month: 04, day: 2),
        likes: 454354,
        views: 203540,
      ),
      PostModel(
        id: 'd',
        name: 'Ada Lovelace',
        email: 'ada@hotmail.com',
        bio: 'Mathematician',
        headline: "The world's first computer programmer",
        body:
            'Computers are capable of performing any task, as long as it can be expressed as a series of instructions.',
        pic: Iconz.dvRageh2,
        time: Timers.createDate(year: 2023, month: 04, day: 10),
        likes: 547357,
        views: 3473473,
      ),
      PostModel(
        id: 'e',
        name: 'Stephen Hawking',
        email: 'stephen@hotmail.com',
        bio: 'Theoretical physicist',
        headline: 'Exploring the mysteries of the universe',
        body: 'We are all just a tiny part of a vast and complex universe.',
        pic: Iconz.contAfrica,
        time: Timers.createDate(year: 2023, month: 04, day: 25),
        likes: 436346,
        views: 2352345,
      ),
      PostModel(
        id: 'f',
        name: 'Marie Curie',
        email: 'marie@hotmail.com',
        bio: 'Physicist and chemist',
        headline: 'Discovering the secrets of radioactive elements',
        body: 'Radioactivity has revolutionized science and medicine.',
        pic: Iconz.earth,
        time: Timers.createDate(year: 2023, month: 05, day: 7),
        likes: 56834,
        views: 345687,
      ),
      PostModel(
        id: 'g',
        name: 'John Doe',
        email: 'john.doe@example.com',
        bio: 'Software Engineer',
        headline: 'Design patterns in modern software development',
        body:
            'Exploring the benefits and drawbacks of various design patterns in modern software development',
        pic: Iconz.bxProductsOn,
        time: Timers.createDate(year: 2023, month: 07, day: 10),
        likes: 2313,
        views: 14123,
      ),
      PostModel(
        id: 'h',
        name: 'Jane Smith',
        email: 'jane.smith@example.com',
        bio: 'Marketing Specialist',
        headline: 'The impact of social media on marketing',
        body:
            'Analyzing the impact of social media on marketing strategies and identifying best practices for leveraging social media platforms',
        pic: Iconz.comEmail,
        time: Timers.createDate(year: 2023, month: 07, day: 12),
        likes: 524,
        views: 2354,
      ),
      PostModel(
        id: 'i',
        name: 'Samuel Lee',
        email: 'samuel.lee@example.com',
        bio: 'Financial Advisor',
        headline: 'Investment strategies for beginners',
        body:
            'Discussing investment strategies for beginners and outlining key factors to consider when developing an investment portfolio',
        pic: Iconz.achievement,
        time: Timers.createDate(year: 2023, month: 07, day: 20),
        likes: 346,
        views: 4235,
      ),
      PostModel(
        id: 'j',
        name: 'Amanda Martinez',
        email: 'amanda.martinez@example.com',
        bio: 'Journalist',
        headline: 'The future of journalism in the digital age',
        body:
            'Examining the impact of digital technology on traditional journalism models and exploring the possibilities for new forms of journalism in the digital age',
        pic: Iconz.dvRagehWhite,
        time: Timers.createDate(year: 2023, month: 07, day: 25),
        likes: 872,
        views: 6734,
      ),
      PostModel(
        id: 'k',
        name: 'William Johnson',
        email: 'william.johnson@example.com',
        bio: 'Data Analyst',
        headline: 'Data visualization techniques for effective communication',
        body:
            'Exploring various data visualization techniques and discussing best practices for using data visualization to effectively communicate insights and analysis',
        pic: Iconz.filter,
        time: Timers.createDate(year: 2023, month: 07, day: 28),
        likes: 1532,
        views: 9321,
      ),
      PostModel(
        id: 'l',
        name: 'Albert Einstein',
        email: 'einstein@hotmail.com',
        bio: 'Theoretical physicist',
        headline: 'E=mc²: Unraveling the mysteries of energy and mass',
        body: 'Energy and mass are two sides of the same coin.',
        pic: Iconz.cleopatra,
        time: Timers.createDate(year: 2023, month: 05, day: 20),
        likes: 5684598,
        views: 458348348,
      ),
      PostModel(
        id: 'm',
        name: 'Isaac Newton',
        email: 'newton@hotmail.com',
        bio: 'Physicist and mathematician',
        headline: 'The laws of motion and gravity',
        body: 'The laws of motion and gravity govern the behavior of everything in the universe.',
        pic: Iconz.bigMac,
        time: Timers.createDate(year: 2023, month: 06, day: 1),
        likes: 658345,
        views: 4848486,
      ),
      PostModel(
        id: 'n',
        name: 'Charles Darwin',
        email: 'darwin@hotmail.com',
        bio: 'Naturalist and biologist',
        headline: 'The theory of evolution by natural selection',
        body: 'All life on earth is descended from a common ancestor, and has evolved over millions of years through the process of natural selection.',
        pic: Iconz.contNorthAmerica,
        time: Timers.createDate(year: 2023, month: 7, day: 2),
        likes: 56834568,
        views: 345745746,
      ),
    ];
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPostsAreIdentical({
    @required PostModel post1,
    @required PostModel post2,
  }){
    bool _identical = false;

    if (post1 == null && post2 == null){
      _identical = true;
    }

    else if (post1 != null && post2 != null){

      if (
      post1.id == post2.id &&
      post1.name == post2.name &&
      post1.email == post2.email &&
      post1.bio == post2.bio &&
      post1.headline == post2.headline &&
      post1.body == post2.body &&
      post1.pic == post2.pic &&
      Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.millisecond, time1: post1.time, time2: post2.time)
      ){
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
    if (other is PostModel){
      _areIdentical = checkPostsAreIdentical(
        post1: this,
        post2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      name.hashCode^
      email.hashCode^
      bio.hashCode^
      headline.hashCode^
      body.hashCode^
      pic.hashCode^
      time.hashCode;
  // -----------------------------------------------------------------------------
}
