# 🛒 E-Commerce App

A modern, scalable **E-Commerce Flutter application** built using **Clean Architecture**, **BLoC (Cubit)** state management, and robust **REST API integration**.

The app delivers a smooth shopping experience with secure authentication, dynamic product browsing, cart management, and order tracking.

---

## ✨ Features

### 👤 Authentication System
- User Sign Up / Login with secure credentials
- Auto-Login support for seamless sessions
- Guest Mode (Continue as guest)
- Secure Token-Based Authentication using local storage

---

### 🛍️ Products & Catalog
- Dynamic product browsing with smooth UI
- Product details (price, images, specifications)
- Category filtering
- Cached images for better performance

---

### ❤️ Favorites
- Add / remove products from wishlist
- Persistent storage across sessions

---

### 🛒 Cart System
- Real-time price calculation (subtotal, taxes, total)
- Quantity update inside cart
- Instant UI updates

---

### 📦 Orders & Tracking
- One-click order placement
- Order history screen
- Order status tracking

---

### 👤 Profile
- View and edit profile data
- Secure logout with full cache clearing

---

## 🧠 Architecture

Feature-first Clean Architecture with BLoC (Cubit):

lib/
└── core/
└── features/
└── [feature_name]/
├── data/          # Models, Mappers, Data Sources (Remote/Local)
└── presentation/  # Cubits, States, Screens, Widgets


---

## 🌐 Data Flow

- Data Layer → API calls (Dio), models, caching
- Domain Layer → business logic (pure Dart)
- Presentation Layer → UI + Cubit state management

---

## 🌐 Networking & Error Handling

- Dio with interceptors (logging, headers, token injection)
- Centralized error handling:
    - ServerFailure
    - NetworkFailure
    - CacheFailure

---

## 📱 Tech Stack

- Flutter 💙
- Dart
- BLoC (Cubit)
- Dio
- Shared Preferences
- Cached Network Image

---

## 💡 Future Improvements

- 💳 Payment Gateway (Stripe / Paymob)
- 🔔 Push Notifications (Firebase Cloud Messaging)
- 🌙 Dark / Light Theme
- 📦 Offline Mode (Hive / Drift)
- 📊 Firebase Analytics & Crashlytics

---

## 👩‍💻 Developer

Made with ❤️ by **Shahd Sayed**