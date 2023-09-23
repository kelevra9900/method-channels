# Flutter MethodChannel Example

This repository contains examples of how to use MethodChannel in Flutter to communicate between the Flutter part and native code (Android in this case).

## Description

### Step 1: Get Platform Version

- Create a MethodChannel named "platform_version".
- Invoke the native method to obtain the platform version.
- Display the result in an AlertDialog.

### Step 2: Data Channel ("dataChannel")

- Create a MethodChannel named "data_channel".
- Define a method in native code to receive a string from Flutter and return it concatenated with "- Native".
- From Flutter, send the string "Hello Flutter" to native code through the channel.
- Display the response on the user interface.

### Step 3: Bidirectional Channel ("bidirectionalChannel")

- Implement a bidirectional MethodChannel named "bidirectional_channel".
- Define two methods in native code: flutterToNative and nativeToFlutter.
- From Flutter, invoke the flutterToNative method and send a string.
- From native code, invoke the nativeToFlutter method and send a different string.
- Display both strings on the user interface.

## Running Tests

To run unit tests that verify the MethodChannel functionality, follow these steps:

1. Open a terminal in the project's root directory.
2. Execute the following command:

```bash
flutter test
```

## Screenshots

| Home | Bidirectional | Platform Version |
|-----------|----------------|----------------|
| ![Home](https://github.com/kelevra9900/method-channels/blob/main/screenshots/home.png?raw=true) | ![Bidirectional](https://github.com/kelevra9900/method-channels/blob/main/screenshots/bidirectional.png?raw=true)| ![PV](https://github.com/kelevra9900/method-channels/blob/main/screenshots/platform-version.png?raw=true) |


## Author
👤 **Rogelio Torres**