import PackageDescription

let package = Package(
    name: "resource",
    dependencies: [
        .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/JohnSundell/Files.git", majorVersion: 1, minor: 5),
        .Package(url: "https://github.com/kareman/SwiftShell.git", "3.0.0-beta.11")
    ]
)
