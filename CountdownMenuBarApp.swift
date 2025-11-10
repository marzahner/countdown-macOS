import SwiftUI

@main
struct CountdownMenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var timer: Timer?
    var endTime: Date?
    var countdownType: CountdownType = .none
    
    enum CountdownType {
        case none
        case fourHour
        case oneHour
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.title = "▶︎"
            button.imagePosition = .imageLeft  // ADD THIS LINE
        }
        
        setupMenu()
    }
    
    func setupMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "4h Countdown", action: #selector(start4HourCountdown), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "1h Countdown", action: #selector(start1HourCountdown), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }
    
    @objc func start4HourCountdown() {
        countdownType = .fourHour
        endTime = Date().addingTimeInterval(4 * 60 * 60)
        startTimer()
        
    }
    
    @objc func start1HourCountdown() {
        countdownType = .oneHour
        endTime = Date().addingTimeInterval(60 * 60)
        startTimer()
        
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateDisplay()
        }
        updateDisplay()
    }
    
    func updateDisplay() {
        guard let endTime = endTime else { return }
        
        let remaining = endTime.timeIntervalSinceNow
        
        if remaining <= 0 {
            timer?.invalidate()
            setButtonTitle("Done!", color: .systemGreen)
            countdownType = .none
            self.endTime = nil
            return
        }
        
        let hours = Int(remaining) / 3600
        let minutes = (Int(remaining) % 3600) / 60
        let seconds = Int(remaining) % 60
        
        let title: String
        if remaining >= 3600 {
            title = String(format: "%dh %02d", hours, minutes)
        } else {
            title = String(format: "%02d:%02d", minutes, seconds)
        }
        
        let color: NSColor = (countdownType == .oneHour)
        ? NSColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 0.5)
        : .tertiaryLabelColor
        
        setButtonTitle(title, color: color)
    }
    
    private func setButtonTitle(_ string: String, color: NSColor = .labelColor) {
        guard let button = statusItem?.button else { return }
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: NSFont.monospacedDigitSystemFont(ofSize: NSFont.systemFontSize, weight: .medium)
        ]
        button.attributedTitle = NSAttributedString(string: string, attributes: attrs)
    }

    
    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
