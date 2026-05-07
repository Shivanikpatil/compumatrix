# Compumatrix Flutter App

A production-ready Flutter application built with Clean Architecture and Provider.

## Architecture
This project follows **Clean Architecture** principles:
- **Core**: Contains constants, network configurations, common widgets, and utilities.
- **Data**: Implementation of repositories, data sources, and models.
- **Domain**: Business logic, entities, and repository interfaces.
- **Presentation**: UI screens, widgets, and state management (Providers).
- **DI**: Dependency injection setup.

## Features
- **Authentication**: Mobile-based login with OTP verification.
- **Vehicle Management**: Add, List, and Delete vehicles with image upload support.
- **Active Services**: View a list of current active services.
- **Localization**: Support for English and Hindi.
- **State Management**: Using `Provider` and `ChangeNotifier`.
- **Networking**: `Dio` with interceptors for token handling and error management.
- **Security**: JWT tokens stored securely using `flutter_secure_storage`.

## Tech Stack
- Flutter 3.x
- Provider
- Dio
- Flutter Secure Storage
- Image Picker
- Cached Network Image
- Shimmer
- Intl (Localization)

## Setup Instructions
1. Clone the repository.
2. Run `flutter pub get`.
3. Run `flutter gen-l10n` to generate localization files.
4. Run `flutter run`.

## API Endpoints
- Login Request: `POST /consumer-auth/login/request-otp`
- Verify OTP: `POST /consumer-auth/login/verify-otp`
- Vehicles: `GET/POST/DELETE /consumer-auth/`
- Services: `GET /active-services/services`
