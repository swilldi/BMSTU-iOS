/*
 Дан массив строк. Нужно сгруппировать строки по количеству символов в ней, вывести результат.
 Подсказка: Используйте правильную коллекцию.
*/

import Foundation

let array = ["a", "b3", "cc", "dfa", "4444444", "dfgdsfg"]
var count_symbols = [Int:Array<String>]()

// перебор элеметов массива
for str in array {
    count_symbols[str.count] = (count_symbols[str.count] ?? []) + [str]
}

for amount in count_symbols.keys.sorted() {
    if let elements = count_symbols[amount] {
        print("\(amount) – \(elements)")
    }
}
