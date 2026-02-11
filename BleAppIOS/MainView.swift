import SwiftUI

struct MainView: View {
    @StateObject private var bleScanner = BLEScanner()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(bleScanner.discoveredDevices) { device in
                    NavigationLink(destination: DeviceDetailView(device: device)) {
                        DeviceRow(device: device)
                    }
                    .listRowBackground(Color(UIColor.systemBackground))
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    bleScanner.startScan()
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
                
                Button(action: {
                    bleScanner.isScanning ? bleScanner.stopScan() : bleScanner.startScan()
                }) {
                    Text(bleScanner.isScanning ? "STOP SCAN" : "START SCAN")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange) // Pomarańczowy przycisk
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 24)
            }
            .toolbar(.hidden, for: .navigationBar)
            .preferredColorScheme(.dark) 
        }
    }
}
