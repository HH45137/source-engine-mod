# Platform-specific settings

# ============================================================================
# Detect OS
# ============================================================================

if(WIN32)
    set(PLATFORM_WINDOWS ON)
    set(PLATFORM_NAME "Windows")
elseif(APPLE)
    set(PLATFORM_MACOS ON)
    set(PLATFORM_NAME "macOS")
elseif(UNIX)
    if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
        set(PLATFORM_LINUX ON)
        set(PLATFORM_NAME "Linux")
    elseif(CMAKE_SYSTEM_NAME STREQUAL "Android")
        set(PLATFORM_ANDROID ON)
        set(PLATFORM_NAME "Android")
    elseif(CMAKE_SYSTEM_NAME MATCHES "BSD")
        set(PLATFORM_BSD ON)
        set(PLATFORM_NAME "BSD")
    else()
        set(PLATFORM_UNIX ON)
        set(PLATFORM_NAME "Unix")
    endif()
endif()

# ============================================================================
# Architecture detection
# ============================================================================

if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64")
    set(PLATFORM_64BIT ON)
    add_definitions(-DPLATFORM_64BITS)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "i386|i486|i586|i686|x86")
    set(PLATFORM_32BIT ON)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "armv7|armv7l")
    set(PLATFORM_ARM ON)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64")
    set(PLATFORM_ARM64 ON)
endif()

# Force 32-bit if requested
if(ENABLE_32BIT)
    set(PLATFORM_32BIT ON)
    set(PLATFORM_64BIT OFF)
endif()

# ============================================================================
# Windows Settings
# ============================================================================

if(WIN32)
    add_definitions(-DWIN32=1 -D_WIN32=1)
    add_definitions(-D_WINDOWS -D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-D_CRT_NONSTDC_NO_DEPRECATE)
    add_definitions(-D_ALLOW_RUNTIME_LIBRARY_MISMATCH)
    add_definitions(-D_ALLOW_ITERATOR_DEBUG_LEVEL_MISMATCH)
    add_definitions(-D_ALLOW_MSC_VER_MISMATCH)
    add_definitions(-DNO_HOOK_MALLOC)
    add_definitions(-DNO_X360_XDK)
    add_definitions(-D_DLL_EXT=.dll)

    # Set Windows version (XP compatible)
    add_definitions(-D_WIN32_WINNT=0x0501 -DWINVER=0x0501)

    # MSVC specific
    if(MSVC)
        add_definitions(-DMSVC=1 -DCOMPILER_MSVC -DCOMPILER_MSVC64)
        # Disable some MSVC warnings
        add_compile_options(/W3 /WX-)
    endif()

# ============================================================================
# Linux Settings
# ============================================================================

elseif(PLATFORM_LINUX)
    add_definitions(-DLINUX=1 -D_LINUX=1)
    add_definitions(-DPOSIX=1 -D_POSIX=1 -DPLATFORM_POSIX=1)
    add_definitions(-DGNUC -DNO_HOOK_MALLOC)
    add_definitions(-D_DLL_EXT=".so")
    add_definitions(-D_GLIBCXX_USE_CXX11_ABI=0)

    # Disable FORTIFY_SOURCE
    add_compile_options(-U_FORTIFY_SOURCE)

# ============================================================================
# macOS Settings
# ============================================================================

elseif(PLATFORM_MACOS)
    add_definitions(-DOSX=1 -D_OSX=1)
    add_definitions(-DPOSIX=1 -D_POSIX=1 -DPLATFORM_POSIX=1)
    add_definitions(-DGNUC -DNO_HOOK_MALLOC)
    add_definitions(-D_DLL_EXT=".dylib")

# ============================================================================
# Android Settings
# ============================================================================

elseif(PLATFORM_ANDROID)
    add_definitions(-DANDROID=1 -D_ANDROID=1)
    add_definitions(-DLINUX=1 -D_LINUX=1)
    add_definitions(-DPOSIX=1 -D_POSIX=1)
    add_definitions(-DGNUC -DNO_HOOK_MALLOC)
    add_definitions(-D_DLL_EXT=".so")

# ============================================================================
# BSD Settings
# ============================================================================

elseif(PLATFORM_BSD)
    add_definitions(-DPOSIX=1 -D_POSIX=1 -DPLATFORM_POSIX=1)
    add_definitions(-DPLATFORM_BSD=1)
    add_definitions(-D_DLL_EXT=".so")
endif()

# ============================================================================
# Common settings for non-Windows platforms
# ============================================================================

if(NOT WIN32)
    add_definitions(-DNO_MEMOVERRIDE_NEW_DELETE)
endif()

# ============================================================================
# Dedicated Server Settings
# ============================================================================

if(BUILD_DEDICATED)
    add_definitions(-DDEDICATED)
endif()

# ============================================================================
# Test Build Settings
# ============================================================================

if(BUILD_TESTS)
    add_definitions(-DUNITTESTS)
endif()

# ============================================================================
# ToGL Settings
# ============================================================================

if(USE_TOGL AND NOT BUILD_TESTS AND NOT BUILD_DEDICATED)
    add_definitions(-DDX_TO_GL_ABSTRACTION)
    add_definitions(-DGL_GLEXT_PROTOTYPES)
    add_definitions(-DBINK_VIDEO)
endif()

if(USE_TOGLES)
    add_definitions(-DTOGLES)
endif()

# ============================================================================
# SDL Settings
# ============================================================================

if(USE_SDL AND NOT BUILD_TESTS AND NOT BUILD_DEDICATED)
    add_definitions(-DUSE_SDL)
endif()
