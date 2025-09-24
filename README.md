
# Parcel Locker Mini-Kiosk  

An open-source **interactive kiosk-style application** built with **Qt 6.8.3 (QML + C++)** and **CMake**, targeting **Windows** and **Linux**.  
This project was developed as part of a technical hiring assessment for an **HMI Software Engineer (IoT Devices)** position.  

It demonstrates fundamentals of **GUI development**, **state management**, and **mock device/backend integration** in Qt.  



## 📦 Qt Modules Used  

- **QtCore**  
- **QtGui**  
- **QtQuick**  
- **QtQml**  
- **QtQuickTest**  

---

## 🚀 Running the Application  

### Prerequisites  
- **Qt 6.8.3+** installed and available in PATH (`qmake --version` should confirm).  
- **CMake 3.25+**  
- **C++20 or later compiler** (MSVC, GCC, or Clang).  

### Build Instructions  

#### Linux  
```bash
git clone https://github.com/sajadblog/ParcelLocker.git
cd ParcelLocker
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.8.3/gcc_64
cmake --build .
./ParcelLocker [--fullscreen]
