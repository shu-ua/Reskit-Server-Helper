// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestValue.swift instead.

import CoreData

public enum TestValueAttributes: String {
    case text = "text"
}

@objc public
class _TestValue: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "TestValue"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _TestValue.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var text: NSDate?

    // func validateText(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

}

