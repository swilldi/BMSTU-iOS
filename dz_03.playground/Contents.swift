enum BookGenre {
    case adventure
    case fiction
    case science_fiction
    case novel
    case poems
}

struct Book: CustomStringConvertible {
    let title: String
    let author: String
    var price: Int
    let genre: BookGenre
    
    var description: String {
        "'\(title)', \(author), \(genre) – \(price)"
    }
}

class Library {
    var bookShelf = [Book]()
    
    init(){}
    
    func addBook(_ book: Book) {
        self.bookShelf.append(book)
    }
    
    func filterBooks(by genre: BookGenre) -> [Book] {
        self.bookShelf.filter { $0.genre == genre }
    }
    
    func filterBooks(byName title: String) -> [Book] {
        self.bookShelf.filter { $0.title.contains(title) }
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


let library = Library()
library.addBook(
    Book(
        title: "Гарри Поттер и философский камень",
        author: "Дж.К. Роулинг",
        price: 1000,
        genre: .fiction
    )
)
library.addBook(
    Book(
        title: "Война и мир",
        author: "Лев Толстой",
        price: 850,
        genre: .novel
    )
)
library.addBook(
    Book(
        title: "Стихотворение",
        author: "Владимир Маяковский",
        price: 540,
        genre: .poems
    )
)

let booooks = [
    Book(
        title: "451 градус по Фаренгейту",
        author: "Рэй Брэдбери",
        price: 600,
        genre: .fiction
    ),
    Book(
        title: "Собачье сердце",
        author: "Михаил Булгаков",
        price: 400,
        genre: .science_fiction
    )
    
]

let user = User(name: "Алиса", discount: 1.5)
let novelBooks = library.filterBooks(by: .novel)
user.addToCart(novelBooks)
let booksWithName = library.filterBooks(byName: "Гарри")
user.addToCart(booksWithName)

user.addToCart(booooks)

print("Итоговая корзина: \(user.sortedListOfBooks(by: .alphabet))")
print("Цена корзины: \(user.totalPrice())")
