project(ToolBox)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Qml QuickTest)

list(APPEND LIBS
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    Qt6::QuickTest
    )

add_library(${PROJECT_NAME} STATIC)
include(${${PARAM_PROJECT_NAME}_CMAKE_DIR}/Component.cmake)
AutoComponentGenerator(${PROJECT_NAME} "${LIBS}" ${CMAKE_CURRENT_SOURCE_DIR} "src" )
target_include_directories(${PROJECT_NAME} PUBLIC "src")
set_target_properties(${PROJECT_NAME} PROPERTIES
    AUTOMOC ON
    AUTOUIC ON
    AUTORCC ON
)
