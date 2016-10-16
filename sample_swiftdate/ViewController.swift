//
//  ViewController.swift
//  sample_swiftdate
//
//  Created by 中村祐太 on 2016/10/14.
//  Copyright © 2016年 中村祐太. All rights reserved.
//

import UIKit
import SwiftDate
import RealmSwift



protocol AppModelProtocol {}
extension AppModelProtocol where Self: Object {
    func save() {
        let realm = try! Realm()
        try! realm.write{
            realm.add(self, update: true)
        }
    }
}


// Dog model
class Dog: Object, AppModelProtocol {
    override static func primaryKey() -> String? {
        return "id"
    }
    dynamic var id = NSUUID().uuidString
    dynamic var name = ""
    dynamic var owner: Person? // Properties can be optional
    let owners = LinkingObjects(fromType: Person.self, property: "dogs")
}

// Person model
class Person: Object, AppModelProtocol {
    override static func primaryKey() -> String? {
        return "id"
    }
    dynamic var id = NSUUID().uuidString
    dynamic var name = ""
    dynamic var birthdate = NSDate(timeIntervalSince1970: 1)
    let dogs = List<Dog>()
}

class ViewController: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(NSTemporaryDirectory())
        
//        let date = DateInRegion() // create a date from current time in local device's region and calendar
//        // Some examples of date as string formatted with different styles for date and time
//        let example_1 = date.string(dateStyle: .medium, timeStyle: .long) // Sep 29, 2015, 1:01:13 PM GMT+2
//        let example_2 = date.string(dateStyle: .short, timeStyle: .short) // 9/29/15, 1:00 PM
//        let example_3 = date.string(dateStyle: .medium, timeStyle: .none) // September 29, 2015
//        print(example_1)
//        print(example_2)
//        print(example_3)
//        
//        print( date.string(format: .custom("yyyy-MM-dd HH:mm:ss")) )
//        
//        print( NSDate() )
//        
//        print( DateInRegion() )
//        
//        print("━━━━━━━━━━━━━━━━")
//        
//        print( try! DateInRegion(string: "1984-05-02", format: .custom("yyyy-MM-dd")) )
        
//        let dog = Dog()
//        dog.name = "ぷーちゃん"
        
//        let person = Person()
//        person.name = "ゆうた"
//        person.birthdate = try! DateInRegion(string: "1984-05-02", format: .custom("yyyy-MM-dd")).absoluteDate as NSDate
//        person.dogs.append(dog)
//        
//        person.save()
//        
//        let pico = Person()
//        pico.name = "ぴぃこ"
//        pico.birthdate = try! DateInRegion(string: "1985-06-13", format: .custom("yyyy-MM-dd")).absoluteDate as NSDate
//        pico.dogs.append(dog)
//        
//        pico.save()
        
        let realm = try! Realm()
        
        let yuta = realm.objects(Person.self).filter("name = 'ゆうた'").first
        
        print("yuta: ", yuta)
        if ( yuta != nil ) {
            try! realm.write {
                realm.delete(yuta!)
            }
        }
        
        let puu = realm.objects(Dog.self).filter("id = '5DF96D79-390A-4ED3-B1C4-1C5E55B5C55C' ").last
        
        print("puu.owners: ", puu?.owners ?? [] )
    }
}

