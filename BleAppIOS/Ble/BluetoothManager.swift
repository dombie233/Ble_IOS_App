import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate {

    static let shared = BluetoothManager()

    let central: CBCentralManager

    private override init() {
          central = CBCentralManager(delegate: nil, queue: nil)
          super.init()
      }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state:", central.state.rawValue)
    }
}
