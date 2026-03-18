# bitmap - Image/bitmap processing

add_library(bitmap STATIC
    ImageByteSwap.cpp
    colorconversion.cpp
    float_bm.cpp
    float_bm2.cpp
    float_bm3.cpp
    float_bm_bilateral_filter.cpp
    float_cube.cpp
    imageformat.cpp
    psd.cpp
    resample.cpp
    tgaloader.cpp
    tgawriter.cpp
    bitmap.cpp
)

# Platform-specific sources
if(WIN32)
    target_sources(bitmap PRIVATE
        float_bm4.cpp
    )
endif()

target_include_directories(bitmap PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/thirdparty/stb
)

target_link_libraries(bitmap PUBLIC
    tier0
    tier1
    tier2
)

install(TARGETS bitmap ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
