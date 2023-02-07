<<<<<<< Please follow the steps

## Android

    android/app/src/main/AndroidManifest.xml ->>>>>>>>

    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>


   <application
        android:usesCleartextTraffic="true"......

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:hardwareAccelerated="true"......



## Ios

    ios/Runner/Info.plist ->>>>>>>>


      <key>NSAppTransportSecurity</key>
      <dict>
          <key>NSAllowsArbitraryLoads</key>
          <true/>
          <key>NSAllowsArbitraryLoadsInWebContent</key>
          <true/>
      </dict>


## Example

```dart

class ForgeEditImagePage extends StatefulWidget {
  static const String routeName = "/ForgeEditImagePage";
  final dynamic arguments;
  const ForgeEditImagePage({Key? key, required this.arguments}) : super(key: key);
  @override
  _ForgeEditImagePageState createState() => _ForgeEditImagePageState();
}

class _ForgeEditImagePageState extends State<ForgeEditImagePage> {
  
  @override
  Widget build(BuildContext context) {
    
    return ForgeMarkUp(
      url: "url",
      base64: "base64",
      imageUrl: "imageUrl",
    );
    
  }
  
}

```





# forge
>>>>>>> 5d4808210b0068e8e214c26c16728e17d33975b3
