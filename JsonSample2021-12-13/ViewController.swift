//
//  ViewController.swift
//  JsonSample2021-12-13
//
//  Created by 村中令 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    struct Employee: Codable {
        var code: String
        var name: String
        var age: Int
        var absence: Bool
        var position: String?
    }

    @IBAction func button1(_ sender: Any) {
        //初期オブジェクト生成
        let originalObject = Employee(code: "001", name: "山田", age: 45, absence: false)

        //JSONへ変換
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let jsonValue = try? encoder.encode(originalObject) else {
            fatalError("Failed to encode to JSON")
        }

        //JSONデータ確認
        print("JSONデータ確認")
        print(String(bytes: jsonValue, encoding: .utf8)!)

        //JSONから変換
        let decoder = JSONDecoder()
        guard let employee: Employee = try? decoder.decode(Employee.self, from: jsonValue) else {
            fatalError("Failed to decode from JSON.")
        }


        print("*******最終データ確認********")
        print(employee)

    }

    @IBAction func button2(_ sender: Any) {

        let originalObject = [
            Employee(code: "001", name: "山田", age: 45, absence: false, position: "部長"),
            Employee(code: "002", name: "鈴木", age: 30, absence: true),
            Employee(code: "003", name: "佐藤", age: 25, absence: false)
        ]

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let jsonValue = try? encoder.encode(originalObject) else {
            fatalError("Failed to encode to JSON")
        }

        let decoder = JSONDecoder()
        guard let employees: [Employee] = try? decoder.decode([Employee].self, from: jsonValue) else {
            fatalError("Failed to decode from JSON")
        }


        print("****最終データ確認****")
        print(employees)
        for employee in employees {
            print(employee)
        }

    }


    @IBAction func button3(_ sender: Any) {

        struct Section: Codable {
            var name: String
            var member: [Employee]

            struct Employee: Codable{
                var code: String
                var name: String
                var age: Int
                var absence: Bool
            }
        }

        let originalObject = Section(name: "営業部", member: [
            Section.Employee(code: "001", name: "山田", age: 45, absence: false),
            Section.Employee(code: "002", name: "鈴木", age: 30, absence: true),
            Section.Employee(code: "003", name: "佐藤", age: 25, absence: false)
        ])

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let jsonValue = try? encoder.encode(originalObject) else {
            fatalError("Failed to encode to JSON")
        }

        print("**JSONデータ確認**")
        print(String(bytes: jsonValue, encoding: .utf8)!)

        let decoder = JSONDecoder()
        guard let section: Section = try? decoder.decode(Section.self, from: jsonValue) else {
            fatalError("Failed to decode from JSON")
        }

        print("***最終データ***")
        print(section.name)
        for employee in section.member {
            print(employee)
        }




    }

    @IBAction func button4(_ sender: Any) {

        struct Employee: Codable {
            var code: String
            var name: String
            var age: Int
            var absence: Bool
            var dateOfHire: Date
        }

        let originalObject = Employee(code: "001", name: "山田", age: 45, absence: false, dateOfHire: Date())

        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年M月d日"
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        guard let jsonValue = try? encoder.encode(originalObject) else {
            fatalError("Failed to encode to JSON")
        }

        print("***JSONデータ確認***")
        print(String(bytes: jsonValue, encoding: .utf8)!)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let employee: Employee = try? decoder.decode(Employee.self, from: jsonValue) else {
            fatalError("Failed to decode from JSON")
        }

        print("***最終データ確認**")
        print(employee)




    }
}

