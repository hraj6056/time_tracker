import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';
import 'timer_page.dart';
import 'clock.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //////////////////////////////// TIMER CODE /////////////////////////////////////////////
  //TODO Timer Variables
  int hour = 0;
  int min = 0;
  int sec = 0;
  String timetodisplay = "";
  // bool variables is defined to use to
  // enable/disable the Buttons when it pressed
  bool started = true;
  bool stopped = true;
  int timefortimer;
  bool canceltimer = false;

  //TODO Start Function for Timer()
  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    //TODO Convert Time in Seconds
    timefortimer = ((hour * 3600) + (min * 60) + sec);
    // we give a "timer" in place of "callback"
    // bcz we don't want to run timer continuously
    // so we need to stop timer running continuously
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timefortimer < 1 || canceltimer == true) {
          t.cancel();
          // if we want to reset the (time selector) timer
          // then write the following line of code
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (timefortimer < 60) {
          timetodisplay = timefortimer.toString().padLeft(2, "0");
          timefortimer = timefortimer - 1;
        } else if (timefortimer < 3600) {
          int m = timefortimer ~/ 60;
          int s = timefortimer - (60 * m);
          timetodisplay =
              m.toString().padLeft(2, "0") + ":" + s.toString().padLeft(2, "0");
          timefortimer = timefortimer - 1;
        } else {
          int h = timefortimer ~/ 3600;
          int x = timefortimer - (3600 * h);
          int m = x ~/ 60;
          int s = x - (60 * m);
          timetodisplay = h.toString().padLeft(2, "0") +
              ":" +
              m.toString().padLeft(2, "0") +
              ":" +
              s.toString().padLeft(2, "0");
          timefortimer = timefortimer - 1;
        }
      });
    });
  }

  //TODO Stop Function for timer() Buttons
  void stop() {
    setState(() {
      started = true;
      stopped = true;
      canceltimer = true;
      // if we want to empty time's text where the running time is displaying
      // then write the following line of code
      timetodisplay = "";
    });
  }

  //TODO Define Tab Controller Class
  TabController tb;
  //TODO Override the initState(){}
  @override
  void initState() {
    tb = TabController(length: 3, vsync: this);
    super.initState();
  }

  //TODO Create Timer Function that return a Widget
  Widget timer() {
    return Container(
      color: Colors.blue[100],
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'HH :',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      minValue: 0,
                      maxValue: 24,
                      listViewWidth: 100.0,
                      selectedTextStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 50,
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                      ),
                      onChanged: (value) {
                        setState(() {
                          hour = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        ' MM :',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      minValue: 0,
                      maxValue: 24,
                      listViewWidth: 100.0,
                      selectedTextStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 50,
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                      ),
                      onChanged: (value) {
                        setState(() {
                          min = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        ' SS',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 24,
                      listViewWidth: 100.0,
                      selectedTextStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 50,
                      ),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                      ),
                      onChanged: (value) {
                        setState(() {
                          sec = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timetodisplay,
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: (this.started) ? this.start : null,
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent[700],
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        180.0,
                      ),
                    ),
                    child: Container(
                      height: 90.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.greenAccent[400],
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          180.0,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                          size: 60.0,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (this.stopped) ? null : stop,
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.redAccent[700],
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        180.0,
                      ),
                    ),
                    child: Container(
                      height: 90.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.redAccent[400],
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          180.0,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.stop,
                          color: Colors.black,
                          size: 60.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        //centerTitle: true,
        /*title: Text(
          'Track Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            fontFamily: 'Times New Roman',
          ),
        ),*/
        //TODO Tab Bar
        bottom: TabBar(
          tabs: [
            Icon(
              Icons.access_time_sharp,
              color: Colors.black,
              size: 40.0,
            ),
            Icon(
              Icons.timer_rounded,
              color: Colors.black,
              size: 40.0,
            ),
            Icon(
              Icons.hourglass_full_rounded,
              color: Colors.black,
              size: 40.0,
            ),
          ],
          controller: tb,
          labelPadding: EdgeInsets.only(bottom: 10.0),
          unselectedLabelColor: Colors.white60,
        ),
      ),
      //TODO Tab Bar View
      body: TabBarView(
        children: [
          //TODO Caller clock Function
          Clock(),
          //TODO Caller Timer Function
          timer(),
          //TODO Caller Stopwatch Function
          TimerPage(),
        ],
        // here below we also give/write controller
        // bcz it will work only when both controller would be same
        controller: tb,
      ),
    );
  }
}
