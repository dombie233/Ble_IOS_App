import Foundation
import CoreBluetooth

struct BLEDevice: Identifiable {
    let id: UUID
    let name: String
    let peripheral: CBPeripheral
}

class BLEScanner: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published var discoveredDevices: [BLEDevice] = []
    @Published var isScanning = false
    
    private let centralManager = BluetoothManager.shared.central
    private var scanTimeoutWorkItem: DispatchWorkItem?
    private let targetNames = ["Valkyrie", "ESP32"]

    func startScan() {
   
        centralManager.delegate = self
        
        guard centralManager.state == .poweredOn else {
            print("Bluetooth nie jest włączony. Stan: \(centralManager.state.rawValue)")
            return
        }
        
        discoveredDevices.removeAll()
        isScanning = true
        
       
        centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
        
        // Timeout
        scanTimeoutWorkItem?.cancel()
        let workItem = DispatchWorkItem { [weak self] in self?.stopScan() }
        scanTimeoutWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: workItem)
    }

    func stopScan() {
        centralManager.stopScan()
        isScanning = false
        scanTimeoutWorkItem?.cancel()
    }

   
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let name = peripheral.name ?? (advertisementData[CBAdvertisementDataLocalNameKey] as? String) ?? "Unknown"
        
      
        
        if targetNames.contains(where: { name.contains($0) }) {
            DispatchQueue.main.async {
                if !self.discoveredDevices.contains(where: { $0.id == peripheral.identifier }) {
                    self.discoveredDevices.append(BLEDevice(id: peripheral.identifier, name: name, peripheral: peripheral))
                }
            }
        }
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            if isScanning { startScan() }
        } else {
            isScanning = false
        }
    }
}
