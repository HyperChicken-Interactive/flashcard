import Foundation

class Book: NSObject, NSCoding {
    var title: String
    var author: String
    var pageCount: Int
    var categories: [String]
    var available: Bool
    
    init(title:String, author: String, pageCount:Int, categories:[String],available:Bool) {
        self.title = title
        self.author = author
        self.pageCount = pageCount
        self.categories = categories
        self.available = available
    }
    
    // MARK: NSCoding
    required convenience init?(coder: NSCoder) {
        
        let title = coder.decodeObject(forKey: "title") as! String
        let author = coder.decodeObject(forKey: "author")as! String
        let categories = coder.decodeObject(forKey: "categories") as! [String]
        let available = coder.decodeBool(forKey: "available")
        let pageCount = coder.decodeInteger(forKey: "pageCount")
        
        self.init(title:title, author:author,pageCount:pageCount,categories: categories,available:available)
    }
    
    func encode(with: NSCoder) {
        with.encode(self.title, forKey: "title")
        with.encode(self.author, forKey: "author")
        with.encode(Int32(self.pageCount), forKey: "pageCount")
        with.encode(self.categories, forKey: "categories")
        with.encode(self.available, forKey: "available")
    }
}

var someBook = Book(title: "MyBook", author: "Me", pageCount: 10, categories: ["Fabulousness"], available: true)

var anotherBook = Book(title: "MySecondBook", author: "Me", pageCount: 20, categories: ["Badassitries"], available: false)

var bookshelf: [Book] = [someBook, anotherBook]

// Get documents directory
if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
    
    // Append your file name to the directory path
    let path = (docs as NSString).appendingPathComponent("filename")
    
    // Archive your object to a file at that path
    NSKeyedArchiver.archiveRootObject(bookshelf, toFile: path)
}

bookshelf = [someBook]

// Get documents directory
if let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
    
    // Append your file name to the directory path
    let path = (docs as NSString).appendingPathComponent("filename")
    
    // Unarchive your object from the file
    if let result = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [Book] {
        print("Yeahhh, now it's reyn time!")
        print(result.count)
    } else {
        print ("Bloody hell! We're going to need more power to turn this around!")
    }
    
    // do whatever with yourObject
}

