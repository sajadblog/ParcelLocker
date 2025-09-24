project(tst_main LANGUAGES CXX)

enable_testing()

find_package(Qt6 REQUIRED COMPONENTS QuickTest Qml)

add_definitions(-DQUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}")

qt_standard_project_setup(REQUIRES 6.6)

add_executable(${PROJECT_NAME} ${PROJECT_NAME}.cpp)

add_test(NAME ${PROJECT_NAME} COMMAND ${PROJECT_NAME})

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    BackEnd
    Qt6::QuickTest
    Qt6::Qml
)
