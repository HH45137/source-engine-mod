# Tier0 - Base runtime library

add_library(tier0 SHARED
    assert_dialog.cpp
    commandline.cpp
    cpu.cpp
    cpumonitoring.cpp
    cpu_usage.cpp
    dbg.cpp
    dynfunction.cpp
    fasttimer.cpp
    mem.cpp
    mem_helpers.cpp
    memdbg.cpp
    memstd.cpp
    memvalidate.cpp
    minidump.cpp
    pch_tier0.cpp
    PMELib.cpp
    progressbar.cpp
    security.cpp
    systeminformation.cpp
    stacktools.cpp
    thread.cpp
    threadtools.cpp
    tier0_strtools.cpp
    tslist.cpp
    vprof.cpp
)

# Platform-specific sources
if(WIN32)
    target_sources(tier0 PRIVATE
        assert_dialog.rc
        platform.cpp
        pme.cpp
        vcrmode.cpp
        win32consoleio.cpp
    )

    # 64-bit specific
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        target_sources(tier0 PRIVATE
            InterlockedCompareExchange128.masm
        )
    endif()

    # Windows libs
    target_link_libraries(tier0 PRIVATE
        advapi32
        ws2_32
    )
else()
    target_sources(tier0 PRIVATE
        cpu_posix.cpp
        platform_posix.cpp
        pme_posix.cpp
        vcrmode_posix.cpp
    )

    # POSIX libs
    target_link_libraries(tier0 PRIVATE
        dl
        m
    )
endif()

# Public includes
target_include_directories(tier0 PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
)

# Defines
target_compile_definitions(tier0 PRIVATE
    TIER0_DLL_EXPORT=1
    WAF_CFLAGS="${CMAKE_C_FLAGS}"
    WAF_LDFLAGS="${CMAKE_EXE_LINKER_FLAGS}"
)

# Compile options
target_compile_options(tier0 PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W0>  # Tier0 has many warnings
)

# Installation
install(TARGETS tier0
    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
