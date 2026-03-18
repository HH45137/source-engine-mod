# engine - Core engine (Source file list from wscript)

# Collect all source files from engine directory
file(GLOB ENGINE_SOURCES
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
)

# Add sources from common and public directories
set(ENGINE_COMMON_SOURCES
    ${CMAKE_SOURCE_DIR}/public/blockingudpsocket.cpp
    ${CMAKE_SOURCE_DIR}/public/bsptreedata.cpp
    ${CMAKE_SOURCE_DIR}/public/builddisp.cpp
    ${CMAKE_SOURCE_DIR}/public/collisionutils.cpp
    ${CMAKE_SOURCE_DIR}/public/crtmemdebug.cpp
    ${CMAKE_SOURCE_DIR}/public/disp_common.cpp
    ${CMAKE_SOURCE_DIR}/public/disp_powerinfo.cpp
    ${CMAKE_SOURCE_DIR}/public/dispcoll_common.cpp
    ${CMAKE_SOURCE_DIR}/public/dt_recv.cpp
    ${CMAKE_SOURCE_DIR}/public/dt_send.cpp
    ${CMAKE_SOURCE_DIR}/public/dt_utlvector_common.cpp
    ${CMAKE_SOURCE_DIR}/public/dt_utlvector_recv.cpp
    ${CMAKE_SOURCE_DIR}/public/dt_utlvector_send.cpp
    ${CMAKE_SOURCE_DIR}/public/filesystem_helpers.cpp
    ${CMAKE_SOURCE_DIR}/public/filesystem_init.cpp
    ${CMAKE_SOURCE_DIR}/public/lumpfiles.cpp
    ${CMAKE_SOURCE_DIR}/public/networkvar.cpp
    ${CMAKE_SOURCE_DIR}/public/registry.cpp
    ${CMAKE_SOURCE_DIR}/public/sentence.cpp
    ${CMAKE_SOURCE_DIR}/public/studio.cpp
    ${CMAKE_SOURCE_DIR}/public/vallocator.cpp
    ${CMAKE_SOURCE_DIR}/public/XZip.cpp
    ${CMAKE_SOURCE_DIR}/public/XUnzip.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
    ${CMAKE_SOURCE_DIR}/common/language.cpp
    ${CMAKE_SOURCE_DIR}/common/netmessages.cpp
    ${CMAKE_SOURCE_DIR}/common/steamid.cpp
    ${CMAKE_SOURCE_DIR}/common/randoverride.cpp
    ${CMAKE_SOURCE_DIR}/common/SourceAppInfo.cpp
)

add_library(engine SHARED
    ${ENGINE_SOURCES}
    ${ENGINE_COMMON_SOURCES}
)

# Defines
target_compile_definitions(engine PRIVATE
    ENGINE_DLL=1
    VERSION_SAFE_STEAM_API_INTERFACES=1
    USE_BREAKPAD_HANDLER=1
    USE_CONVARS=1
    VOICE_OVER_IP=1
)

if(BUILD_DEDICATED)
    target_compile_definitions(engine PRIVATE SWDS=1 NO_STEAM=1)
endif()

target_include_directories(engine PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/audio
    ${CMAKE_SOURCE_DIR}/public/engine/audio/
    ${CMAKE_SOURCE_DIR}/common
)

target_link_libraries(engine PUBLIC
    tier0
    tier1
    tier2
    tier3
    appframework
    filesystem
    materialsystem
    studiorender
    vgui2
    inputsystem
    network
    vstdlib
    dmxloader
    datamodel
    bitmap
    vtf
    mathlib
)

# Platform libs
if(WIN32)
    target_link_libraries(engine PRIVATE
        user32
        winmm
        wininet
        dsound
        dxguid
        gdi32
        bzip2
    )
endif()

# Android specific libs
if(ANDROID)
    target_link_libraries(engine PRIVATE
        ssl
        crypto
    )
endif()

# macOS specific libs
if(APPLE AND NOT BUILD_DEDICATED)
    target_link_libraries(engine PRIVATE
        "-framework AppKit"
        "-framework CoreAudio"
        "-framework AudioToolbox"
        "-framework SystemConfiguration"
    )
endif()

# Optional libraries (may not exist in all builds)
find_library(OPENAL_LIBRARY NAMES openal)
if(OPENAL_LIBRARY)
    target_link_libraries(engine PUBLIC ${OPENAL_LIBRARY})
endif()

find_library(CURL_LIBRARY NAMES curl)
if(CURL_LIBRARY)
    target_link_libraries(engine PUBLIC ${CURL_LIBRARY})
endif()

install(TARGETS engine RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
