# Dependency detection

# ============================================================================
# Common required libraries (Windows)
# ============================================================================

if(WIN32)
    # Find BZip2 (required for engine)
    find_package(BZip2 QUIET)
    if(BZIP2_FOUND)
        message(STATUS "BZip2 found: ${BZIP2_VERSION}")
    else()
        message(WARNING "BZip2 not found, some features may be disabled")
    endif()

    # Find Zlib (required)
    find_package(ZLIB QUIET)

# ============================================================================
# Unix/Linux/BSD required libraries
# ============================================================================

elseif(UNIX)
    # Find Threads (required on all Unix)
    find_package(Threads REQUIRED)

    # Find BZip2 (required)
    find_package(BZip2 REQUIRED)

    # Find Zlib (required)
    find_package(ZLIB REQUIRED)

    # Find SDL2 (optional but recommended)
    if(USE_SDL AND NOT BUILD_TESTS AND NOT BUILD_DEDICATED)
        find_package(SDL2 QUIET)
        if(SDL2_FOUND)
            message(STATUS "SDL2 found: ${SDL2_VERSION}")
            set(SDL2_AVAILABLE ON)
        else()
            message(WARNING "SDL2 not found, SDL support disabled")
            set(USE_SDL OFF)
        endif()
    endif()

    # Find pkg-config (for optional libraries)
    find_package(PkgConfig QUIET)

    # Find FreeType (optional, for client builds)
    if(PkgConfig_FOUND AND NOT BUILD_DEDICATED AND NOT BUILD_TESTS)
        pkg_check_modules(FREETYPE QUIET freetype2)
        if(FREETYPE_FOUND)
            message(STATUS "FreeType found: ${FREETYPE_VERSION}")
            set(FREETYPE_AVAILABLE ON)
        endif()
    endif()

    # Find Fontconfig (optional, for client builds)
    if(PkgConfig_FOUND AND NOT BUILD_DEDICATED AND NOT BUILD_TESTS)
        pkg_check_modules(FONTCONFIG QUIET fontconfig)
        if(FONTCONFIG_FOUND)
            message(STATUS "Fontconfig found: ${FONTCONFIG_VERSION}")
            set(FONTCONFIG_AVAILABLE ON)
        endif()
    endif()

    # Find OpenAL (optional, for client builds)
    if(PkgConfig_FOUND AND NOT BUILD_DEDICATED AND NOT BUILD_TESTS)
        pkg_check_modules(OPENAL QUIET openal)
        if(OPENAL_FOUND)
            message(STATUS "OpenAL found: ${OPENAL_VERSION}")
            set(OPENAL_AVAILABLE ON)
        endif()
    endif()

    # Find libjpeg (optional)
    if(PkgConfig_FOUND)
        pkg_check_modules(JPEG QUIET libjpeg)
        if(JPEG_FOUND)
            message(STATUS "libjpeg found: ${JPEG_VERSION}")
            set(JPEG_AVAILABLE ON)
        endif()
    endif()

    # Find libpng (optional)
    if(PkgConfig_FOUND)
        pkg_check_modules(PNG QUIET libpng)
        if(PNG_FOUND)
            message(STATUS "libpng found: ${PNG_VERSION}")
            set(PNG_AVAILABLE ON)
        endif()
    endif()

    # Find libcurl (optional)
    if(PkgConfig_FOUND)
        pkg_check_modules(CURL QUIET libcurl)
        if(CURL_FOUND)
            message(STATUS "libcurl found: ${CURL_VERSION}")
            set(CURL_AVAILABLE ON)
        endif()
    endif()

    # Find Opus (optional)
    if(ENABLE_OPUS AND PkgConfig_FOUND)
        pkg_check_modules(OPUS QUIET opus)
        if(OPUS_FOUND)
            message(STATUS "Opus found: ${OPUS_VERSION}")
            set(OPUS_AVAILABLE ON)
        else()
            message(WARNING "Opus not found, voice codec disabled")
            set(ENABLE_OPUS OFF)
        endif()
    endif()

    # Find libedit (optional, for dedicated server)
    if(PkgConfig_FOUND AND BUILD_DEDICATED)
        pkg_check_modules(EDIT QUIET libedit)
        if(EDIT_FOUND)
            message(STATUS "libedit found: ${EDIT_VERSION}")
            set(EDIT_AVAILABLE ON)
        endif()
    endif()

# ============================================================================
# Android
# ============================================================================

elseif(PLATFORM_ANDROID)
    # On Android, we use bundled libraries
    include_directories(${CMAKE_SOURCE_DIR}/thirdparty/SDL/include)
    include_directories(${CMAKE_SOURCE_DIR}/thirdparty/curl/include)
    include_directories(${CMAKE_SOURCE_DIR}/thirdparty/openal-soft/include)
    include_directories(${CMAKE_SOURCE_DIR}/thirdparty/freetype/include)
    include_directories(${CMAKE_SOURCE_DIR}/thirdparty/fontconfig)

    find_library(LOG_LIBRARY log)
    find_library(ANDROID_LIBRARY android)
    find_library(OPENGL_LIBRARY GLESv2)

    set(ANDROID_LIBS ${LOG_LIBRARY} ${ANDROID_LIBRARY} ${OPENGL_LIBRARY})

    if(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
        find_library(UNWIND_LIBRARY unwind)
        find_library(CRYPTO_LIBRARY crypto)
        find_library(SSL_LIBRARY ssl)
        list(APPEND ANDROID_LIBS ${UNWIND_LIBRARY} ${CRYPTO_LIBRARY} ${SSL_LIBRARY})
    endif()

    # Bundled libraries
    set(ANDROID_BUNDLED_LIBS
        SDL2
        freetype2
        jpeg
        png
        curl
        z
        opus
    )

# ============================================================================
# macOS
# ============================================================================

elseif(APPLE)
    # Use system frameworks on macOS
    set(APPLE_LIBS
        "-framework Cocoa"
        "-framework OpenGL"
        "-framework IOKit"
        "-framework Foundation"
        "-framework CoreFoundation"
        "-framework CoreGraphics"
        "-framework Carbon"
        "-framework ApplicationServices"
        "-framework CoreServices"
        "-framework CoreAudio"
        "-framework AudioToolbox"
        "-framework SystemConfiguration"
        "-framework AppKit"
    )

    # Find SDL2 via pkg-config or CMake
    if(USE_SDL)
        find_package(SDL2 QUIET)
        if(SDL2_FOUND)
            set(SDL2_AVAILABLE ON)
        endif()
    endif()

    # Find OpenAL
    if(NOT BUILD_DEDICATED AND NOT BUILD_TESTS)
        pkg_check_modules(OPENAL QUIET openal)
        if(OPENAL_FOUND)
            set(OPENAL_AVAILABLE ON)
        endif()
    endif()
endif()

# ============================================================================
# Set up global include directories
# ============================================================================

# Public headers are always included
include_directories(
    ${CMAKE_SOURCE_DIR}/common
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
)

# ============================================================================
# Helper function to link dependencies
# ============================================================================

function(target_link_common_libs TARGET)
    if(WIN32)
        target_link_libraries(${TARGET} PRIVATE ${WINDOWS_LIBS})
    elseif(PLATFORM_ANDROID)
        target_link_libraries(${TARGET} PRIVATE ${ANDROID_LIBS})
    elseif(APPLE)
        target_link_libraries(${TARGET} PRIVATE ${APPLE_LIBS})
    elseif(UNIX)
        target_link_libraries(${TARGET} PRIVATE Threads::Threads ${UNIX_LIBS})
    endif()
endfunction()
