import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:things_todo_app/components/text_fragment.dart';

class AndroidSettingsInfo extends StatefulWidget {
  const AndroidSettingsInfo({super.key});

  @override
  State<AndroidSettingsInfo> createState() => _AndroidSettingsInfoState();
}

class _AndroidSettingsInfoState extends State<AndroidSettingsInfo> {
  static const platform = MethodChannel('com.example.flutter/device_info');
  String deviceInfo = "";

  Future<void> _getDeviceInfo() async {
    String result;
    try {
      platform.invokeMethod('getDeviceInfo').then((value) {
        result = value.toString();
        setState(() {
          deviceInfo = result;
        });
      });
    } on PlatformException catch (e) {
      //TODO: use logging framework
      print("_getDeviceInfo==>${e.message}");
    }
  }

  @override
  void initState() {
    _getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextFragment(
              text: "We wiil use your device info only to improve our app later...", 
              isOverflowClip: true,
            ),
            const SizedBox(
              height: 10,
            ),
            const TextFragment(
              text: "UwU", 
              isOverflowClip: true,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFragment(
              text: deviceInfo, 
              isOverflowClip: true,
            ),
          ],
        ),
      ),
    );
  }
}