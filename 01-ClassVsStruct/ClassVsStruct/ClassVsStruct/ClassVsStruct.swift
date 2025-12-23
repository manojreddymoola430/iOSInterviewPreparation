//
//  ClassVsStruct.swift
//  iOSInterviewPractices
//
//  Created by Manoj Reddy on 11/19/25.
//
import SwiftUI


class Dog
{
    var name: String
    var noice: String
    init(name: String, noice: String) {
        self.name = name
        self.noice = noice
    }
    
    func animalNoice() -> String
    {
        return noice
    }
    
}


struct DogClassIsReferenceType:View
{
    @State var dog1Sound: String?
    @State var dog2Sound: String?
    
    var body: some View
    {
        VStack(alignment: HorizontalAlignment.leading){
            Text("Hello, Doggy!")
            Text("Dog1 makes, \(dog1Sound ?? "No sound")")
            Text("Dog2 makes, \(dog2Sound ?? "No sound")")
        }.padding()
        .onAppear(){
            let dog1 = Dog(name:"Max", noice: "Arf Arf")
            let dog2 = dog1 //assigned dog1 to dog2, so expect all values same
            dog2.noice = "Grrr" // I modified dog2 noice here
            
            //Classes are reference types,
            //Both values will be modified as they refer same object in memory
            // that is "Grrr"
            self.dog1Sound = dog1.animalNoice()
            self.dog2Sound = dog2.animalNoice()
            print(dog1.animalNoice())
            
        }
    }
}

// MARK - Structs
struct car {
    var name: String
    var sound: String
}

struct CarStructIsValueType: View {
    @State var car1Sound: String?
    @State var car2Sound: String?
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text("Hello, Car!")
            Text("Car1 makes, \(car1Sound ?? "No sound")")
            Text("Car2 makes, \(car2Sound ?? "No sound")")
        }.padding()
            .onAppear() {
                let car1 = car(name: "Toyota Corolla", sound: "Vroom Vroom")
                var car2 = car1
                car2.sound  =   "Zoom zoom" // I'm setting the car2 sound here
                
                //Struct are Value types, they make their own copy automatically
                //so they maintain their own copy and wont change.
                self.car1Sound = car1.sound
                self.car2Sound = car2.sound
            }
    }
}

