import UIKit

enum myError: Error {
    case error
}


/// Универсальный класс? позволяет добавлять элементы в Userdefaults и забирать их.
/// Проверяет, выдает ли указатель на объект или nil. Выбрасывает ошибку в случае nil
class MyStorage <T> {

    func addElem(elem:T, key:String){
        UserDefaults.standard.set(elem, forKey: key)
    }
    
    func getElem(with result: String) throws -> Any {
        let nn = UserDefaults.standard.object(forKey: result)
        switch nn {
        case nil: throw myError.error
        default: return nn!
        }
    }
    
    func examp(key: String)->Result<Any, Error>{
        do {
                let exam = try getElem(with: key)
                return .success(exam)
        } catch (let myError){
            return .failure(myError)
        }
    }

}


/// Добавляем тип Int
let intValue = MyStorage<Int>()
print(intValue.examp(key: "Nothing"))
intValue.addElem(elem: 15, key: "fifteen")
var intM  = intValue.examp(key: "fifteen")

// Добавляем масссив
let array = ["Hello","World"]
let myArray = MyStorage<[String]>()
myArray.addElem(elem: array, key: "array")
print(myArray.examp(key: "array"))
print(myArray.examp(key: "array1"))

// Dictionary
let dic = ["Name": "Paul", "Country":"UK"]
let mydic = MyStorage<[String : String]>()
mydic.addElem(elem: dic, key: "mydictionary")
print(mydic.examp(key: "array1"))
print(mydic.examp(key: "mydictionary"))

// bool
let myBool = MyStorage<Bool>()
myBool.addElem(elem: true, key: "Correct Id")
print(myBool.examp(key: "array1"))
print(myBool.examp(key: "Correct Id"))
