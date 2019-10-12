import UIKit

enum myError: Error {
    case errorNil
    case errorAnotherType
}


/// Универсальный класс, позволяет добавлять элементы в Userdefaults и забирать элементы того же типа, в ином случае выбрасывает ошибку
class MyStorage <T> {

    func addElem(elem:T, key:String){
        UserDefaults.standard.set(elem, forKey: key)
    }
    
    func getElem(with result: String) throws -> T{
        let nn = UserDefaults.standard.object(forKey: result)
        switch nn {
        case nil: throw myError.errorNil
        case is T: return nn as! T
        default: throw myError.errorAnotherType
        }
    }
    
    func examp(key: String)->Result<T, Error>{
        do {
                let exam = try getElem(with: key)
                return .success(exam)
        } catch (let myError){
            return .failure(myError)
        }
    }

}
UserDefaults.standard.dictionaryRepresentation()

// Добавляем переменную типа Double
print("Double result:")
let doubleValue = MyStorage<Double>()
print(doubleValue.examp(key: "четырнадцать с половиной"))
doubleValue.addElem(elem: 15.5, key: "пятнадцать с половиной")
print(doubleValue.examp(key: "пятнадцать с половиной"))
print("\n")

/// Добавляем тип Int
print("Int result:")
let intValue = MyStorage<Int>()
intValue.addElem(elem: 15, key: "fifteen")
print(intValue.examp(key: "fifteen"))
print(intValue.examp(key: "пятнадцать с половиной"))
print(intValue.examp(key: "15"))
print("\n")

// Добавляем масссив
print("Array result:")
let array = ["Hello","World"]
let myArray = MyStorage<[String]>()
myArray.addElem(elem: array, key: "array")
print(myArray.examp(key: "array"))
print(myArray.examp(key: "пятнадцать с половиной"))
print(intValue.examp(key: "myArray"))
print("\n")
