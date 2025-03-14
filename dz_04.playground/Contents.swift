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


enum ItemType: String {
    case healingPothion = "Целебное зелье"
    case levelUppingPotion = "Зелье повышения уровня"

    var action: (GameCharacter) -> () {
        switch self {
        case .healingPothion:
            { character in character.heal(amount: 20) }
        case .levelUppingPotion:
            { character in character.levelUp() }
        }
    }
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
    var inventory = [String:Int]()
    var dustinessInventory = 10
    
    
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
        inventory[item.label] = 1 + (inventory[item.label] ?? 0)
    }
    
    func use(item: Item) {
        if inventory[item.label] ?? 0 > 0 {
            inventory[item.label]! -= 1
            item.action(self)
        }
    }
}


// Добавляем раширение для класса GameCharacter
extension GameCharacter {
    var isAlive: Bool { health > 0}
    func printCharacterInfo() {
        print("Name: \(name)\nLevel: \(level)\nHealth: \(health)")
    }
}

    
let player = GameCharacter(name: "Player_1", health: 100, level: -1)
player.maxHealth
player.levelUp()
player.maxHealth


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


struct Potion: Item {
    let type: ItemType
    var label: String
    let action: (GameCharacter) -> ()
    
    init(type: ItemType) {
        self.type = type
        self.label = type.rawValue
        self.action = type.action
    }
    
    func use(to character: GameCharacter) {
        action(character)
    }
}


