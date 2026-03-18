# vphysics - Physics engine wrapper

add_library(vphysics SHARED
    convert.cpp
    ${CMAKE_SOURCE_DIR}/public/filesystem_helpers.cpp
    ledgewriter.cpp
    main.cpp
    physics_airboat.cpp
    physics_collide.cpp
    physics_constraint.cpp
    physics_controller_raycast_vehicle.cpp
    physics_environment.cpp
    physics_fluid.cpp
    physics_friction.cpp
    physics_material.cpp
    physics_motioncontroller.cpp
    physics_object.cpp
    physics_shadow.cpp
    physics_spring.cpp
    physics_vehicle.cpp
    physics_virtualmesh.cpp
    trace.cpp
    vcollide_parse.cpp
    vphysics_saverestore.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

target_compile_definitions(vphysics PRIVATE
    VPHYSICS_EXPORTS=1
    HAVANA_CONSTRAINTS=1
    HAVOK_MOPP=1
)

target_include_directories(vphysics PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/ivp/ivp_intern
    ${CMAKE_SOURCE_DIR}/ivp/ivp_collision
    ${CMAKE_SOURCE_DIR}/ivp/ivp_physics
    ${CMAKE_SOURCE_DIR}/ivp/ivp_surface_manager
    ${CMAKE_SOURCE_DIR}/ivp/ivp_utility
    ${CMAKE_SOURCE_DIR}/ivp/ivp_controller
    ${CMAKE_SOURCE_DIR}/ivp/ivp_compact_builder
    ${CMAKE_SOURCE_DIR}/ivp/havana/havok
    ${CMAKE_SOURCE_DIR}/ivp/havana
)

target_link_libraries(vphysics PUBLIC
    tier0
    tier1
    tier2
    tier3
    vstdlib
    mathlib
)

install(TARGETS vphysics RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})
