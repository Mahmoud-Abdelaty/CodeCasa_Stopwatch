import 'dart:async';

import 'package:flutter/material.dart';

bool started = false;
bool paused = false;
Timer? timer;
List lapsList = [];
List lapsHoursList = [];
List lapsMinutesList = [];
List lapsSecondsList = [];
int seconds = 0, minutes = 0, hours = 0;
int second = 0, minute = 0, hour = 0;
int secondsText = 00, minutesText = 00, hoursText = 00;
final controller = ScrollController();
