// ignore_for_file: unnecessary_import
library mediators;
// -----------------------------------------------------------------------------
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:layouts/layouts.dart';
import 'package:mapper/mapper.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';
import 'package:talktohumanity/packages/layouts/nav.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import '../permitter/permitter.dart';
import 'screens/cropping_screen/cropper_footer.dart';
import 'screens/cropping_screen/cropper_pages.dart';

// -----------------------------------------------------------------------------
part 'methods/pic_maker.dart';
part 'models/dimension_model.dart';
part 'screens/cropping_screen/cropping_screen.dart';
// -----------------------------------------------------------------------------