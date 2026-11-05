# module_two_application

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project's Reflections
What is the difference between the Model, View, and ViewModel in this application?
=> Model is the one who handles only data modeling and data storing, View is the one who handles the User Interfeces and interacting with ViewModel, and ViewModel is the one behind the application logics (most of it) that interacting with data in those Model.

What should happen if a student attempts to borrow a book that already has an active loan?
=> The book is simply can't be borrow(ed) and the application should tell them

Why is it better to calculate the fine in one place rather than repeating the formula in multiple widgets?
=> utilize the principle of DRY, while also its can make the code more cleaner

What is the difference between a book being Overdue and being Missing?
=> Overdue only takes the fine, while Missing takes fine + replacement fee

If the university changes its weekly fine from Rp5,000 to Rp7,000, how should the app be updated?
=> on my application, i need to update the "static const int weeklyFine = 5000" to 7000 on the  lib\viewmodels\fine_policy.dart