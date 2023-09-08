import CoreData

extension URL {
    static var storeURL: URL = {
        let defaultDirectoryURL = NSPersistentContainer.defaultDirectoryURL()
        let url = defaultDirectoryURL.appendingPathComponent("CoreDataModel.sqlite")
        return url
    }()
}

struct PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "CoreDataModel")

        if let description = container.persistentStoreDescriptions.first {
            description.url = .storeURL
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
