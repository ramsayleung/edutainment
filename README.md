# Edutainment

## About

The solution to the consolidated challenge of [100 Day of SwiftUI on Day 35](https://www.hackingwithswift.com/100/swiftui/35), which requires you to build an “edutainment” app for kids to help them practice multiplication tables – “what is 7 x 8?” and so on

Breaking the challenge down:

- The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.
- The player should be able to select how many questions they want to be asked: 5, 10, or 20.
- You should randomly generate as many questions as they asked for, within the difficulty range they asked for.

## Innovation

Even though It's a pretty tiny and strightforward APP, there is still some innovations I am proud of inside this app. 

For example, I use `DispatchQueue.main.asyncAfter` to delay the execution of code until the animations finish to make the user interface more memorable and fluent.

## Screenshot

![](./img/edutainment.gif)

## Acknowledge 

The UI of this app is highly inspired by [Dulce's work](https://github.com/DulceItamar/100-days-of-SwiftUI/tree/main/Edutainment)
