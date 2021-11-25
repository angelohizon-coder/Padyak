import 'package:flutter/material.dart';

// API Keys
String kTomApiKey = 'kHHPnG86GkPYyfApHjuMDzfp8ynAPMkE';

var blueStyleIconButton = const TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

var labelInputPage = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

var weatherDateStyle = const TextStyle(
  color: Color(0xFF625FFD),
  fontSize: 16,
);

var defaultSizedBoxTwentyFiveHeight = const SizedBox(
  height: 25,
);

var defaultPadding = const EdgeInsets.symmetric(
  vertical: 10,
  horizontal: 16,
);

var noSplashEffect = const ButtonStyle(
  splashFactory: NoSplash.splashFactory,
);
