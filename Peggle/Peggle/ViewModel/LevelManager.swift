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
            let fileURL = getFileURL(level.getName())
            try data.write(to: fileURL)
            return true
        } catch {
            print("Error saving level \(level.getName()): \(error.localizedDescription)")
            return false
        }
    }


    static func loadLevel(levelName: String) -> Level? {
        let fileURL = getFileURL(levelName)
        if let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            do {
                let level: Level = try decoder.decode(Level.self, from: data)
                return level
            } catch {
                print("Error decoding level \(levelName): \(error.localizedDescription)")
                return nil
            }
        }
        return nil
    }


    static func deleteLevel(_ levelName: String) {
        let fileURL = getFileURL(levelName)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Error deleting level file \(levelName): \(error.localizedDescription)")
        }
    }


    static func checkLevelNameExist(_ levelName: String) -> Bool {
        return listAllLevels().contains(levelName)
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


    private static func getFileURL(_ levelName: String) -> URL {
        return getDirectory().appendingPathComponent("\(levelName).json")
    }


    private static func getDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
