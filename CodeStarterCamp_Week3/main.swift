import Foundation

struct Person {
    var name: String
    var gender: String
    var age: Int
    var money: Int
    
    mutating func orderCoffee(coffeeShop: CoffeeShop, coffee: Coffee) {
        if let price = coffeeShop.menu[coffee] {
            if money >= price {
                coffeeShop.numberOfOrder += 1
                money = money - price
                print("커피 가격은 \(price)원이고 남은 돈 \(money)원 입니다.")
                coffeeShop.revenue += price
                coffeeShop.makeCoffee(from: name, coffee: coffee)
            } else {
                print("잔액이 \(price - money)원만큼 부족합니다.")
            }
        }
    }
}


class CoffeeShop {
    var shopName: String
    var revenue: Int {
        didSet{
            print("가게 매출은 \(revenue)원 입니다")
        }
    }
    var barista: Person
    var menu: [Coffee: Int] = [:]
    var pickUpTable: [String] = [] {
        didSet{
            if let newCoffee = pickUpTable.last {
                print("\(newCoffee) (이/가) 픽업대로 올라갑니다.")
            }
        }
    }
    var numberOfOrder: Int = 0
    
    func makeCoffee(from name: String, coffee: Coffee) {
        if numberOfOrder > 0 {
            pickUpTable.append("\(coffee)")
            for coffee in pickUpTable {
                print("\(name)님 주문하신 \(coffee)(이/가) 나왔습니다.")
            }
        }
    }
    
    init(shopName: String, barista: Person, revenue: Int) {
        self.shopName = shopName
        self.barista = barista
        self.revenue = revenue
        
        for coffee in Coffee.all {
            menu[coffee] = coffee.rawValue
        }
    }
}

enum Coffee: Int {
    case americano = 1000
    case latte = 2000
    case ade = 3000
    case smoothie = 4000
    static let all = [americano, latte, ade, smoothie]
}


var misterLee: Person = Person(name: "misterLee", gender: "male", age: 28, money: 30000)
var missKim: Person = Person(name: "missKim", gender: "female", age: 21, money: 20000)
var yagombucks: CoffeeShop = CoffeeShop(shopName: "yagombucks", barista: misterLee, revenue: 0)




misterLee.orderCoffee(coffeeShop: yagombucks, coffee: .americano)
misterLee.orderCoffee(coffeeShop: yagombucks, coffee: .smoothie)

//misterLee.orderCoffee(coffeeShop: yagombucks, coffee: .americano)
//yagombucks.makeCoffee(from: misterLee.name, coffee: .americano)
//misterLee.orderCoffee(coffeeShop: yagombucks, coffee: .latte)
//yagombucks.makeCoffee(from: misterLee.name, coffee: .latte)
//misterLee.orderCoffee(coffeeShop: yagombucks, coffee: .smoothie)
//yagombucks.makeCoffee(from: misterLee.name, coffee: .smoothie)

