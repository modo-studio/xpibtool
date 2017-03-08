import Foundation
import Files
import SwiftShell

//Argument<String>("minimum-deployment-target", description: "iOS/watchOS/macOS/tvOS")

enum ResourcesError: Error {
    case missingTargetTempDir
    case missingSrcroot
    case missingTargetBuildDir
    case missingUnlocalizedResourcesFolderPath
    case invalidPlatform
}

struct ResourcesOperation: Operation {
    
    // MARK: - Attributes
    
    let resourcesFolder: String

    // MARK: - <Operation>
    
    func execute() throws {
//        let resources = try Folder(path: resourcesFolder).makeFileSequence(recursive: true, includeHidden: false)
//        let targetTempDir = try getTargetTempDir()
//        let srcRoot = try getSrcroot()
//        let targetBuildDir = try getTargetBuildDir()
//        let unlocalizedResourcesFolderPath = try getUnlocalizedResourcesFolderPath()
//        let storyboards = resources
//            .filter { $0.extension == "storyboard" }
//            .filter { $0.nameExcludingExtension.contains(platform.rawValue) }
//        for storyboard in storyboards {
//            var command: [String] = ["ibtool"]
//            command.append("--errors --warnings --notices")
//            command.append("--auto-activate-custom-fonts")
//            command.append("--minimum-deployment-target \(minimumDeploymentTarget)")
//            command.append("--output-format human-readable-text")
//            command.append("--compilation-directory \(targetTempDir)")
//            command.append(storyboard.path)
//            try runAndPrint(bash: command.joined(separator: " "))
//            let linkPath = "\(targetBuildDir)/\(unlocalizedResourcesFolderPath)"
//            try runAndPrint(bash: "ibtool --link \(linkPath) \(targetTempDir)/")
//        }
        
        //        let xibs = resources
        //            .filter { $0.extension == "xib" }
        //            .filter { $0.nameExcludingExtension.contains(platform.rawValue) }
    }
    
    // MARK: - Private
    
    // targetTempDir: /.../Library/Developer/Xcode/DerivedData/.../UI.build/Debug-iphonesimulator/UI.build
    // srcroot: /.../code/soundcloud-ios/Frameworks/UI
    // targetBuildDir: /.../Library/Developer/Xcode/DerivedData/SoundCloud-abtiicbwqznswvbtsacwntaahqmc/Build/Products/Debug-iphonesimulator
    // unlocalizedResourcesFolderPath: UI.framework
    
    private func getTargetTempDir() throws -> String {
        guard let targetTempDir = ProcessInfo.processInfo.environment["TARGET_TEMP_DIR"] else {
            throw ResourcesError.missingTargetTempDir
        }
        return targetTempDir
    }
    
    private func getSrcroot() throws -> String {
        guard let srcroot = ProcessInfo.processInfo.environment["SRCROOT"] else {
            throw ResourcesError.missingSrcroot
        }
        return srcroot
    }
    
    private func getTargetBuildDir() throws -> String {
        guard let targetBuildDir = ProcessInfo.processInfo.environment["TARGET_BUILD_DIR"] else {
            throw ResourcesError.missingTargetBuildDir
        }
        return targetBuildDir
    }
    
    private func getUnlocalizedResourcesFolderPath() throws -> String {
        guard let unlocalizedResourcesFolderPath = ProcessInfo.processInfo.environment["UNLOCALIZED_RESOURCES_FOLDER_PATH"] else {
            throw ResourcesError.missingUnlocalizedResourcesFolderPath
        }
        return unlocalizedResourcesFolderPath
    }
    
    private func getPlatform() throws -> Platform {
        if let mdt = ProcessInfo.processInfo.environment["WATCHOS_DEPLOYMENT_TARGET"] {
            return .watchOS(minimumDeploymentTarget: mdt)
        }
        else if let mdt = ProcessInfo.processInfo.environment["IPHONEOS_DEPLOYMENT_TARGET"] {
            return .iOS(minimumDeploymentTarget: mdt)
        }
        else if let mdt = ProcessInfo.processInfo.environment["TVOS_DEPLOYMENT_TARGET"] {
            return .tvOS(minimumDeploymentTarget: mdt)
        }
        else if let mdt = ProcessInfo.processInfo.environment["MACOSX_DEPLOYMENT_TARGET"] {
            return .macOS(minimumDeploymentTarget: mdt)
        }
        else {
            throw ResourcesError.invalidPlatform
        }
    }
}
