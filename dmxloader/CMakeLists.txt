# dmxloader - DMX file loader

add_library(dmxloader STATIC
    dmxattribute.cpp
    dmxelement.cpp
    dmxloader.cpp
    dmxloadertext.cpp
    dmxserializationdictionary.cpp
)

target_include_directories(dmxloader PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
)

target_compile_definitions(dmxloader PUBLIC DMXLOADER_LIB=1)

target_link_libraries(dmxloader PUBLIC
    tier0
    tier1
    tier2
    tier3
)

install(TARGETS dmxloader ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
