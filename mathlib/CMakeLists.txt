# mathlib - Math library

add_library(mathlib STATIC
    color_conversion.cpp
    halton.cpp
    lightdesc.cpp
    mathlib_base.cpp
    powsse.cpp
    sparse_convolution_noise.cpp
    sseconst.cpp
    sse.cpp
    ssenoise.cpp
    3dnow.cpp
    anorms.cpp
    bumpvects.cpp
    IceKey.cpp
    imagequant.cpp
    polyhedron.cpp
    quantize.cpp
    randsse.cpp
    spherical.cpp
    simdvectormatrix.cpp
    vector.cpp
    vmatrix.cpp
    almostequal.cpp
)

target_include_directories(mathlib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/common
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/mathlib
)

target_link_libraries(mathlib PUBLIC tier0)

install(TARGETS mathlib ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
