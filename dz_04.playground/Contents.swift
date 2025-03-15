// Протокол, чтобы экземпляр мог лечиться
protocol Healable {
    var health: Int { get set }
    func heal(amount: Int)
}


// Протокол, чтобы экземпляр мог летать
protocol Flyable {
    var flightSpeed: Int { get set }
    func fly()
}

//
protocol Item {
    var label: String { get }
    var type: ItemType { get }
    var action: (GameCharacter) -> () { get }
    func use(to character: GameCharacter)
}


enum ItemType: Equatable {
    enum PotionSize: Int {
        case small = 20
        case medium = 40
        case large = 80
    }
    
    case heal(value: PotionSize)
    case levelUp
    
    static func == (lhs: ItemType, rhs: ItemType) -> Bool {
        lhs.label == rhs.label
    }
    
    var label: String {
        switch self {
        case .heal(let value):
            "Зелье лечения \(value) HP"
        case .levelUp:
            "Зелье повышения уровня"
        }
    }
}


class Potion: Item, CustomStringConvertible {
    
    let type: ItemType
    var label: String
    let action: (GameCharacter) -> Void
    
    init(type: ItemType) {
        self.type = type
        self.label = type.label
        self.action = {
            switch type {
            case .heal(let value):
                $0.heal(amount: value.rawValue)
            case .levelUp:
                $0.levelUp()
            }
        }
        
    }
    
    func printAbout() {
        print(self)
    }
    
    func use(to character: GameCharacter) {
        action(character)
    }
    
    var description: String { label }
    
}


class GameCharacter: Healable {
    // начальные значения характиристик
    let defaultHealth = 100
    let defaultLevel = 1
    
    // коэффициенты повышение характиристик
    let healthCoefficient = 10
    
    // объявляем поля класса
    let name: String
    var maxHealth: Int
    var health: Int
    var level: Int
    var inventory = [Item]()
    
    
    init(name: String, health: Int, level: Int) {
        self.name = name
        self.level = level <= 0 ? defaultLevel : level
        maxHealth = (health <= 0 ? defaultHealth : health) + healthCoefficient * (self.level - defaultLevel)
        self.health = maxHealth
    }
    
    // получение урона
    func takeDamage(amount damage: Int) {
        health -= damage
        if health < 0 {
            health = 0
        }
    }
    
    // востановление здоровья
    func heal(amount points: Int) {
        health += points
        if health > maxHealth {
            health = maxHealth
        }
    }
    
    // повышение уровня и характеристик
    func levelUp() {
        level += 1
        maxHealth += healthCoefficient
        health = maxHealth
    }
    
    func takeItem(item: Item) {
        inventory.append(item)
    }
    
//    func use(item: ItemType) {
//        print(self)
//        var wasFinded = (false, 0)
//        for i in 0..<inventory.count {
//            if inventory[i].type == item {
//                inventory[i].use(to: self)
//                wasFinded = (true, i)
//                break
//            }
//        }
//        if wasFinded.0 {
//            inventory.remove(at: wasFinded.1)
//        }
//    }
}


// Добавляем раширение для класса GameCharacter
extension GameCharacter {
    var isAlive: Bool { health > 0}
}

extension GameCharacter{
    func printCharacterInfo() {
        print(
        """
        Name: \(name)
        Level: \(level)
        Health: \(health)
        Inventory: \(inventory)
        """
        )
    }
}


class Warrior: GameCharacter {
    // начальные значения характиристик
    let defaultArmor = 2
    let defaultPower = 10
    
    // коэффициенты повышение характиристик
    let armorCoefficient = 1
    let powerCoefficient = 1
    
    // объявляем поля класса
    var power: Int
    var armor: Int
    
    
    init(name: String, health: Int, armor: Int, power: Int, level: Int) {
        self.armor = armor <= 0 ? defaultArmor : armor
        self.power = power <= 0 ? defaultPower : power
        super.init(name: name, health: health, level: level)
        
        // повышение характеристик в соответсвии с уровнем персонажа
        self.armor += armorCoefficient * (level - defaultLevel) / 2
        self.power += powerCoefficient * (level - defaultLevel)
    }
    
    // атака другого экземпляра класса GameCharacter
    func attack(target: GameCharacter) {
        target.takeDamage(amount: power)
    }
    
    // получение уроная с учетом брони
    override func takeDamage(amount damage: Int) {
        if damage > armor {
            super.takeDamage(amount: damage - armor)
        }
    }
    
    // повышение уровня и характеристик
    override func levelUp() {
        super.levelUp()
        power += powerCoefficient
        if level % 2 != 0 {
            armor += armorCoefficient
        }
    }
    
}


class Mage: GameCharacter, Flyable {
    // начальные значения характиристик
    let defaultPhysicPower = 5
    let defaultMagicPower = 10
    
    // коэффициенты повышение характиристик
    let physicPowerCoefficient = 1
    let magicPowerCoefficient = 1
    
    // объявляем поля класса
    var magicPower: Int
    var physicPower: Int
    var flightSpeed = 10
    
    init(name: String, health: Int, magicPower: Int, physicPower: Int, level: Int) {
        self.magicPower = magicPower <= 0 ? magicPower : defaultMagicPower
        self.physicPower = physicPower <= 0 ? physicPower : defaultPhysicPower
        super.init(name: name, health: health, level: level)
        
        self.magicPower += magicPowerCoefficient * (level - defaultLevel)
        self.physicPower += physicPowerCoefficient * (level - defaultLevel)
    }
    
    // атака другого экземпляра класса GameCharacter
    func attack(target: GameCharacter) {
        target.takeDamage(amount: physicPower)
    }
    
    // усиленная атака другого экземпляра класса GameCharacter
    func magicAttack(target: GameCharacter) {
        target.takeDamage(amount: physicPower + magicPower)
    }
    
    func fly() {
        print("I can fly \(flightSpeed) m/h")
    }
    
    // повышение уровня и характеристик
    override func levelUp() {
        super.levelUp()
        magicPower += magicPowerCoefficient
        if level % 2 != 0 {
            physicPower += physicPowerCoefficient
        }
    }
}



// Тестирование GameCharacter
let healPotion = Potion(type: .heal(value: .small))
var player_1 = GameCharacter(name: "player_1", health: 100, level: 1)
for _ in 0...2 { player_1.takeItem(item: healPotion) }
//player_1.takeDamage(amount: 30)
//player_1.use(item: .heal(value: .small))
//player_1.health
//player_1.printCharacterInfo()



var a: Array<Item> = Array(repeating: healPotion, count: 3)
//for (i, v) in a.enumerated() {
//    if v.type == .heal(value: .small) {
//        a.remove(at: i)
//        break
//    }
//}
//print(123)
a.remove(at: 1)
print(a)

