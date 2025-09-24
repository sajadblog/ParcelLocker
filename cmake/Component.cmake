include_guard(DIRECTORY)
function(ComponentGenerator COMPONENT LIBS SOURCES_FILES)
    target_sources(${COMPONENT} PRIVATE ${SOURCES_FILES})
    target_link_libraries(${COMPONENT} PUBLIC ${LIBS})
endfunction()

function(DiscoverSourceFiles SRC_DIR HDR_DIR FULL_LIST)
    file(GLOB_RECURSE HEADERS   ${HDR_DIR}/*.h)
    file(GLOB_RECURSE SOURCES   ${SRC_DIR}/*.cpp)
    file(GLOB_RECURSE UIS       ${SRC_DIR}/*.ui)
    file(GLOB_RECURSE QT_RESOURCES ${SRC_DIR}/*.qrc)

    list(APPEND SOURCES "${HEADERS}")
    list(APPEND SOURCES "${UIS}")
    list(APPEND SOURCES "${QT_RESOURCES}")
    set(FULL_LIST "${SOURCES}" PARENT_SCOPE)
endfunction()

function(AutoComponentGenerator COMPONENT LIBS SRC_DIR HDR_DIR)
    DiscoverSourceFiles(${SRC_DIR} ${HDR_DIR} FULL_LIST)
    ComponentGenerator(${COMPONENT} "${LIBS}" "${FULL_LIST}")
endfunction()

function(TranslationGenerator COMPONENT LANGUAGES ADDITIONAL_SOURCE COPY_INTO_SOURCE)
    set( TS )
    set( QM )
    set (TRANSLATION_DIR "${CMAKE_CURRENT_SOURCE_DIR}/translations")
    foreach(ELEMENT ${LANGUAGES})
        list(APPEND TS "${TRANSLATION_DIR}/${COMPONENT}_${ELEMENT}.ts")
        list(APPEND QM "${TRANSLATION_DIR}/${COMPONENT}_${ELEMENT}.qm")
    endforeach()

    find_package(Qt${Qt_MAJOR_VERSION} REQUIRED COMPONENTS LinguistTools)
    qt6_add_translations(${COMPONENT} TS_FILES ${TS}
        QM_FILES_OUTPUT_VARIABLE qm_files
        SOURCES "${ADDITIONAL_SOURCE}")

    if(COPY_INTO_SOURCE)
        add_custom_command(TARGET ${COMPONENT}_lrelease
            POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy ${qm_files} ${TRANSLATION_DIR}
            COMMENT "Move generate QM files to translation directory"
            VERBATIM)
    endif()
endfunction()
