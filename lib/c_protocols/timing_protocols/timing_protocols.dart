// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest/rest.dart';
import 'package:space_time/space_time.dart';

class InternetTimeModel{
  // -----------------------------------------------------------------------------
  const InternetTimeModel({
    @required this.abbreviation,
    @required this.client_ip,
    @required this.datetime,
    @required this.day_of_week,
    @required this.day_of_year,
    @required this.dst,
    @required this.dst_offset,
    @required this.raw_offset,
    @required this.timezone,
    @required this.unixtime,
    @required this.utc_datetime,
    @required this.utc_offset,
    @required this.week_number,
  });
  // -----------------------------------------------------------------------------
  final String abbreviation;
  final String client_ip;
  final String datetime;
  final int day_of_week;
  final int day_of_year;
  final bool dst;
  final int dst_offset;
  final int raw_offset;
  final String timezone;
  final int unixtime;
  final DateTime utc_datetime;
  final String utc_offset;
  final int week_number;
  // --------------------
  /// TESTED : WORKS PERFECT
  InternetTimeModel copyWith({
    String abbreviation,
    String client_ip,
    String datetime,
    int day_of_week,
    int day_of_year,
    bool dst,
    int dst_offset,
    int raw_offset,
    String timezone,
    int unixtime,
    DateTime utc_datetime,
    String utc_offset,
    int week_number,
  }) {
    return InternetTimeModel(
      abbreviation: abbreviation ?? this.abbreviation,
      client_ip: client_ip ?? this.client_ip,
      datetime: datetime ?? this.datetime,
      day_of_week: day_of_week ?? this.day_of_week,
      day_of_year: day_of_year ?? this.day_of_year,
      dst: dst ?? this.dst,
      dst_offset: dst_offset ?? this.dst_offset,
      raw_offset: raw_offset ?? this.raw_offset,
      timezone: timezone ?? this.timezone,
      unixtime: unixtime ?? this.unixtime,
      utc_datetime: utc_datetime ?? this.utc_datetime,
      utc_offset: utc_offset ?? this.utc_offset,
      week_number: week_number ?? this.week_number,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static InternetTimeModel decipher(Map<String, dynamic> map){

    if (map == null){
      return null;
    }

    else {
      return InternetTimeModel(
        abbreviation: map['abbreviation'],
        client_ip: map['client_ip'],
        datetime: map['datetime'],
        day_of_week: map['day_of_week'],
        day_of_year: map['day_of_year'],
        dst: map['dst'],
        dst_offset: map['dst_offset'],
        raw_offset: map['raw_offset'],
        timezone: map['timezone'],
        unixtime: map['unixtime'],
        utc_datetime: Timers.decipherTime(
          time: map['utc_datetime'],
          fromJSON: true,
        ),
        utc_offset: map['utc_offset'],
        week_number: map['week_number'],
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  InternetTimeModel offsetTime() {
    return copyWith(
        utc_datetime: Timers.offsetTime(
          time: utc_datetime,
          offset: utc_offset,
        )
    );
  }
  // -----------------------------------------------------------------------------
}

class TimingProtocols {
  // -----------------------------------------------------------------------------

  const TimingProtocols();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkDeviceTimeIsCorrect() async {

    final InternetTimeModel _internetUTCTimeMap = await getInternetUTCTime();

    final DateTime _dateTimeReceived = _internetUTCTimeMap?.utc_datetime ?? DateTime.now();
    final DateTime _dateTime = Timers.createDateTime(
      year: _dateTimeReceived.year,
      month: _dateTimeReceived.month,
      day: _dateTimeReceived.day,
      hour: _dateTimeReceived.hour,
      minute: _dateTimeReceived.minute,
      second: _dateTimeReceived.second,
      millisecond: 0,
      microsecond: 0,
    );

    final DateTime _now = DateTime.now();

    return Timers.checkTimesAreIdentical(
      accuracy: TimeAccuracy.minute,
      time1: _now,
      time2: _dateTime,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<InternetTimeModel> getInternetUTCTime() async {

    InternetTimeModel _output;

    final Response _response = await Rest.get(
      rawLink: 'http://worldtimeapi.org/api/ip',
      invoker: 'getInternetUTCTime',
    );

    if (_response != null){

      final Map<String, dynamic> _map = json.decode(_response.body);
      _output = InternetTimeModel.decipher(_map);
      _output.offsetTime();

    }

    return _output;
  }
  // --------------------
  /*
  static Future<void> thing () async {


    /// CHECK DEVICE CLOCK
    final bool _deviceTimeIsCorrect = await BldrsTimers.checkDeviceTimeIsCorrect(
      context: context,
      showIncorrectTimeDialog: true,
    );

    // blog('6 - initializeLogoScreen : _deviceTimeIsCorrect : $_deviceTimeIsCorrect');

    if (_deviceTimeIsCorrect == false){

      // blog('7 - initializeLogoScreen : will restart app now');

      await _onRestartAppInTimeCorrectionDialog(
        context: context,
      );

    }

    else {


      /// DAILY LDB REFRESH
      await _dailyRefreshLDB(context);

      // blog('7 - initializeLogoScreen : daily refresh is done');

    }

    // blog('8 - initializeLogoScreen : END');


  }
  // -----------------------------------------------------------------------------

  /// Daily LDB REFRESH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _dailyRefreshLDB(BuildContext context) async {

    final bool _shouldRefresh = await LDBDoc.checkShouldRefreshLDB(context);

    if (_shouldRefresh == true){

      await LDBDoc.wipeOutEntireLDB(
        /// MAIN
        // flyers: true,
        // bzz: true,
        notes: false, // I do not think we need to refresh notes everyday
        pics: false, // I do not think we need to refresh pics everyday
        pdfs: false, // i do not think that fetched pdfs are changed frequently by authors,
        /// USER
        users: false,
        authModel: false, // need my authModel to prevent re-auth everyday
        accounts: false, // keep accounts until user decides to not "remember me trigger"
        /// CHAIN
        bldrsChains: false, // keep the chains man, if chains updated - appState protocols handles this
        pickers: false, // same as chains
        /// ZONES
        // countries: true, // countries include staging info, so lets refresh that daily
        cities: false, // cities do not change often
        districts: false, // districts do not change frequently
        // staging: true, // staging info changes frequently
        // census: true, // might need faster refresh aslan

        /// PHRASES
        mainPhrases: false,
        countriesPhrases: false,
        /// EDITORS
        userEditor: false, // keep this for user to find later anytime
        bzEditor: false, // keep this as well
        authorEditor: false, // keep
        flyerMaker: false, // keep
        reviewEditor: false, // keep
        /// SETTINGS
        theLastWipe: false, // no need to wipe
        appState: false, // no need to wipe
        appControls: false, // no need to wipe
        langCode: false, // no need to wipe
      );

    }

    // else {
    //
    //   blog('_dailyRefreshLDB : IT HAS NOT BEEN A DAY YET : will leave the ldb as is');
    //
    // }

  }
  // -----------------------------------------------------------------------------

  /// LDB REFRESH - DAILY WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkShouldRefreshLDB(BuildContext context) async {
    bool _shouldRefresh = true;

    /// NOTE : if did not find last wipe dateTime => will wipe
    /// if found and its more than {24 hours} => will wipe
    /// if found and its less than {24 hours} => will not wipe

    final List<Map<String, dynamic>> _maps = await LDBOps.readMaps(
      ids: ['theLastWipeMap'],
      docName: LDBDoc.theLastWipe,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.theLastWipe),
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      final DateTime _lastWipe = Timers.decipherTime(
          time: _maps.first['time'],
          fromJSON: true,
      );

      double _diff = Timers.calculateTimeDifferenceInHours(
          from: _lastWipe,
          to: DateTime.now(),
      )?.toDouble();

      _diff = Numeric.modulus(_diff);

      // blog('checkShouldRefreshLDB : _diff : $_diff < ${Standards.dailyLDBWipeIntervalInHours} hrs = ${_diff < Standards.dailyLDBWipeIntervalInHours}');

      /// ONLY WHEN NOT EXCEEDED THE TIME SHOULD NOT REFRESH
      if (_diff != null && _diff < Standards.dailyLDBWipeIntervalInHours){
        _shouldRefresh = false;
      }

    }

    await LDBOps.insertMap(
      // allowDuplicateIDs: false,
      docName: LDBDoc.theLastWipe,
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.theLastWipe),
      input: {
        'id': 'theLastWipeMap',
        'time': Timers.cipherTime(time: DateTime.now(), toJSON: true),
      },
    );

    return _shouldRefresh;
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeOutEntireLDB({
    /// MAIN
    bool flyers = true,
    bool bzz = true,
    bool notes = true,
    bool pics = true,
    bool pdfs = true,
    /// USER
    bool users = true,
    bool authModel = true,
    bool accounts = true,
    /// CHAINS
    bool bldrsChains = true,
    bool pickers = true,
    /// ZONES
    bool countries = true,
    bool cities = true,
    bool districts = true,
    bool staging = true,
    bool census = true,
    /// PHRASES
    bool mainPhrases = true,
    bool countriesPhrases = true,
    /// EDITORS
    bool userEditor = true,
    bool bzEditor = true,
    bool authorEditor = true,
    bool flyerMaker = true,
    bool reviewEditor = true,
    /// SETTINGS
    bool theLastWipe = true,
    bool appState = true,
    bool appControls = true,
    bool langCode = true,
  }) async {

    final List<String> _docs = <String>[];

    /// MAIN
    if (flyers == true) {_docs.add(LDBDoc.flyers);}
    if (bzz == true) {_docs.add(LDBDoc.bzz);}
    if (notes == true) {_docs.add(LDBDoc.notes);}
    if (pics == true) {_docs.add(LDBDoc.pics);}
    if (pdfs == true) {_docs.add(LDBDoc.pdfs);}
    /// MAIN
    if (users == true) {_docs.add(LDBDoc.users);}
    if (authModel == true) {_docs.add(LDBDoc.authModel);}
    if (accounts == true) {_docs.add(LDBDoc.accounts);}
    /// CHAINS
    if (bldrsChains == true) {_docs.add(LDBDoc.bldrsChains);}
    if (pickers == true) {_docs.add(LDBDoc.pickers);}
    if (census == true) {_docs.add(LDBDoc.census);}
    /// ZONES
    if (countries == true) {_docs.add(LDBDoc.countries);}
    if (cities == true) {_docs.add(LDBDoc.cities);}
    if (districts == true) {_docs.add(LDBDoc.districts);}
    if (staging == true) {_docs.add(LDBDoc.staging);}
    /// PHRASES
    if (mainPhrases == true) {_docs.add(LDBDoc.mainPhrases);}
    if (countriesPhrases == true) {_docs.add(LDBDoc.countriesPhrases);}
    /// EDITORS
    if (userEditor == true) {_docs.add(LDBDoc.userEditor);}
    if (bzEditor == true) {_docs.add(LDBDoc.bzEditor);}
    if (authorEditor == true) {_docs.add(LDBDoc.authorEditor);}
    if (flyerMaker == true) {_docs.add(LDBDoc.flyerMaker);}
    if (reviewEditor == true) {_docs.add(LDBDoc.reviewEditor);}
    /// SETTINGS
    if (theLastWipe == true) {_docs.add(LDBDoc.theLastWipe);}
    if (appState == true) {_docs.add(LDBDoc.appState);}
    if (appControls == true) {_docs.add(LDBDoc.appControls);}
    if (langCode == true) {_docs.add(LDBDoc.langCode);}

    await Future.wait(<Future>[
      ...List.generate(_docs.length, (index){
        return LDBOps.deleteAllMapsAtOnce(
            docName: _docs[index],
        );
      }),
    ]);

  }
  // -----------------------------------------------------------------------------

  static Future<void> showIncorrectTimeDialog() async {

    if (showIncorrectTimeDialog == true && _isCorrect == false){

      final int _diff = Timers.calculateTimeDifferenceInMinutes(from: _now, to: _dateTime);
      final double _num = Numeric.modulus(_diff.toDouble());
      final bool _differenceIsBig = _num > 2;

      if (_differenceIsBig == true){
        Timers.blogDateTime(_now);
        Timers.blogDateTime(_dateTime);
        blog('calculateTimeDifferenceInMinutes : ${_now.minute - _dateTime.minute}');
        blog('checkDeviceTimeIsCorrect : _diff : ( $_diff ) : modulus : $_num : _differenceIsBig : $_differenceIsBig');

        /*
        case
            [log] BLOGGING DATE TIME : 2022-10-11 13:27:29.139045
            [log] BLOGGING DATE TIME : 2022-10-11 13:28:10.320371Z
            [log] calculateTimeDifferenceInMinutes : -1
         */

        final String _dd_month_yyy_actual = translate_dd_month_yyyy(context: context,
            time: _dateTime);
        final String _hh_i_mm_ampm_actual = Timers.generateString_hh_i_mm_ampm(context: context, time: _dateTime);

        final String _dd_month_yyy_device = translate_dd_month_yyyy(context: context, time: _now);
        final String _hh_i_mm_ampm_device = Timers.generateString_hh_i_mm_ampm(context: context, time: _now);

        Verse _zoneLine = ZoneModel.generateInZoneVerse(
            context: context,
            zoneModel: ZoneProvider.proGetCurrentZone(context: context, listen: false),
        );
        _zoneLine = _zoneLine.id != '...' ? _zoneLine : Verse(
          /// PLAN : THIS NEEDS TRANSLATION : IN COMES LIKE THIS 'Africa/Cairo'
          id: 'in $_timezone',
          translate: false,
        );

        await CenterDialog.showCenterDialog(
          context: context,
          titleVerse: const Verse(
            id: 'phid_device_time_incorrect',
            translate: true,
          ),
          bodyVerse: Verse(
            // pseudo: 'Please adjust you device clock and restart again\n\n$_secondLine\n$_thirdLine',
              id: '${xPhrase(context, 'phid_adjust_your_clock')}\n\n'
                    '${xPhrase(context, 'phid_actual_clock')}\n'
                    '${_zoneLine.id}\n'
                    '$_dd_month_yyy_actual . $_hh_i_mm_ampm_actual\n\n'
                    '${xPhrase(context, 'phid_your_clock')}\n'
                    '$_dd_month_yyy_device . $_hh_i_mm_ampm_device',
              translate: false,
          ),
          confirmButtonVerse: const Verse(
            id: 'phid_i_will_adjust_clock',
            translate: true,
          ),
          onOk: onRestart,
        );

      }

      else {
        _isCorrect = true;
      }

    }


  }
  // -----------------------------------------------------------------------------
*/
}
