/*
 Дана строка, состоящая только из круглых скобок. Проверить является ли последовательность скобок корректной и вывести результат в консоль.
 let string1 = "(())"
 Output: Корректная

 let string2 = "))(("
 Output: Некорректная

 let string1 = "()()()"
 Output: Корректная
 */

import Foundation

let string = "(())))"
var count_open: Int = 0
var result = "Корректная"

for symbol in string {
    if symbol == "(" {
        count_open += 1
    } else {
        count_open -= 1
    }
    
    if count_open < 0 {
        result = "Некорректная"
        break
    }
}

if count_open != 0 {
    result = "Некорректная"
}

print(result)
