set(PROJECT_NAME                  "BackEnd")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick)

list(APPEND LIBS
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    )

add_library(${PROJECT_NAME} STATIC)
include(${${PARAM_PROJECT_NAME}_CMAKE_DIR}/Component.cmake)
AutoComponentGenerator(${PROJECT_NAME} "${LIBS}" ${CMAKE_CURRENT_SOURCE_DIR} "." )
target_include_directories(${PROJECT_NAME} PUBLIC ".")
set_target_properties(${PROJECT_NAME} PROPERTIES
    AUTOMOC ON
    AUTOUIC ON
    AUTORCC ON
)
