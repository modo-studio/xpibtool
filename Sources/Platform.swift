import Foundation

enum Platform {
    case iOS(minimumDeploymentTarget: String)
    case macOS(minimumDeploymentTarget: String)
    case watchOS(minimumDeploymentTarget: String)
    case tvOS(minimumDeploymentTarget: String)
}
