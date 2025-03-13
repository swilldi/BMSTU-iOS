class GameCharacter {
    let defaultHealth = 100
    let defaultLevel = 1
    let healthCoefficient = 10
    
    let name: String
    var maxHealth: Int
    var health: Int
    var level: Int
    
    
    init(name: String, health: Int, level: Int) {
        self.name = name
        self.level = level <= 0 ? defaultLevel : level
        maxHealth = (health <= 0 ? defaultHealth : health) + healthCoefficient * (self.level - defaultLevel)
        self.health = maxHealth
    }
    
    func takeDamage(amount damage: Int) {
        health -= damage
        if health < 0 {
            health = 0
        }
    }
    
    func heal(amount points: Int) {
        health += points
        if health > maxHealth {
            health = maxHealth
        }
    }
    
    func levelUp() {
        // повышаем характеристики
        level += 1
        maxHealth += healthCoefficient
        health = maxHealth
    }
}


let player = GameCharacter(name: "Player_1", health: 100, level: -1)
player.maxHealth
player.levelUp()
player.maxHealth


class Warrior: GameCharacter {
    let defaultArmor = 2
    let defaultPower = 10
    let armorCoefficient = 1
    let powerCoefficient = 1
    
    var power: Int
    var armor: Int
    
    
    init(name: String, health: Int, armor: Int, power: Int, level: Int) {
        self.armor = armor <= 0 ? defaultArmor : armor
        self.power = power <= 0 ? defaultPower : power
        super.init(name: name, health: health, level: level)
        
        self.armor += armorCoefficient * (level - defaultLevel) / 2
        self.power += powerCoefficient * (level - defaultLevel) / 2
    }
    
    func attack(target: GameCharacter) {
        target.takeDamage(amount: power)
    }
    
    override func takeDamage(amount damage: Int) {
        if damage > armor {
            super.takeDamage(amount: damage - armor)
        }
    }
    
    override func levelUp() {
        // повышаем характеристики
        super.levelUp()
        armor += armorCoefficient
        power += powerCoefficient
    }
    
}

let warrior_1 = Warrior(name: "warrior_1", health: 100, armor: 2, power: 10, level: 10)



