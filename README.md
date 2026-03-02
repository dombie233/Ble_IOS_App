🔵 BLE iOS App

A simple iOS application demonstrating Bluetooth Low Energy (BLE) scanning and communication using Apple’s CoreBluetooth framework. 📱🔵

This project lets you discover nearby BLE devices, connect to a device, and interact with its services and characteristics.

📋 Requirements

✔️ Xcode (latest version recommended)

✔️ iOS device with BLE support (BLE does not work on the Simulator)

✔️ Swift

✔️ CoreBluetooth framework

🛠 Installation
1. Clone the repository
git clone https://github.com/dombie233/Ble_IOS_App.git
2. Open the project

Open the .xcodeproj file in Xcode.

3. Build and run

Run the app on a physical iPhone.

⚠️ BLE requires real hardware — the iOS Simulator does not support Bluetooth.

🔵 How to Add Your BLE Device

This app scans only for specific BLE devices.
To make your device visible in the app, follow these steps:

1️⃣ Make Sure Bluetooth Is Enabled

Enable Bluetooth on your iPhone

Grant Bluetooth permission when prompted by the app

2️⃣ Configure Your Device Name

The app filters devices by name.
Currently, it searches only for devices containing:

private let targetNames = ["Valkyrie", "ESP32"]

👉 Your BLE device must advertise with a name containing one of these values.

For example:

Valkyrie_Sensor

ESP32_TempMonitor

If your device has a different name, update the array:

private let targetNames = ["YourDeviceName"]
🚀 Usage

Launch the app on your iPhone

Go to the Scan screen

Wait for nearby BLE devices to appear

Tap a discovered device to connect

Use characteristic views to:

Read values

Write values

Subscribe to notifications
