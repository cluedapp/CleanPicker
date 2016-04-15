//
//  ViewController.swift
//  CleanPicker
//
//  Created by Theo Fitchat on 2016-04-07.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

import AppKit
import EonilFileSystemEvents

class ViewController: NSViewController {

    // MARK: UI Outlets

    @IBOutlet weak var btnSelectDir: NSButton!

    // MARK: UI Event handlers

    @IBAction func selectDir (sender: NSButton) {
        let openPanel = NSOpenPanel()

        openPanel.title = "Choose a directory to monitor";
        openPanel.showsResizeIndicator = true;
        openPanel.showsHiddenFiles = true;
        openPanel.canChooseDirectories = true;
        openPanel.canCreateDirectories = true;
        openPanel.allowsMultipleSelection = false;
        openPanel.allowedFileTypes = ["*.*:"]

        if openPanel.runModal() == NSModalResponseOK {
            let path = openPanel.URLs[0].URLByResolvingSymlinksInPath!.path!

            var paths = self.settings % Keys.Directories
            for existingPath in paths {
                if path == existingPath {
                    openPanel.close()
                    self.alert("The selected path is already added and monitored", "Path already added") { Thread.ui(self.selectDir(sender)) }
                    return
                }
            }
            paths += [path]
            self.settings.updateValue(paths, forKey: Keys.Directories.rawValue)
            self.saveSettings()
            self.watch()
        }
    }

    // MARK: Private logic

    private var m = [FileSystemEventMonitor]()
    private var settings: [String : AnyObject]!

    private func loadSettings () {
        if let data = Strings.SettingsPath.read() {
            settings = Json.dictWithJson(data)
        } else {
            settings = [String : AnyObject]()
            settings[Keys.DeleteFilenames.rawValue] = [String]()
            settings[Keys.DeleteDirectories.rawValue] = [String]()
            settings[Keys.DeleteFilenamesStartingWith.rawValue] = [String]()
            settings[Keys.DeleteDirectoriesStartingWith.rawValue] = [String]()
        }
    }

    private func saveSettings () {
        Strings.SettingsPath.write(Json.jsonWithDict(settings)!)
    }

    private func watch () {
        if settings[Keys.Directories.rawValue]?.count > 0 {
            m += [FileSystemEventMonitor(
                pathsToWatch: settings % Keys.Directories,
                latency: 1,
                watchRoot: true,
                queue: dispatch_get_main_queue()
            ) { (events: [FileSystemEvent]) -> () in
                for event in events {
                    self.handle(event) }
                }]
        }
    }

    private func handle (event: FileSystemEvent) {
        if !event.flag.intersect([.ItemCreated]).isEmpty {

            let man = NSFileManager()

            var delete = settings % Keys.DeleteFilenames
            for filename in delete where filename != "" {
                let components = event.path.split("/")!
                let exists = man.fileExistsAtPath(event.path)
                if exists && components[components.count - 1] == filename && man.isDeletableFileAtPath(event.path) {
                    do {
                        try man.removeItemAtPath(event.path)
                        log("Deleted: " + event.path)
                    }
                    catch {
                        log("Failed to delete: " + event.path)
                    }
                }
            }

            delete = settings % Keys.DeleteDirectories
            for directory in delete where directory != ""  {
                let components = event.path.replace("/$", Strings.Empty)!.split("/")!
                var isDir: ObjCBool = false
                let exists = man.fileExistsAtPath(event.path, isDirectory: &isDir)
                if isDir && exists && components[components.count - 1] == directory && man.isDeletableFileAtPath(event.path) {
                    do {
                        try man.removeItemAtPath(event.path)
                        log(event.path)
                    }
                    catch {
                        log("Failed to delete: " + event.path)
                    }
                }
            }

            delete = settings % Keys.DeleteFilenamesStartingWith
            for filename in delete where filename != "" {
                let components = event.path.split("/")!
                let exists = man.fileExistsAtPath(event.path)
                if exists && components[components.count - 1].replace(".", "\\.")!.isMatch("^" + filename) && man.isDeletableFileAtPath(event.path) {
                    do {
                        try man.removeItemAtPath(event.path)
                        log(event.path)
                    }
                    catch {
                        log("Failed to delete: " + event.path)
                    }
                }
            }

            delete = settings % Keys.DeleteDirectoriesStartingWith
            for directory in delete where directory != "" {
                let components = event.path.replace("/$", Strings.Empty)!.split("/")!
                var isDir: ObjCBool = false
                let exists = man.fileExistsAtPath(event.path, isDirectory: &isDir)
                if isDir && exists && components[components.count - 1].replace(".", "\\.")!.isMatch("^" + directory) && man.isDeletableFileAtPath(event.path) {
                    do {
                        try man.removeItemAtPath(event.path)
                        log(event.path)
                    }
                    catch {
                        log("Failed to delete: " + event.path)
                    }
                }
            }
        }
    }

    private func log (path: String) {
        Strings.LogFilePath.write(path + "\n", true)
    }

    // MARK: Status Bar

    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)

    private func addStatusItem () {
        statusItem.highlightMode = true
        /*
        statusItem.title = Strings.AppTitle
        statusItem.enabled = true
        */

        if let button = statusItem.button {
            button.image = NSImage(named: "AppIcon")
            // button.action = #selector(popupMenu)
        }

        let menu = NSMenu()
        var item: NSMenuItem

        item = NSMenuItem(title: "Safe Mode", action: #selector(safeMode), keyEquivalent: "S")
        item.enabled = true
        menu.addItem(item)
        menu.addItem(NSMenuItem.separatorItem())
        item = NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q")
        item.enabled = true
        menu.addItem(item)

        statusItem.menu = menu
    }


    func popupMenu () {

    }

    func safeMode () {

    }

    func quit () {
        
    }

    // MARK: Default event handlers

    required init? (coder: NSCoder) {
        super.init(coder: coder)

        loadSettings()
        watch()
        addStatusItem()
    }

    override func viewDidLoad () {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear () {
        super.viewDidAppear()

        view.window!.title = Strings.AppTitle
    }

    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}
