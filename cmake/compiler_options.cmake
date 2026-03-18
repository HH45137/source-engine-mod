# Compiler-specific options

# ============================================================================
# ccache support
# ============================================================================

if(ENABLE_CCACHE)
    find_program(CCACHE_PROGRAM ccache)
    if(CCACHE_PROGRAM)
        message(STATUS "Using ccache: ${CCACHE_PROGRAM}")
        set(CMAKE_C_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
        set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_PROGRAM})
    endif()
endif()

# ============================================================================
# MSVC Compiler Options
# ============================================================================

if(MSVC)
    # Common flags
    add_compile_options(
        /MP          # Multi-processor compilation
        /GS         # Buffer security check
        /Gy         # Function-level linking
        /Gm-        # Disable minimal rebuild
        /fp:fast    # Fast floating point
        /Zc:forScope
        /Zc:wchar_t
        /GR         # Enable RTTI
        /TP         # Treat all files as C++
        /EHsc       # Exception handling
    )

    # Architecture-specific
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        add_compile_options(/arch:AVX)
    else()
        add_compile_options(/arch:SSE)
    endif()

    # Warning level
    if(DISABLE_WARNINGS)
        add_compile_options(/W0)
    else()
        add_compile_options(/W3)
    endif()

    # Linker flags
    add_link_options(/LARGEADDRESSAWARE)

    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        add_link_options(
            /INCREMENTAL:NO
            /NODEFAULTLIB:libc
            /NODEFAULTLIB:libcd
            /NODEFAULTLIB:libcmt
            /FORCE:MULTIPLE
        )
    else()
        add_link_options(
            /INCREMENTAL
            /NODEFAULTLIB:libc
            /NODEFAULTLIB:libcd
            /NODEFAULTLIB:libcmtd
        )
    endif()

    # Platform libs
    set(WINDOWS_LIBS
        user32
        shell32
        gdi32
        advapi32
        dbghelp
        psapi
        ws2_32
        rpcrt4
        winmm
        wininet
        ole32
        shlwapi
        imm32
    )

# ============================================================================
# GCC/Clang Compiler Options
# ============================================================================

elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")

    # Common flags
    add_compile_options(
        -pipe
        -fPIC
        -pthread
    )

    # Architecture-specific optimizations
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64")
        add_compile_options(-march=core2 -mfpmath=sse)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "i386|i486|i586|i686|x86")
        add_compile_options(-march=core2 -mfpmath=sse)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "armv7")
        add_compile_options(-march=armv7-a -mfpu=neon-vfpv4)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64")
        add_compile_options(-fsigned-char)
    endif()

    # Signed char for ARM
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "arm|aarch64")
        add_compile_options(-fsigned-char)
    endif()

    # Android-specific
    if(PLATFORM_ANDROID)
        add_compile_options(
            -funwind-tables
            -g
            -llog
            -lz
        )
        include_directories(${CMAKE_SOURCE_DIR}/thirdparty/SDL)
        include_directories(${CMAKE_SOURCE_DIR}/thirdparty/curl/include)
        include_directories(${CMAKE_SOURCE_DIR}/thirdparty/openal-soft/include/)
        include_directories(${CMAKE_SOURCE_DIR}/thirdparty/fontconfig)
        include_directories(${CMAKE_SOURCE_DIR}/thirdparty/freetype/include)
    endif()

    # C++ standard
    add_compile_options(-std=c++11 -fpermissive)

    # Warning flags
    if(NOT DISABLE_WARNINGS)
        add_compile_options(
            -Wall
            -fdiagnostics-color=always
            -Wcast-align
            -Wuninitialized
            -Winit-self
            -Wstrict-aliasing
            -Wno-reorder
            -Wno-unknown-pragmas
            -Wno-unused-function
            -Wno-unused-but-set-variable
            -Wno-unused-value
            -Wno-unused-variable
            -faligned-new
        )
    else()
        add_compile_options(-w)
    endif()

    # Sanitizer support
    if(SANITIZER)
        add_compile_options(-fsanitize=${SANITIZER} -fno-sanitize=vptr)
    endif()

    # Link directories
    if(NOT WIN32)
        link_directories(${CMAKE_SOURCE_DIR}/lib/${CMAKE_SYSTEM_NAME}/${CMAKE_SYSTEM_PROCESSOR})
    endif()

    # FreeBSD needs libexecinfo
    if(CMAKE_SYSTEM_NAME MATCHES "BSD")
        set(BSD_LIBS execinfo)
    endif()

    # Standard libraries
    set(UNIX_LIBS
        dl
        m
        rt
        pthread
        bz2
    )

    # Compiler detection
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        add_definitions(-DCOMPILER_GCC=1)
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        add_definitions(-DCOMPILER_CLANG=1)
    endif()

# ============================================================================
# Apple Clang Options
# ============================================================================

elseif(APPLE)
    add_compile_options(
        -pipe
        -fPIC
        -pthread
        -stdlib=libc++
    )

    add_compile_options(-std=c++11 -fpermissive)

    if(NOT DISABLE_WARNINGS)
        add_compile_options(
            -Wall
            -fdiagnostics-color=always
            -Wcast-align
            -Wuninitialized
            -Winit-self
            -Wstrict-aliasing
            -Wno-reorder
            -Wno-unknown-pragmas
            -Wno-unused-function
            -Wno-unused-but-set-variable
            -Wno-unused-value
            -Wno-unused-variable
        )
    endif()

    # Frameworks
    set(APPLE_FRAMEWORKS
        Cocoa
        OpenGL
        IOKit
        Foundation
        CoreFoundation
        CoreGraphics
        Carbon
        ApplicationServices
        CoreServices
        CoreAudio
        AudioToolbox
        SystemConfiguration
        AppKit
    )
endif()

# ============================================================================
# Precompiled Headers
# ============================================================================
# Note: Precompiled headers are configured in individual target CMakeLists.txt files
