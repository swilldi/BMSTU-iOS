// Создать перечисление математических операций над одним или двумя числами (сложение, деление, умножение, вычитание, квадрат числа, корень и другие, какие вы хотите).
// Минимум 5 различных операций.
// И дан массив, который состоит из математической операции и числами, над которым операция выполняется. Вывести результат всех операций.
//Подсказка: Используйте enum с ассоциативными значениями.
//let array1 = [.sum(1, 2), .square(2)]
//Output:bb
//Сумма - 3
//Квадрат - 4

import Foundation

enum mathFunc {
    case sum(Int, Int)
    case difference(Int, Int)
    case multiplication(Int, Int)
    case division(Int, Int)
    
    case sqrt(Int)
    case square(Int)
    
    case expDegree(Int)
    case power(Int, Int)
}

let actionArray: Array<mathFunc> = [.sum(1, 2), .square(2)]
for action in actionArray {
    var actionInfo: String
    switch action {

    case sum(let a, let b):
        actionInfo = "Сумма | \(a) + \(b) = \(a + b)"
    case difference(let a, let b):
        actionInfo = "Разница | \(a) - \(b) = \(a - b)"
    case multiplication(let a, let b):
        actionInfo = "Произведение | \(a) * \(b) = \(a * b)"
    case division(let a, let b):
        actionInfo = "Частное | \(a) / \(b) = \(Float(a) / Float(b))"
    
    case sqrt(let a):
        actionInfo = "Квадратный корень | \(a)^(1/2) = \(sqrt(a))"
    case square(let a):
        actionInfo = "Квадрат | \(a)^2 = \(a * a)"
        
    case power(let a, let b):
        actionInfo = "Возведение в степень | \(a)^\(b) = \(pow(a, b))"
    case expDegree(let a):
        actionInfo = "Экспонента в степени | e^\(a) = \(exp(a))"
    
    }
    print(actionInfo)
}
