🔵 BLE iOS App

A simple iOS application demonstrating Bluetooth Low Energy (BLE) scanning and communication using Apple’s CoreBluetooth framework.

The app allows you to:

- Scan for nearby BLE peripherals

- Connect to selected devices

- Discover services and characteristics

- Communicate with supported peripherals

🧠 Technologies

- Swift

- CoreBluetooth

- Xcode

- IOS

📋 Requirements

- Latest version of Xcode

- Physical iOS device with BLE support

- iOS 13+ (or your minimum deployment target)

⚠️ BLE does not work in the iOS Simulator. A real device is required.

🚀 Installation & Running

1️⃣ Clone the repository

`git clone https://github.com/dombie233/Ble_IOS_App.git`

2️⃣ Open the project

Open the .xcodeproj file in Xcode.

3️⃣ Build & Run
- Connect your iPhone
- Select your device as the target
- Run the app
- Make sure to grant Bluetooth permissions when prompted.

🔍 BLE Device Filtering

The app scans only for specific device names.

Currently supported:
```swift
private let targetNames = ["Valkyrie", "ESP32"]
```
If your device uses a different name, update the array:
```swift
private let targetNames = ["YourDeviceName"]
```

🧩 Features

 - [x] BLE device scanning

 - [x] Device name filtering

 - [x] Peripheral connection

 - [x] Service discovery

 - [x] Characteristic interaction

 - [x] Real-time Bluetooth permission handling



