// ignore_for_file: non_constant_identifier_names
import 'package:app_settings/app_settings.dart';
import 'package:filers/filers.dart';
import 'package:flutter/foundation.dart';
import 'package:ldb/ldb.dart';
import 'package:space_time/space_time.dart';
import 'package:talktohumanity/b_views/b_widgets/c_dialogs/talk_dialogs.dart';
import 'package:talktohumanity/c_services/protocols/post_protocols/post_ldb_ops.dart';
import 'package:talktohumanity/c_services/helpers/helper_methods.dart';

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
  static Future<bool> checkDeviceTime() async {

    DateTime _internet;
    String _timeZone;
    DateTime _now;
    int _diff;

    final bool _isAcceptable = await InternetTime.checkDeviceTimeIsAcceptable(
      internetTime: (InternetTime internet) {
        _internet = internet?.utc_datetime?.toLocal();
        _timeZone = internet?.timezone;
      },
      deviceTime: (DateTime device) {
        _now = device;
      },
      diff: (int diff) {
        _diff = diff;
      },
    );

    if (_isAcceptable == false){

      blog('time diff is : $_diff minutes');

        await _showTimeDifferenceDialog(
          internetTime: _internet,
          nowTime: _now,
          timezone: _timeZone,
        );

        if (kIsWeb == false){
          await AppSettings.openDateSettings();
        }

      }


    return _isAcceptable;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _showTimeDifferenceDialog({
    @required DateTime internetTime,
    @required DateTime nowTime,
    String timezone = '...',
  }) async {

    if (internetTime != null && nowTime != null) {
      final DateTime _actual = internetTime;

      final String _dd_month_yyy_actual = Timers.generateString_dd_I_MM_I_yyyy(
        time: _actual,
        monthString: getMonthName(month: _actual.month, shortForm: false),
      );
      final String _hh_i_mm_ampm_actual = Timers.generateString_hh_i_mm_ampm(
        time: _actual,
      );

      final String _dd_month_yyy_device = Timers.generateString_dd_I_MM_I_yyyy(
        time: nowTime,
        monthString: getMonthName(month: nowTime.month, shortForm: false),
      );
      final String _hh_i_mm_ampm_device = Timers.generateString_hh_i_mm_ampm(
        time: nowTime,
      );

      await TalkDialog.centerDialog(
        title: 'Your Device clock is incorrect',
        body: 'Correct time in $timezone :-\n'
            '$_dd_month_yyy_actual . $_hh_i_mm_ampm_actual\n\n'
            'but your clock is :-\n'
            '$_dd_month_yyy_device . $_hh_i_mm_ampm_device',
      );
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> refreshLDBPostsEveryDay() async {

    final bool _shouldRefresh = await LDBOps.checkShouldRefreshLDB(

    );

    if (_shouldRefresh == true){

      await PostLDBPOps.wipeAllPosts();

    }

  }
  // -----------------------------------------------------------------------------
}
