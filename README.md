# Flutter SDK Demo App

This sample app shows how to use Raven Flutter SDK in your own Flutter app. The Raven Flutter SDK allows you to -

* Manage (Create/Update) your users and their preferences on Raven.
* Update notification statuses to Raven for push notification tracking

### Raven Flutter SDK

You can visit our [SDK docs](https://github.com/ravenappdev/raven-flutter-sdk) to setup the Flutter SDK in your app.

## How to run this sample app

### Step 1.&#x20;

Run the following commands in the project root directory :

```shell
# Install the CLI if not already done so
 dart pub global activate flutterfire_cli
 
# Run the `configure` command, select a Firebase project and platforms   
flutterfire configure
```

Once configured, a `firebase_options.dart` file will be generated for you containing all the options required for initialization. The `DefaultFirebaseOptions.currentPlatform` is imported from our generated `firebase_options.dart` file and is used for Firebase initialization in the `main.dart` file.

```dart
void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
```

Note : To run this app on iOS, please follow additional steps [here](https://firebase.flutter.dev/docs/messaging/apple-integration) to provide  permissions to receive notifications from Firebase cloud messaging on iOS devices.

### Step 2.

Replace `appId` and `apiKey` in the `main.dart` file with your own Raven App ID and API Key which you can get from the Raven Console in the Settings tab.

![App ID and API Key](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MG-HQd2A2Z9XgtUEjJF%2Fuploads%2FgH3n1ibwRkMtP6LkNleO%2F4D2puGmTm6xTmWVE2cVy5a4mBtMRN3Tjj1mAIx-O8VLlZ7-LRxkqFLIuvUE2fsbYIPKIYvSHONbNqQviP0ipG9kDqfE6-4LTJBSwIyeJCjNgCDXST9X14YDXx0WLLzyOYPwtGlbo.jpg?alt=media&token=9dfdfc9a-d805-49df-8907-c5eaa1eaaa9f)

### Step 3.

Change event name to your Raven push event name and user parameters to the details of the corresponding user you want to register to the Raven app.

If you haven’t created a Raven Push event in the Raven console yet check our [docs here](flutter-sdk.md#step-4.-test).

![Event Name and User details](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MG-HQd2A2Z9XgtUEjJF%2Fuploads%2FEOns9r7Jwgn4eXIhl3f9%2FPrKfJyraYkFc_gfG5E5MmlisshlYPT1M4ysZlVEIRFKg5VMMXb3GTom5Lo5R3gLPSQNYgjAPIRkqYSCm7e8RarWuAjkhod-v0euLMs0HxlIN3SAViDC8qlnJEB_zd2cx_rO3ySPf.jpg?alt=media&token=557d83a6-9ab5-439e-a42b-3e4703e9b370)

### Step 4.&#x20;

After completing the above steps, run the “`flutter run`” command to run this sample app.

Once the app runs the following screen appears.

<p float="left">
  <img src="https://lh5.googleusercontent.com/tURwtA5asTvQZugpBk0GgZdeT8WOvFFK3h-GbVyz-ti2abDkqcCyKTqv944M2VAivm0QTHXwFyS-sqbMPFD8iqzg70vhAkOxnaqdH3FEpTM4XCbdxxMKBRbLjmDeUxq7V1RmpTHu" width="100" />
  <img src="https://lh6.googleusercontent.com/-UraLtzSngzmpTG_GLxIEO18Jr5j2cEayGN017aiGERZClVRHyEjTngJGFNkXVzCsCZcn4_OuFSlRjAIY0gej4_3viVcksPCZ4MxIlrB8PVoJiFhlU442DvOiX-ssIyvPYYJfz8D" width="100" /> 
</p>


* Set User button creates/updates the user provided in the Raven app.
* Set Device Token button adds the device token to the previously created user.
* Send Message button is a test method provided in the Raven Sdk to send a notification to the devices of the registered user.

You can also directly send a notification to a device from the Raven console. Go to your event and click the send button of your push event and then use the FCM token of the device to send the event.

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MG-HQd2A2Z9XgtUEjJF%2Fuploads%2FtLnp4A5V83IZInimsSRf%2FYCOBTw4ptA_zBKGMlLRvJ8R5Iwi7IOZHwuorDF2jkzaEYm878JSdScFHuGMrkNzPS2EFwKDCVT9ULN6UiGM7zhcCmrVfF0jz77qp1zlkH2QaT5lPTnwH5SXOrIl2d4IA52vy1O-B.jpg?alt=media&token=4311d574-512a-4566-a4a4-a8e89b976624)

![](https://files.gitbook.com/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MG-HQd2A2Z9XgtUEjJF%2Fuploads%2Fk4lpHOF5upSaEjxhzsVX%2FT0hzVfhJKvMLiPvOK0YFHXL7q37kM6RmCpAMYXpMzNF1sVKXWPbVcgqYalEoLShluCAcKlCGfyd5FKhfFIid0UFKfQDTwpUWROIXA9gyxZbf7DCSdm4c_DG9tX19vHOS-F7cy379.jpg?alt=media&token=712a08fd-7ea5-4225-adb3-8d595d658f83)
