import SwiftUI
import CoreBluetooth


enum AppColors {
    static let orangePrimary = Color(hex: 0xFFFF822E)
    
    // Dark Theme
    static let darkBackground = Color(hex: 0xFF121212)
    static let darkSurface = Color(hex: 0xFF292929)
    static let textWhite = Color(hex: 0xFFFFFFFF)
    
    // Light Theme
    static let lightBackground = Color(hex: 0xFFF2F2F2)
    static let lightSurface = Color.white
    static let textBlack = Color.black
}

struct AppTheme {
    static func background(for scheme: ColorScheme) -> Color {
        scheme == .dark ? AppColors.darkBackground : AppColors.lightBackground
    }
    
    static func textPrimary(for scheme: ColorScheme) -> Color {
        scheme == .dark ? AppColors.textWhite : AppColors.textBlack
    }
}


struct DeviceRow: View {
    let device: BLEDevice
    var body: some View {
        VStack(alignment: .leading) {
            Text(device.name).font(.body).fontWeight(.bold)
            Text(device.id.uuidString).font(.caption).foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}



struct DeviceDetailView: View {
    let device: BLEDevice
    @StateObject var viewModel: DeviceViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var scheme

    init(device: BLEDevice) {
        self.device = device
        _viewModel = StateObject(wrappedValue: DeviceViewModel(peripheral: device.peripheral))
    }

    var body: some View {
        VStack(spacing: 0) {
        
            ZStack {
                AppColors.orangePrimary
                VStack {
                    Text(device.name)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    Text(viewModel.connectionStatus)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .frame(height: 140)

            // Content
            VStack(spacing: 40) {
                Spacer()
                
                VStack {
                    Text("Temperature")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    Text(viewModel.temperature)
                        .foregroundColor(AppTheme.textPrimary(for: scheme))
                        .font(.system(size: 60, weight: .bold))
                }

            
                HStack(alignment: .top) {
                    InfoItemView(label: "Humidity", value: viewModel.humidity)
                    Spacer()
                    InfoItemView(label: "Battery", value: viewModel.battery)
                    Spacer()
                    InfoItemView(label: "RSSI", value: viewModel.rssi)
                }
                .padding(.horizontal, 20)

                Spacer()
                
         
                Button(action: {
                    viewModel.disconnect()
                    dismiss()
                }) {
                    Text("Disconnect")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(AppColors.orangePrimary)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 30)
            }
            .background(AppTheme.background(for: scheme))
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.connect()
        }
    }
}


struct InfoItemView: View {
    @Environment(\.colorScheme) var scheme
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            Text(label)
                .foregroundColor(.gray)
                .font(.system(size: 14))
            Text(value)
                .foregroundColor(AppTheme.textPrimary(for: scheme))
                .font(.system(size: 20, weight: .bold))
                .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity)
    }
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
