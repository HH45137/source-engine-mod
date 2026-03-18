# datamodel - Data model

add_library(datamodel STATIC
    clipboardmanager.cpp
    datamodel.cpp
    dependencygraph.cpp
    dmattribute.cpp
    dmelement.cpp
    dmelementdictionary.cpp
    dmelementfactoryhelper.cpp
    DmElementFramework.cpp
    dmserializerbinary.cpp
    dmserializerkeyvalues.cpp
    dmserializerkeyvalues2.cpp
    undomanager.cpp
)

target_include_directories(datamodel PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
)

target_compile_definitions(datamodel PUBLIC DATAMODEL_LIB=1)

target_link_libraries(datamodel PUBLIC
    tier0
    tier1
    tier2
    tier3
    datacache
    dmxloader
)

install(TARGETS datamodel ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
