set(PROJECT_NAME                    "ParcelLocker")
set(${PROJECT_NAME}_SUMMARY         "Parcel Locker Mini-Kiosk")
set(${PROJECT_NAME}_VENDOR_NAME     "GLS-NXT")
set(${PROJECT_NAME}_VENDOR_CONTACT  "https://github.com/gls-nxt/technical-assessments/blob/main/assessments/hmi-software-engineer.md")
set(${PROJECT_NAME}_VERSION_MAJOR   1)
set(${PROJECT_NAME}_VERSION_MINOR   0)
set(${PROJECT_NAME}_VERSION         "${${PROJECT_NAME}_VERSION_MAJOR}.${${PROJECT_NAME}_VERSION_MINOR}")

project("${PROJECT_NAME}"
    VERSION "${${PROJECT_NAME}_VERSION}"
    DESCRIPTION "${${PROJECT_NAME}_SUMMARY}"
    HOMEPAGE_URL "${${PROJECT_NAME}_VENDOR_CONTACT}"
    LANGUAGES CXX
)

list(APPEND LIBS
    ToolBox
)

include(${${PARAM_PROJECT_NAME}_CMAKE_DIR}/Utility.cmake)
include(${${PARAM_PROJECT_NAME}_CMAKE_DIR}/Component.cmake)

find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(Qt6 REQUIRED COMPONENTS Core)

add_executable(${PROJECT_NAME}
    DoorController.h DoorController.cpp
    Logger.h Logger.cpp)

target_link_libraries(ParcelLocker PRIVATE Qt6::Core)
target_link_libraries(ParcelLocker PRIVATE Qt6::Core)

AutoComponentGenerator(${PROJECT_NAME} "${LIBS}" ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR} "")
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


set_target_properties(${PROJECT_NAME} PROPERTIES
        AUTOMOC ON
        AUTOUIC ON
        AUTORCC ON
)


# TranslationGenerator(${PROJECT_NAME} "en;pr" "${FULL_LIST}" ON)
