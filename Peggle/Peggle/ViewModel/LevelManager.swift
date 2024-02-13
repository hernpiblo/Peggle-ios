//
//  LevelManager.swift
//  Peggle
//
//  Created by proglab on 1/2/24.
//

import Foundation

class LevelManager {
    static func saveLevel(_ level: Level) -> Bool {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(level)
            let fileURL = getFileURL(level.name)
            try data.write(to: fileURL)
            print("Successfully saved level \(level.name)")
            return true
        } catch {
            print("Error saving level \(level.name): \(error.localizedDescription)")
            return false
        }
    }

    static func loadLevel(_ levelName: String) -> Level? {
        guard !levelName.isEmpty else { return nil }
        let fileURL = getFileURL(levelName)
        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            do {
                let level: Level = try decoder.decode(Level.self, from: data)
                print("Successfully loaded level \(level.name)")
                return level
            } catch {
                print("Error decoding level \(levelName): \(error.localizedDescription)")
                return nil
            }
        }
        return nil
    }

    static func deleteLevel(_ levelName: String) {
        guard !levelName.isEmpty else { return }
        let fileURL = getFileURL(levelName)
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("Successfully deleted level \(levelName)")
        } catch {
            print("Error deleting level file \(levelName): \(error.localizedDescription)")
        }
    }

    static func listAllLevels() -> [String] {
        let documentsURL = getDirectory()
        do {
            let fileURLs = try FileManager.default
                .contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            let levelNames = fileURLs
                .filter { $0.pathExtension == "json" }
                .map { $0.deletingPathExtension().lastPathComponent }
            return levelNames
        } catch {
            print("Error listing levels: \(error.localizedDescription)")
            return []
        }
    }
    
    private static func checkLevelNameExist(_ levelName: String) -> Bool {
        return listAllLevels().contains(levelName)
    }

    private static func getFileURL(_ levelName: String) -> URL {
        return getDirectory().appendingPathComponent("\(levelName).json")
    }

    private static func getDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
