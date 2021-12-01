import 'package:flutter/material.dart';

// API Keys
const String kTomAPIKey = 'kKqkcovj3TB0E8EkJbPQ1bqzBHFo3AWp';
//URLs
const tomDirectionsUrl = 'https://api.tomtom.com/routing/1/calculateRoute/';
const tomPOIsUrl = 'https://api.tomtom.com/search/2/poiSearch/bike.json?';

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

var kActiveColour = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF625FFD)),
);

var kActiveTextColour = TextStyle(
    color: Colors.white,
    fontSize: 16,
);

var kInactiveColour = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
);

var kInactiveTextColour = TextStyle(
    color: Color(0xFF625FFD),
    fontSize: 16,
);