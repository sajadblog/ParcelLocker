set(PARAM_PROJECT_NAME			  "datamodel")
set(${PARAM_PROJECT_NAME}_SUMMARY         "HALM - PVControl application")
set(${PARAM_PROJECT_NAME}_VENDOR_NAME     "HALM Company")
set(${PARAM_PROJECT_NAME}_VENDOR_CONTACT  "https://www.halm.de")
set(${PARAM_PROJECT_NAME}_VERSION_MAJOR   1)
set(${PARAM_PROJECT_NAME}_VERSION_MINOR   1)
set(${PARAM_PROJECT_NAME}_VERSION_PATCH   1)
set(${PARAM_PROJECT_NAME}_VERSION         "${${PARAM_PROJECT_NAME}_VERSION_MAJOR}.${${PARAM_PROJECT_NAME}_VERSION_MINOR}.${${PARAM_PROJECT_NAME}_VERSION_PATCH}")

option(HALM_IS_DEVELOPER_BUILD "set some qol preprocessor defines for local builds on dev PC without hardware" OFF)
set(HALM_PVCONTROL_TYPE "" CACHE STRING "e.g. ,,Baccini,DAFF")

if(HALM_IS_DEVELOPER_BUILD)
    add_compile_definitions(HALM_IS_DEVELOPER_BUILD)
endif()

