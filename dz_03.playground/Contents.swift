enum BookGenre {
    case adventure
    case fiction
    case science_fiction
    case novel
    case poem
}

struct Book {
    let title: String
    let author: String
    var price: Int
    let genre: BookGenre
}

class Library {
    var bookShelf = [Book]()
    
    init(){}
    
    func addBook(_ book: Book) {
        self.bookShelf.append(book)
    }
    
    func filterBooks(by genre: BookGenre) {
        self.bookShelf.filter { $0.genre == genre }
    }
    
    func filterBooks(by title: String) {
        self.bookShelf.filter { $0.title == title }
    }
    
}

enum SortType {
    case price
    case alphabet
}

class User {
    var name: String
    var discount: Float
    var cart = [Book]()
    
    init(name: String, discount: Float) {
        self.name = name
        self.discount = discount / 100
    }
    
    func addToCart(_ books: [Book]) {
        self.cart.append(contentsOf: books)
    }
    
    func addToCart(_ book: Book) {
        self.cart.append(book)
    }
    
    func sortedListOfBooks(by type: SortType) -> [Book] {
        var sortMethod: (Book, Book) -> Bool
        
        switch type {
        case .alphabet:
            sortMethod = { $0.title > $1.title }
        case .price:
            sortMethod = { $0.price > $1.price }
        }
        
        return self.cart.sorted(by: sortMethod)
    }
    
    func totalPrice() -> Float {
        var price = self.cart.reduce(0) { $0 + ($1.price) }
        return Float(price) * (1 - self.discount)
    }
    
}
