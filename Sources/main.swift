import Foundation
import Commander
import Files

command(
    Argument<String>("resources-folder", description: "")
) { resourcesFolder in
    do {
        try ResourcesOperation(resourcesFolder: resourcesFolder).execute()
    } catch {
        print("There was an error copying the resources: \(error)")
    }
}.run()
