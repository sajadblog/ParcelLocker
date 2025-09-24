
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
```


#### Windows (PowerShell)

```powershell

git clone https://github.com/sajadblog/ParcelLocker.git

cd ParcelLocker

mkdir build; cd build

cmake .. -DCMAKE_PREFIX_PATH="path\to\Qt\6.8.3\{compiler}"

cmake --build . --config Release

.\Release\ParcelLocker.exe --fullscreen

```

  

- Run with `--fullscreen` to start in fullscreen mode.

- Press **ESC** to exit fullscreen mode.

  

---

  

## 🧪 Testing

  

This project includes **unit tests** using **Qt Quick Test**:

  

```bash

cd build

tst_main.exe

```

  

---

  ## 📐 Design Notes & Tradeoffs

This section explains key architectural decisions, design tradeoffs, and rationale based on the project layout and objectives.

### Project Layout & Separation of Concerns

-   **`Backend/`** contains the core C++ logic: e.g. `DoorController`, mock backend interfaces, utility/helper code. This keeps the business logic decoupled from the UI layer.
-    **`ParcelLocker/`** Main software component, which only do the wiring between backend side services and graphical components. 
-    **`ToolBox/`** Small tool box to serprate generic and small graphical items in a component in order to improve reusablity and portablity . 
    
-   **`cmake/`** or supporting CMake modules allow better modularity: you can encapsulate build settings, custom find-modules, and version handling separate from top-level `CMakeLists.txt`.
    
-   **Tests (Qt Quick Test)**  unit test folder.
    

### Why This Approach

-   **Loose coupling** between UI and logic — the QML layer only needs well-defined interfaces (signals/slots, properties), so that the core logic can be tested independently.
    
-   **Modularity & build control**: using a dedicated `cmake/` folder allows ease of extension (e.g. adding extra modules or platform-specific tweaks) without cluttering the root CMake script.
    
-   **Testability**: isolating the logic in C++ makes it easier to write unit tests (e.g. Qt Quick Test / QTest) without needing to render UI screens or simulate full application run.
    
-   **Cross-platform consistency**: by structuring code and build files with clear abstractions, the same logic works under Linux and Windows with minimal platform-specific branching.
    

### Tradeoffs & Limitations

-   **Simplicity over over-engineering**: Some patterns (e.g. dependency injection) were simplified in favor of clarity and brevity, given the time constraint of the assessment.
    
-   **Mocked behavior only**: Real networking or error recovery rather than implemented. This avoids scope creep and keeps the focus on architecture and flow.
    
-   **State machine in QML vs C++**: I chose to drive screen transitions largely via QML `States` & `Transitions` to exploit QML’s declarative nature. While a full C++ `QStateMachine` abstraction might offer more runtime flexibility, in this context QML states were more concise and readable.
    
-   **Hard-coded JSON data**: `mock_api.json` is loaded locally. In a production scenario, you’d replace this with real network requests or persistent storage, with error/retry logic.
    
-   **Error handling & edge cases**: The attempt was to cover common cases (invalid PIN, door failure, timeouts), but exhaustive corner cases (network flapping, multi-item lockers) may not be fully covered.
  


## 📜 License

  

This project is released under the **MIT License**.