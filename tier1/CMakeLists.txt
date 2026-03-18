# Tier1 - Utility library

add_library(tier1 STATIC
    ${CMAKE_SOURCE_DIR}/utils/lzma/C/LzmaDec.c
    bitbuf.cpp
    byteswap.cpp
    characterset.cpp
    checksum_crc.cpp
    checksum_md5.cpp
    checksum_sha1.cpp
    commandbuffer.cpp
    convar.cpp
    datamanager.cpp
    diff.cpp
    generichash.cpp
    ilocalize.cpp
    interface.cpp
    KeyValues.cpp
    keyvaluesjson.cpp
    kvpacker.cpp
    lzmaDecoder.cpp
    lzss.cpp
    mempool.cpp
    memstack.cpp
    NetAdr.cpp
    newbitbuf.cpp
    rangecheckedvar.cpp
    reliabletimer.cpp
    snappy-sinksource.cpp
    snappy-stubs-internal.cpp
    snappy.cpp
    sparsematrix.cpp
    splitstring.cpp
    stringpool.cpp
    strtools.cpp
    strtools_unicode.cpp
    tier1.cpp
    tokenreader.cpp
    uniqueid.cpp
    utlbinaryblock.cpp
    utlbuffer.cpp
    utlbufferutil.cpp
    utlstring.cpp
    utlsymbol.cpp
)

# Platform-specific sources
if(WIN32)
    target_sources(tier1 PRIVATE
        processor_detect.cpp
    )
else()
    target_sources(tier1 PRIVATE
        processor_detect_linux.cpp
        qsort_s.cpp
    )
endif()

# Defines
target_compile_definitions(tier1 PUBLIC TIER1_STATIC_LIB=1)
# VSTDLIB is static, so don't use DLL import
target_compile_definitions(tier1 PUBLIC VSTDLIB_DLL_EXPORT=0)

# Includes
target_include_directories(tier1 PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/common
)

# Dependencies
target_link_libraries(tier1 PUBLIC tier0)

# Platform libs
if(WIN32)
    target_link_libraries(tier1 PRIVATE rpcrt4)
elseif(APPLE)
    target_link_libraries(tier1 PRIVATE iconv)
endif()

install(TARGETS tier1 ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
