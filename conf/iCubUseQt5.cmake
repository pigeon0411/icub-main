# Copyright (C) 2014  iCub Facility, Istituto Italiano di Tecnologia
# Author: Daniele E. Domenichelli <daniele.domenichelli@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT


include(GNUInstallDirs)


macro(qticub_qml_plugin _target _path)
  set_property(TARGET ${_target} APPEND PROPERTY COMPILE_DEFINITIONS QT_PLUGIN)

  set_target_properties(${_target} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_QMLDIR}/${_path}
                                              LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_QMLDIR}/${_path}
                                              ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_QMLDIR}/${_path})
  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/qmldir")
    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/qmldir"
                   "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_QMLDIR}/${_path}/qmldir"
                   COPYONLY)
  endif()
  foreach(_config ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER ${_config} _CONFIG)
    set_target_properties(${_target} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_${_CONFIG} ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_QMLDIR}/${_config}/${_path}
                                                LIBRARY_OUTPUT_DIRECTORY_${_CONFIG} ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_QMLDIR}/${_config}/${_path}
                                                ARCHIVE_OUTPUT_DIRECTORY_${_CONFIG} ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_QMLDIR}/${_config}/${_path})

    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/qmldir")
      configure_file("${CMAKE_CURRENT_SOURCE_DIR}/qmldir"
                     "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_QMLDIR}/${_config}/${_path}/qmldir"
                     COPYONLY)
    endif()
  endforeach()
endmacro()


macro(QTICUB_USE_QML_PLUGIN)
  # Remove -rdynamic from CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS.
  # This is needed for some weird reason, or executables will not load resources
  # from the plugins.
  string(REPLACE "-rdynamic" "" CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "${CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS}")
  # Configure config.h file
  set(_config_h "${CMAKE_CURRENT_BINARY_DIR}/config.h")
  file(WRITE "${_config_h}.in"
"#ifndef QTICUB_CONFIG_H
#define QTICUB_CONFIG_H

#define PLUGINS_RELATIVE_PATH \"@PLUGINS_RELATIVE_PATH@\"

#endif // QTICUB_CONFIG_H
")
  set(PLUGINS_RELATIVE_PATH "../${CMAKE_INSTALL_QMLDIR}")
  configure_file("${_config_h}.in" "${_config_h}" @ONLY)

  # Include current binary dir to be able to find the config.h file
  include_directories(${CMAKE_CURRENT_BINARY_DIR})
endmacro()


# Hide qt5_use_modules function (that generates several warnings), when
# it can be replaced by target_link_libraries (CMake 2.8.11 or later)
# NOTE: when CMake minimum required version is 2.8.11 or later,
#       these calls should be replaced with target_link_libraries.
# Also take care of adding the required -fPIC compile flags to all
# target using Qt5.
# NOTE: when CMake minimum required version is 2.8.12 or later, this
#       will no longer be required.
macro(qticub_use_modules _target)
  if(NOT ${CMAKE_VERSION} VERSION_LESS 2.8.11)
    foreach(_qt5lib ${ARGN})
      target_link_libraries(${_target} Qt5::${_qt5lib})
    endforeach()
  else()
    qt5_use_modules(${_target} ${ARGN})
  endif()

  # Append executable compile flags (usually -fPIC) when required
  if(${CMAKE_VERSION} VERSION_LESS 2.8.12)
    get_property(_type TARGET ${_target} PROPERTY TYPE)
    if("${_type}" STREQUAL "EXECUTABLE")
      foreach(_qt5lib ${ARGN})
        if(NOT "${CMAKE_CXX_FLAGS}" MATCHES "${Qt5${_qt5lib}_EXECUTABLE_COMPILE_FLAGS}")
          set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Qt5${_qt5lib}_EXECUTABLE_COMPILE_FLAGS}")
        endif()
      endforeach()

      # If -fPIC is enabled, disable POSITION_INDEPENDENT_CODE,
      # otherwise -fPIE will be appended on executables and -fPIC will
      # not be used
      if("${CMAKE_CXX_FLAGS}" MATCHES "-fPIC")
        set_property(TARGET ${_target} PROPERTY POSITION_INDEPENDENT_CODE FALSE)
      endif()
    endif()
  endif()

endmacro()


# Instruct CMake to issue deprecation warnings for macros and functions.
set(CMAKE_WARN_DEPRECATED TRUE)


# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)
