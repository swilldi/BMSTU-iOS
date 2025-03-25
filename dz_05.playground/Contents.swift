// MARK: ЗАДАНИЕ 5

// MARK: Классы с циклической ссылкой
//class Person {
//    let name: String
//    var car: Car?
//
//    init(name: String) {
//        print("Создан \(name)")
//        self.name = name
//    }
//
//    deinit
//    {
//        print("Уничтожен \(name)")
//    }
//}
//
//class Car {
//    var color: String
//    var owner: Person?
//
//    init(color: String, owner: Person?)
//    {
//        print("Создана машина \(color)")
//        self.color = color
//        self.owner = owner
//    }
//
//    deinit
//    {
//        print("Уничтожена машина \(color)")
//    }
//}
//
//if true {
//    let person = Person(name: "Jack")
//    let car: Car? = Car(color: "Red", owner: person)
//    person.car = car
//
//    print()
//}
//
//print()


//MARK: Без циклического замыкания
//class Person {
//    let name: String
//    weak var car: Car?
//
//    init(name: String) {
//        print("Создан \(name)")
//        self.name = name
//    }
//
//    deinit
//    {
//        print("Уничтожен \(name)")
//    }
//}
//
//class Car {
//    var color: String
//    var owner: Person?
//
//    init(color: String, owner: Person?)
//    {
//        print("Создана машина \(color)")
//        self.color = color
//        self.owner = owner
//    }
//
//    deinit
//    {
//        print("Уничтожена машина \(color)")
//    }
//}
//
//if true {
//    let person = Person(name: "Jack")
//    let car: Car? = Car(color: "Red", owner: person)
//    person.car = car
//}
//print()



// MARK: ЗАДАНИЕ 6

//class Animal {
//    let name: String
//
//    init(name: String)
//    {
//        self.name = name
//    }
//
//    func speak() {}
//
//}
//
//class Dog: Animal {
//    let voice = "Woaf!"
//
//    override func speak()
//    {
//        print(voice)
//    }
//}
//
//class Cat: Animal {
//    let voice = "Meow!"
//
//    override func speak()
//    {
//        print(voice)
//    }
//}
//
//let dog_1 = Dog(name: "Astin"), dog_2 = Dog(name: "Crocky"), cat_1 = Cat(name: "Tom")
//let animals: Array<Animal> = [dog_1, cat_1, dog_2]
//for animal in animals {
//    animal.speak()
//}

/*
 При наследовании используется virtual table диспечиризация, и поэтому для переорпеделяемого
 метода в дочернем классе изменяется указатель на реалицаю метода. Из-за этого
 реализация метода speak в Cat, Dog, Animal не связаны.
 
 Поэтому для экземпляров класса Dog будет вызываться метод Dog.speak (строка 105, если я ничего не поменял),
 для экземпляров класса Cat будет вызываться метод Cat.speak (строка 114).
 Потому что опять же, у каждого из данных подклассов собсвенный указатель на реализацию метода speak
*/
