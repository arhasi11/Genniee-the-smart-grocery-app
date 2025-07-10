# 🧞‍♂️ Gennie – Smart Quick-Commerce App

Gennie is a **smart, AI-powered quick-commerce mobile app** built using **Flutter**, designed to provide users with a seamless grocery, fruits, dairy, and snacks shopping experience. From personalized baskets to real-time cart syncing and order tracking, Gennie aims to become the go-to assistant for daily essentials.

---

## 📱 Features

### 🛒 User-Facing
- 🔐 **Secure Login & Account Creation**
- 🏠 **Home Dashboard** with categories, delivery switch, and AI basket planner
- 🧠 **AI Smart Basket Recommendations** based on past orders
- 🔍 **Search & Filter Products** by name and price
- ➕ **Dynamic Cart System** with quantity control
- ✅ **Order Summary & Checkout**
- 📦 **Order History Tracking**
- 👤 **Editable User Profile**
- 🌙 **Dark Mode Support** *(Planned)*

---

### ⚙️ Admin-Facing *(In Progress)*
- 📋 Add / Edit / Delete Products
- 🎯 Manage Offers and Discounts
- 📊 View Customer Orders

---

## 🧠 Tech Stack

| Layer           | Tech Used                                |
|----------------|-------------------------------------------|
| Frontend       | Flutter + Dart                           |
| State Mgmt     | Provider                                  |
| Authentication | Firebase Auth (email login)               |
| Data Storage   | Shared Preferences *(Firebase planned)*   |
| Backend (Planned) | Firebase Firestore / Realtime DB       |

---

## 📂 Project Structure
```
lib/
├── screens/
│ ├── home_screen.dart
│ ├── login_screen.dart
│ ├── cart_screen.dart
│ ├── profile_screen.dart
│ ├── grocery_screen.dart
│ ├── dairy_screen.dart
│ └── fruits_screen.dart
├── widgets/
│ ├── category_card.dart
│ ├── delivery_mode_switch.dart
│ └── ai_basket_planner.dart
├── providers/
│ └── cart_provider.dart
├── utils/
│ └── shared_prefs.dart
└── main.dart
```

---

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/your-username/gennie-app.git
cd gennie-app
```
2. Install dependencies
```
flutter pub get
```
3. Run the app
```
flutter run
```
✅ Works on Android, iOS, and Web.

---

## 📸 Screenshots
Home Screen	AI Basket	Cart System	Profile

(Optional: Add actual screenshots from your emulator)

---

## 💡 Future Plans
Admin dashboard (mobile + web)
- Firebase integration for:
- Orders
- Products
- Real-time sync
- Google Sign-In
- Push Notifications
- Payment Gateway (e.g., Razorpay)
- ML-based personalized offers

---

## 👨‍💻 Author
Arhasi Soni
arhasisoni@gmail.com

---

## 📄 License
MIT License - see the LICENSE file for details.
