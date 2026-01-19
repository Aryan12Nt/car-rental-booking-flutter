# Car_Rental_Booking

A new Flutter project.

## Getting Started

What this is

A multi-screen Flutter MVP for a Car Rental Booking app.
Features:

- Login (simple, stored in SharedPreferences)

- Browse cars (from lib/data/mock_cars.dart)

- Car detail page

- Booking form (select start/end dates, enter name & pickup location)

- Booking confirmation & booking history (stored locally with Hive)

Requirements

- Flutter SDK (compatible with Dart SDK >= 3.8.0). Use a recent stable Flutter release.

- Android Studio / Xcode for mobile emulators or a physical device.

- Android toolchain set up. For iOS builds, Xcode & CocoaPods installed.

Quick setup
Open a terminal in the project root (where pubspec.yaml is located):

1. Get packages:
   - flutter pub get
2. Run the app
   - flutter run

Project structure (key files)
  lib/
  main.dart              # app entry + provider setup + router init
  data/mock_cars.dart    # mock car data
  models/
    car.dart             # Car model (Hive typeId 0)
    booking.dart         # Booking model (Hive typeId 1)
    car.g.dart           # GENERATED adapter (present)
    booking.g.dart       # GENERATED adapter (present)
  providers/             # business logic (auth, booking, UI)
  router/                # go_router configuration
  screens/               # UI screens (login, list, detail, booking, history)
  widgets/               # small reusable widgets
pubspec.yaml
