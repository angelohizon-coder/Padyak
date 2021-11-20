import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            defaultSizedBoxTwentyFiveHeight,
            const CircleAvatar(
              backgroundImage: AssetImage('images/default-picture.png'),
              backgroundColor: Colors.white,
              radius: 36,
            ),
            TextButton(
              child: const Text(
                'Change Picture',
                style: TextStyle(
                  color: Color(0xFF625FFD),
                ),
              ),
              onPressed: () {},
              style: noSplashEffect,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Name',
                                style: labelInputPage,
                              ),
                              subtitle: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'Default Name',
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
                                'Email',
                                style: labelInputPage,
                              ),
                              subtitle: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'Default Email',
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
                                'Gender',
                                style: labelInputPage,
                              ),
                              subtitle: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'Default Gender',
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
                                'Address',
                                style: labelInputPage,
                              ),
                              subtitle: Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'Default Address',
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
                  ],
                ),
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
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Save Changes',
                  style: blueStyleIconButton,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                splashFactory: NoSplash.splashFactory,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Discard',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            defaultSizedBoxTwentyFiveHeight
          ],
        ),
      ),
    );
  }
}
