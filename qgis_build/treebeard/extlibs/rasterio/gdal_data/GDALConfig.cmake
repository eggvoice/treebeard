cmake_policy(SET CMP0012 NEW)
cmake_policy(SET CMP0057 NEW)
if(NOT "ON")
    if(NOT CMAKE_CXX_COMPILER_LOADED)
        message(WARNING "Linking to GDAL may need CXX to be enabled.")
    endif()
    if(DEFINED CMAKE_MODULE_PATH)
        set(_gdal_module_path_backup "${CMAKE_MODULE_PATH}")
    endif()
    include(CMakeFindDependencyMacro)
# gdal needs a pkg-config tool. A host dependency provides pkgconf.
get_filename_component(vcpkg_host_prefix "${CMAKE_CURRENT_LIST_DIR}/../../../x64-windows" ABSOLUTE)
list(APPEND CMAKE_PROGRAM_PATH "${vcpkg_host_prefix}/tools/pkgconf")
include("${CMAKE_CURRENT_LIST_DIR}/DefineFindPackage2.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/GdalFindModulePath.cmake")
find_dependency(Threads)
find_dependency(PROJ 9 CONFIG)
find_dependency(OpenJPEG MODULE)

    if(DEFINED _gdal_module_path_backup)
        set(CMAKE_MODULE_PATH  "${_gdal_module_path_backup}")
    else()
        unset(CMAKE_MODULE_PATH)
    endif()
endif()
include("${CMAKE_CURRENT_LIST_DIR}/GDAL-targets.cmake")
