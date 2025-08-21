# 📝To-Do List App (Flutter)

A simple and intuitive To-Do List app built using Flutter.  
This app helps users manage their daily tasks efficiently with a clean and user-friendly interface.

---
## 📸 Screenshots
  ![Home Screen](https://github.com/Somprakash04/To-Do-List/blob/main/assets/image/add_task.png?raw=true)
  ![Home Screen](https://github.com/Somprakash04/To-Do-List/blob/main/assets/image/home_screen.png?raw=true)
  

---
## ✨ Features

- Add, edit, and delete tasks  
- Mark tasks as completed  
- Persistent local storage (using sqflite)  
- Responsive design (works on Android, iOS, and Web)  
- Light & dark mode support (optional)

---

## 🛠️ Tech Stack

- **Frontend:** Flutter (Dart)  
- **Local Storage:** sqflite  
- **State Management:** setState (can be upgraded to Provider/Bloc later)

---

## 🚀 Getting Started

Follow these instructions to set up and run the project on your local machine.

### 📂 Project Structure
    ```bash  
    lib/
     ├─ main.dart
     ├─ models/         # Task model
     ├─ screens/        # Home screen, add/edit task screen
     ├─ widgets/        # Custom widgets
     └─ database/       # sqflite setup and helper


### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed  
- Android Studio or VS Code (with Flutter & Dart extensions)  
- Git installed

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Somprakash04/to-do-list.git
1. Navigate to the project directory:
   ```bash   
   cd to-do-list
1. Install dependencies:
   ```bash 
   flutter pub get
1. Run the app:
   ```bash   
   flutter run
