import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int seconds = 0, minutes = 0, hours = 0;
  Timer timer;
  bool active = false;
  List laps = [];

  void cleanLaps() {
    setState(() {
      this.laps = [];
    });
  }

  void addLap() {
    String lap = ((this.hours >= 10) ? '${this.hours}' : '0${this.hours}') +
        ':' +
        ((this.minutes >= 10) ? '${this.minutes}' : '0${this.minutes}') +
        ':' +
        ((this.seconds >= 10) ? '${this.seconds}' : '0${this.seconds}');
    setState(() {
      this.laps.add(lap);
    });
  }

  void stop() {
    this.timer.cancel();
    setState(() {
      this.active = false;
    });
  }

  void reset() {
    if (timer != null) this.timer.cancel();
    setState(() {
      this.seconds = 0;
      this.minutes = 0;
      this.hours = 0;
      this.active = false;
    });
  }

  void increment() {
    setState(() {
      this.active = true;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = this.seconds + 1;
      int localMinutes = this.minutes;
      int localHours = this.hours;
      if (localSeconds > 60) {
        localMinutes++;
        if (localMinutes > 60) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        this.seconds = localSeconds;
        this.minutes = localMinutes;
        this.hours = localHours;
        this.timer = timer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData theme = Theme.of(context);
    return Scaffold(
      //backgroundColor: theme.backgroundColor,
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            children: <Widget>[
              /*Text(
                'Timer',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),*/
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  ((this.hours >= 10) ? '${this.hours}' : '0${this.hours}') +
                      ':' +
                      ((this.minutes >= 10)
                          ? '${this.minutes}'
                          : '0${this.minutes}') +
                      ':' +
                      ((this.seconds >= 10)
                          ? '${this.seconds}'
                          : '0${this.seconds}'),
                  style: TextStyle(
                    fontSize: 90.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: this.reset,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
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
                            color: Colors.redAccent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            180.0,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.refresh,
                            color: Colors.black,
                            size: 60.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (this.active) ? this.stop : this.increment,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
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
                            color: Colors.greenAccent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            180.0,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            (this.active) ? Icons.pause : Icons.play_arrow,
                            color: Colors.black,
                            size: 60.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: this.addLap,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.yellow,
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
                            color: Colors.yellowAccent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            180.0,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.flag,
                            color: Colors.black,
                            size: 60.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 40.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: this.cleanLaps,
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView.builder(
                      itemCount: this.laps.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: Text(
                            '$index - ${this.laps[index]}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
