import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  leading: Image.asset(
                    'images/greetings.png',
                    height: 48,
                  ),
                  title: Text(
                    'Hey backstreet boys!',
                    style: labelInputPage,
                  ),
                  subtitle: const Text(
                    'Where are you going today?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              defaultSizedBoxTwentyFiveHeight,
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Starting location',
                                  style: labelInputPage,
                                ),
                                subtitle: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 60, 0),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hintText: 'Your current location',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'images/pen.JPG',
                              width: 24,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Destination location',
                                  style: labelInputPage,
                                ),
                                subtitle: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 60, 0),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hintText: 'Your desired location',
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'images/pen.JPG',
                              width: 24,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF625FFD),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/map_page');
                          },
                          child: Text(
                            'Get The Route',
                            style: blueStyleIconButton,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              defaultSizedBoxTwentyFiveHeight,
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Place Near You',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Expanded(
                      child: Image.asset('images/dummy-map.JPG'),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF625FFD),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Image.asset(
                          'images/menu/home.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        style: noSplashEffect,
                        onPressed: () {
                          Navigator.pushNamed(context, '/weather_page');
                        },
                        child: Image.asset(
                          'images/menu/cloud-cut-version.png',
                          color: const Color(0xFFC4C4C4),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: TextButton(
                        style: noSplashEffect,
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile_page');
                        },
                        child: Image.asset(
                          'images/menu/user.png',
                          color: const Color(0xFFC4C4C4),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
