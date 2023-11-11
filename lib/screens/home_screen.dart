import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stopwatch_app/components/button_widget.dart';
import 'package:stopwatch_app/components/constant.dart';
import 'package:stopwatch_app/components/panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PanelWidget(
                    time: hoursText > 9
                        ? hoursText.toString()
                        : '0${hoursText.toString()}',
                    text: 'Hours',
                  ),
                  const Text(
                    ':',
                    style: TextStyle(
                      fontSize: 55,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'PlaypenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PanelWidget(
                    time: minutesText > 9
                        ? minutesText.toString()
                        : '0${minutesText.toString()}',
                    text: 'Minutes',
                  ),
                  const Text(
                    ':',
                    style: TextStyle(
                      fontSize: 55,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'PlaypenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PanelWidget(
                    time: secondsText > 9
                        ? secondsText.toString()
                        : '0${secondsText.toString()}',
                    text: 'Seconds',
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  started
                      ? Row(
                          children: [
                            paused
                                ? Row(
                                    children: [
                                      ButtonWidget(
                                        text: 'Stop',
                                        onPressed: () {
                                          lapsList.clear();
                                          setState(() {
                                            started = false;
                                            paused = false;
                                          });
                                          stop();
                                        },
                                        icon: Icons.stop_rounded,
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      ButtonWidget(
                                        text: 'Continue',
                                        onPressed: () {
                                          setState(() {
                                            paused = false;
                                          });
                                          continue_();
                                        },
                                        icon: Icons.play_arrow_rounded,
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      ButtonWidget(
                                        text: 'Lap',
                                        onPressed: () {
                                          String hoursLap = hoursText > 10
                                              ? hoursText.toString()
                                              : '0${hoursText.toString()}';
                                          String minutesLap = minutesText > 10
                                              ? minutesText.toString()
                                              : '0${minutesText.toString()}';
                                          String secondsLap = secondsText > 10
                                              ? secondsText.toString()
                                              : '0${secondsText.toString()}';
                                          String lap =
                                              '$hoursLap : $minutesLap : $secondsLap';

                                          focus();
                                          setState(() {
                                            lapsList.add(lap);
                                            lapsHoursList.add(hoursText);
                                            lapsMinutesList.add(minutesText);
                                            lapsSecondsList.add(secondsText);
                                          });
                                        },
                                        icon: Icons.flag_rounded,
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
                                      ButtonWidget(
                                        text: 'Paused',
                                        onPressed: () {
                                          setState(() {
                                            paused = true;
                                          });
                                          pause();
                                        },
                                        icon: Icons.pause_rounded,
                                      ),
                                    ],
                                  )
                          ],
                        )
                      : ButtonWidget(
                          text: 'Start',
                          onPressed: () {
                            setState(() {
                              started = true;
                            });
                            start();
                          },
                          icon: Icons.play_arrow_rounded,
                        ),
                ],
              ),
              lapsList.isEmpty
                  ? const SizedBox()
                  : Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                      ),
                      child: ListView.separated(
                        controller: controller,
                        reverse: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (index == 0 ||
                                        index == 1 ||
                                        index == 2 ||
                                        index == 3 ||
                                        index == 4 ||
                                        index == 5 ||
                                        index == 6 ||
                                        index == 7 ||
                                        index == 8)
                                    ? '0${index + 1}'
                                    : (index + 1).toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 164, 164, 164),
                                  fontFamily: 'PlaypenSans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 45,
                              ),
                              Text(
                                lapsList[index],
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 164, 164, 164),
                                  fontFamily: 'Acme',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                            ],
                          ),
                        ),
                        itemCount: lapsList.length,
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  void focus() {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutCubicEmphasized,
      );
    }
  }

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      second = seconds + 1;
      minute = minutes;
      hour = hours;

      if (second > 59) {
        if (minute > 59) {
          hour++;
          minute = 0;
        } else {
          minute++;
          second = 0;
        }
      }

      setState(() {
        seconds = second;
        minutes = minute;
        hours = hour;
        secondsText = seconds;
        minutesText = minutes;
        hoursText = hours;
      });
    });
  }

  void stop() {
    timer!.cancel();
    setState(() {
      seconds = minutes = hours = 0;
      // secondsText = minutesText = hoursText = '00';
      secondsText = minutesText = hoursText = 00;
    });
  }

  void pause() {
    timer!.cancel();
  }

  void continue_() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      second = seconds + 1;
      minute = minutes;
      hour = hours;

      if (second > 59) {
        if (minute > 59) {
          hour++;
          minute = 0;
        } else {
          minute++;
          second = 0;
        }
      }

      setState(() {
        seconds = second;
        minutes = minute;
        hours = hour;

        secondsText = seconds;
        minutesText = minutes;
        hoursText = hours;
      });
    });
  }
}
