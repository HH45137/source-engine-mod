# Source Engine CMake Build System

cmake_minimum_required(VERSION 3.15)
project(SourceEngine VERSION 1.0.0 LANGUAGES C CXX)

# C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile commands for IDE integration
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Default to release build if not specified
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "RelWithDebInfo" "MinSizeRel")
endif()

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Include CMake modules
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# ============================================================================
# Build Options
# ============================================================================

option(BUILD_DEDICATED "Build dedicated server" OFF)
option(BUILD_TESTS "Build unit tests" OFF)
option(USE_SDL "Use SDL2" OFF)
option(USE_TOGL "Use ToGL renderer" OFF)
option(USE_TOGLES "Use ToGL ES renderer" OFF)
option(ENABLE_OPUS "Enable Opus voice codec" OFF)
option(ENABLE_32BIT "Build 32-bit version" OFF)
option(DEBUG_BUILD "Debug build" OFF)
option(ENABLE_CCACHE "Use ccache" OFF)
option(DISABLE_WARNINGS "Disable compiler warnings" OFF)

# ============================================================================
# Platform Detection and Settings
# ============================================================================

include(cmake/platform_settings.cmake)

# ============================================================================
# Compiler Settings
# ============================================================================

include(cmake/compiler_options.cmake)

# ============================================================================
# Dependency Detection
# ============================================================================

include(cmake/find_dependencies.cmake)

# ============================================================================
# Git Version
# ============================================================================

find_package(Git QUIET)
if(GIT_FOUND AND EXISTS ${CMAKE_SOURCE_DIR}/.git)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --tags --always --dirty
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
    )
else()
    set(GIT_VERSION "unknown")
endif()

add_definitions(-DGIT_COMMIT_HASH="${GIT_VERSION}")

# ============================================================================
# Build Type Specific Settings
# ============================================================================

if(DEBUG_BUILD)
    add_definitions(-DDEBUG -D_DEBUG)
    set(CMAKE_BUILD_TYPE "Debug")
else()
    add_definitions(-DNDEBUG)
endif()

# ============================================================================
# Subdirectories - Core Libraries (Order matters!)
# ============================================================================

# Tier libraries first (no dependencies on each other)
add_subdirectory(tier0)
add_subdirectory(tier1)
add_subdirectory(tier2)
add_subdirectory(tier3)

# Standard library replacement
add_subdirectory(vstdlib)

# VPK support
add_subdirectory(vpklib)

# Bitmap/image processing
add_subdirectory(bitmap)

# Math library
add_subdirectory(mathlib)

# Data management
add_subdirectory(datacache)
add_subdirectory(datamodel)
add_subdirectory(dmxloader)

# App framework
add_subdirectory(appframework)

# File system
add_subdirectory(filesystem)

# Input system
add_subdirectory(inputsystem)

# Material system
add_subdirectory(materialsystem)
add_subdirectory(materialsystem/shaderlib)

# Studio rendering
add_subdirectory(studiorender)

# Particles
add_subdirectory(particles)

# Sound systems
add_subdirectory(soundemittersystem)
add_subdirectory(soundsystem)

# Network
add_subdirectory(networksystem)

# Unicode
add_subdirectory(unicode)

# VTF (Valve Texture Format)
add_subdirectory(vtf)

# VGUI
add_subdirectory(vgui2)
add_subdirectory(vguimatsurface)

# Game UI
add_subdirectory(gameui)

# Server browser
add_subdirectory(serverbrowser)

# Video
add_subdirectory(video)

# Physics
add_subdirectory(vphysics)

# Choreo objects
add_subdirectory(choreoobjects)

# Scene file cache
add_subdirectory(scenefilecache)

# Steam stub
add_subdirectory(stub_steam)

# ============================================================================
# Main Engine (after all dependencies)
# ============================================================================

add_subdirectory(engine)

# ============================================================================
# Launcher
# ============================================================================

add_subdirectory(launcher)
add_subdirectory(launcher_main)

# ============================================================================
# Game DLLs (client and server)
# ============================================================================

add_subdirectory(game/client)
add_subdirectory(game/server)

# ============================================================================
# Optional Components
# ============================================================================

if(USE_TOGL)
    add_subdirectory(togl)
endif()

if(USE_TOGLES)
    add_subdirectory(togles)
endif()

# ============================================================================
# Dedicated Server
# ============================================================================

if(BUILD_DEDICATED)
    add_subdirectory(dedicated)
    add_subdirectory(dedicated_main)
endif()

# ============================================================================
# Unit Tests
# ============================================================================

if(BUILD_TESTS)
    enable_testing()
    add_subdirectory(unitlib)
    add_subdirectory(unittests)
endif()

# ============================================================================
# Installation
# ============================================================================

include(GNUInstallDirs)

install(DIRECTORY public/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FILES_MATCHING PATTERN "*.h"
)

message(STATUS "========================================")
message(STATUS "Source Engine CMake Configuration")
message(STATUS "========================================")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "System: ${CMAKE_SYSTEM_NAME}")
message(STATUS "Processor: ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "Git version: ${GIT_VERSION}")
message(STATUS "========================================")
message(STATUS "Options:")
message(STATUS "  BUILD_DEDICATED: ${BUILD_DEDICATED}")
message(STATUS "  BUILD_TESTS: ${BUILD_TESTS}")
message(STATUS "  USE_SDL: ${USE_SDL}")
message(STATUS "  USE_TOGL: ${USE_TOGL}")
message(STATUS "  USE_TOGLES: ${USE_TOGLES}")
message(STATUS "  ENABLE_OPUS: ${ENABLE_OPUS}")
message(STATUS "  ENABLE_32BIT: ${ENABLE_32BIT}")
message(STATUS "  DEBUG_BUILD: ${DEBUG_BUILD}")
message(STATUS "========================================")
