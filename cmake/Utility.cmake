include_guard(DIRECTORY)

function(Path_Normalizer PATH NEW_PATH)
    set(${NEW_PATH} ${PATH})
    string(REPLACE "\\" "/" ${NEW_PATH} "${${NEW_PATH}}")
    set(${NEW_PATH} "${${NEW_PATH}}" PARENT_SCOPE)
endfunction()

function(HALM_Copy COPY_TARGET_NAME FILES DEST_DIR)
    set(OUTPUT_FILES)

    foreach(DLL_FILE IN LISTS FILES)
        set(FILE_BASE_ADR ${BASE_ADR})
        set(FILE_NAME ${DLL_FILE})
        if("${FILE_BASE_ADR}" STREQUAL "")
            get_filename_component(FILE_NAME "${DLL_FILE}" NAME)
            get_filename_component(FILE_BASE_ADR "${DLL_FILE}" DIRECTORY )
        endif()
        set(DEST_FILE ${DEST_DIR}/${FILE_NAME})
        get_filename_component(DEST_ADR "${DEST_FILE}" DIRECTORY )

        add_custom_command(
            OUTPUT  ${DEST_FILE}
            DEPENDS ${FILE_BASE_ADR}/${FILE_NAME}
            COMMAND ${CMAKE_COMMAND} -E copy ${FILE_BASE_ADR}/${FILE_NAME} ${DEST_ADR}
        )
        list(APPEND OUTPUT_FILES ${DEST_FILE})
    endforeach()

    add_custom_target(
        ${COPY_TARGET_NAME} ALL
        DEPENDS ${OUTPUT_FILES}
    )
endfunction()

function(HALM_Copy_Folder COPY_TARGET_NAME SRC_DIR DST_DIR)
    get_filename_component(DST_FOLDER_NAME "${SRC_DIR}" NAME)
    set(DST_DIR "${DST_DIR}/${DST_FOLDER_NAME}")

    add_custom_command(
        OUTPUT ${DST_DIR}
        COMMAND ${CMAKE_COMMAND} -E make_directory "${DST_DIR}"
        COMMAND ${CMAKE_COMMAND} -E copy_directory "${SRC_DIR}" "${DST_DIR}"
        DEPENDS ${SRC_DIR}
    )

    add_custom_target(
        ${COPY_TARGET_NAME} ALL
        DEPENDS ${DST_DIR}
    )
endfunction()

function(ConvertToAbsoluteAddress PATH_LIST)
    set(FULL_PATH_LIST)
    foreach(ELEMENT IN LISTS ${PATH_LIST})
    get_filename_component(FULL_PATH ${ELEMENT} ABSOLUTE)
    list(APPEND FULL_PATH_LIST    "${FULL_PATH}")
    endforeach()
    set(${PATH_LIST} "${FULL_PATH_LIST}" PARENT_SCOPE)
endfunction()


function(RemoveListItems SOURCE_LIST REMOVE_ITEMS)
    set(FINAL_LIST "${${SOURCE_LIST}}")
    foreach(ELEMENT ${REMOVE_ITEMS})
        list(REMOVE_ITEM FINAL_LIST    "${ELEMENT}")
    endforeach()
    set(${SOURCE_LIST} "${FINAL_LIST}" PARENT_SCOPE)
endfunction()
