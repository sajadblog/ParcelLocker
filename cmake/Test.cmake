include_guard(DIRECTORY)
function(TestTargetGenerator COMPONENT LIBS TESTS)

    set(${COMPONENT}_TEST_BIN_TARGET "${COMPONENT}_UnitTest" CACHE INTERNAL "")
    add_executable(${${COMPONENT}_TEST_BIN_TARGET} EXCLUDE_FROM_ALL)

    target_sources(${${COMPONENT}_TEST_BIN_TARGET} PRIVATE ${TESTS} )

    target_include_directories(${${COMPONENT}_TEST_BIN_TARGET} PRIVATE ./test)

    target_link_libraries(${${COMPONENT}_TEST_BIN_TARGET}
        PRIVATE
        ${LIBS} GTest::GTest GTest::gmock
    )
    message(STATUS "Component --> ${${COMPONENT}_TEST_BIN_TARGET}")

endfunction()

function(AutoTestTargetGenerator COMPONENT LIBS TEST_FOLDER EXCLUDE_TEST)
    file(GLOB_RECURSE TESTS ${TEST_FOLDER}/*.cpp)
    foreach(ELEMENT ${EXCLUDE_TEST})
        get_filename_component(FULL_PATH ${ELEMENT} ABSOLUTE)
        list(REMOVE_ITEM TESTS "${FULL_PATH}")
    endforeach()

    TestTargetGenerator(${COMPONENT} "${LIBS}" "${TESTS}")
endfunction()
