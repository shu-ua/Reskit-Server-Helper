@objc(TestValue)
public class TestValue: _TestValue {

	// Custom logic goes here.
    
    
    class func getCount() -> Int {
        if let context = RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext {
            let request = NSFetchRequest(entityName: TestValue.entityName())            
            do {
                let array  = try context.executeFetchRequest(request)
                return array.count
            } catch {
                return 0
            }
        } else {
            return 0
        }        
    }

}
