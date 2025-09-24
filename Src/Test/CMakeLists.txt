cmake_minimum_required(VERSION 3.2)

project(tst_main LANGUAGES CXX)

enable_testing()

find_package(Qt6 REQUIRED COMPONENTS QuickTest Qml)

add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

qt_standard_project_setup(REQUIRES 6.6)

add_executable(tst_main tst_main.cpp)

add_test(NAME tst_main COMMAND tst_main)

target_link_libraries(tst_main
    PRIVATE
    BackEnd
    Qt6::QuickTest
    Qt6::Qml
)
