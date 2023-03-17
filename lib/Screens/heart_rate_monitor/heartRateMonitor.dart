import 'package:camera/camera.dart';
import 'package:carenet/Screens/heart_rate_monitor/chart.dart';
import 'package:carenet/Theming/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wakelock/wakelock.dart';

class HeartRateMon extends StatefulWidget {
  const HeartRateMon({Key? key}) : super(key: key);

  @override
  State<HeartRateMon> createState() => _HeartRateMonState();
}

class _HeartRateMonState extends State<HeartRateMon> {
  bool _toggled = false;
  bool _processing = false;
  List<SensorValue> _data = [];
  CameraController? _controller;
  double _alpha = 0.3;
  int _bpm = 0;

  // Override camera controller dispose method
  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  // Functions to toggle the IconButton
  _toggle() {
    _initController().then((onValue) {
      Wakelock.enable();
      setState(() {
        _toggled = true;
        _processing = false;
      });
      _updateBPM();
    });
  }

  _untoggle() {
    _disposeController();
    Wakelock.disable();
    setState(() {
      _toggled = false;
      _processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Heart Rate Monitor",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 5.w),
            Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade200),
              child: Text(
                "BETA",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade800),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 20.h),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),

            Container(
              padding: EdgeInsets.all(15.w),
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Center(
                        child: _controller == null
                            ? Container()
                            : CameraPreview(_controller!),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60.w,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Center(
                      child: Text(
                        (_bpm > 30 && _bpm < 150
                            ? _bpm.round().toString()
                            : "65 \nBPM"),
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 15.h,
            ),

            Text(
              "Measurement is in progress. Please keep your device steady.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),

            SizedBox(
              height: 10.h,
            ),

            // Icon Toggle Area
            Center(
              child: IconButton(
                icon: Icon(_toggled ? Icons.favorite : Icons.favorite_border),
                color: CustomColors.bluebell,
                iconSize: 20.w,
                onPressed: () {
                  if (_toggled) {
                    _untoggle();
                  } else {
                    _toggle();
                  }
                },
              ),
            ),

            Container(
              padding: EdgeInsets.all(15.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/torch.svg",
                    width: 35.w,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      "High intensity of flash in some devices can cause contact area to heat up. Kindly remove your finger if it gets uncomfortable.",
                      style: TextStyle(
                          color: CustomColors.grey1,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10)),
            ),

            SizedBox(
              height: 20.h,
            ),

            // Shift - 2
            Expanded(
              child: Container(
                  child: Chart(_data),
                  // margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.grey[300])),
            )
          ],
        ),
      )),
    );
  }

  // Activate Camera Flash, capture images to process
  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, ResolutionPreset.high);
      await _controller!.initialize();
      Future.delayed(Duration(milliseconds: 500)).then((onValue) {
        _controller?.setFlashMode(FlashMode.torch);
      });
      _controller!.startImageStream((CameraImage image) {
        if (!_processing) {
          setState(() {
            _processing = true;
          });
          _scanImage(image);
        }
      });
    } catch (Exception) {
      print(Exception);
    }
  }

// Calculate avg of camera's red channel data and store to display on chart
// We do not process every frame -> Smaple Rate = 30 samples/sec
// _scanImage executed only when _processing = false
  _scanImage(CameraImage image) {
    double _avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
    if (_data.length >= 50) {
      _data.removeAt(0);
    }
    setState(() {
      _data.add(SensorValue(DateTime.now(), _avg));
    });
    Future.delayed(Duration(milliseconds: 1000 ~/ 30)).then((onValue) {
      setState(() {
        _processing = false;
      });
    });
  }

  _disposeController() {
    _controller!.dispose();
    _controller = null;
  }

  _updateBPM() async {
    List<SensorValue> _values;
    double _avg;
    int _n;
    double _m;
    double _threshold;
    double _bpm;
    int _counter;
    int _previous;
    while (_toggled) {
      _values = List.from(_data);
      _avg = 0;
      _n = _values.length;
      _m = 0;
      _values.forEach((SensorValue value) {
        _avg += value.value / _n;
        if (value.value > _m) _m = value.value;
      });
      _threshold = (_m + _avg) / 2;
      _bpm = 0;
      _counter = 0;
      _previous = 0;
      for (int i = 1; i < _n; i++) {
        if (_values[i - 1].value < _threshold &&
            _values[i].value > _threshold) {
          if (_previous != 0) {
            _counter++;
            _bpm +=
                60000 / (_values[i].time.millisecondsSinceEpoch - _previous);
          }
          _previous = _values[i].time.millisecondsSinceEpoch;
        }
      }
      if (_counter > 0) {
        _bpm = _bpm / _counter;
        setState(() {
          _bpm = (1 - _alpha) * _bpm + _alpha * _bpm;
        });
      }
      await Future.delayed(Duration(milliseconds: (1000 * 50 / 30).round()));
    }
  }
}
