# Source Engine Waf to CMake 迁移计划

## 1. 项目概述

### 当前构建系统
- **构建工具**: Waf (Python-based)
- **构建入口**: `wscript` (根目录) + 各子目录的 `wscript`
- **项目数量**: ~40+ 个子项目

### 目标构建系统
- **构建工具**: CMake 3.15+
- **构建入口**: `CMakeLists.txt` (根目录) + 各子目录的 `CMakeLists.txt`

---

## 2. CMake 架构设计

### 2.1 目录结构

```
source-engine/
├── CMakeLists.txt              # 根构建文件
├── cmake/
│   ├── FindXXX.cmake           # 自定义Find模块
│   ├── platform_settings.cmake # 平台特定设置
│   └── compiler_options.cmake  # 编译器选项
├── public/
│   └── CMakeLists.txt          # 公共头文件
├── tier0/
│   └── CMakeLists.txt
├── tier1/
│   └── CMakeLists.txt
├── tier2/
│   └── CMakeLists.txt
├── tier3/
│   └── CMakeLists.txt
├── appframework/
│   └── CMakeLists.txt
├── engine/
│   └── CMakeLists.txt
├── materialsystem/
│   └── CMakeLists.txt
├── ... (其他子项目)
```

### 2.2 根 CMakeLists.txt 结构

```cmake
cmake_minimum_required(VERSION 3.15)
project(SourceEngine VERSION 1.0.0 LANGUAGES C CXX)

# 选项定义
option(BUILD_DEDICATED "Build dedicated server" OFF)
option(BUILD_TESTS "Build unit tests" OFF)
option(USE_SDL "Use SDL2" ON)
option(USE_TOGL "Use ToGL" ON)
option(ENABLE_OPUS "Enable Opus voice codec" OFF)
option(ENABLE_32BIT "Build 32-bit version" OFF)
option(DEBUG_BUILD "Debug build" OFF)

# 平台检测
include(cmake/platform_settings.cmake)

# 依赖检测
include(cmake/find_dependencies.cmake)

# 编译器设置
include(cmake/compiler_options.cmake)

# 子项目
add_subdirectory(tier0)
add_subdirectory(tier1)
add_subdirectory(tier2)
add_subdirectory(tier3)
# ... 其他子项目
```

### 2.3 子项目 CMakeLists.txt 模板

```cmake
add_library(${PROJECT_NAME} STATIC
    source1.cpp
    source2.cpp
    ${CMAKE_SOURCE_DIR}/public/filesystem_init.cpp
)

target_include_directories(${PROJECT_NAME} PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
)

target_link_libraries(${PROJECT_NAME} PUBLIC
    tier0
    # 其他依赖
)

# 平台特定源文件
if(WIN32)
    target_sources(${PROJECT_NAME} PRIVATE
        win32_specific.cpp
    )
else()
    target_sources(${PROJECT_NAME} PRIVATE
        posix_specific.cpp
    )
endif()
```

---

## 3. 迁移步骤

### 阶段 1: 创建基础 CMake 结构

- [ ] 创建 `CMakeLists.txt` (根目录)
- [ ] 创建 `cmake/platform_settings.cmake`
- [ ] 创建 `cmake/compiler_options.cmake`
- [ ] 创建 `cmake/FindDependencies.cmake`

### 阶段 2: 迁移核心依赖库

- [ ] tier0 - 基础运行时库
- [ ] tier1 - 工具库
- [ ] tier2 - 通用工具库
- [ ] tier3 - 高级工具库

### 阶段 3: 迁移主引擎组件

- [ ] vstdlib - 标准库替代
- [ ] vpklib - VPK 文件处理
- [ ] bitmap - 位图处理
- [ ] mathlib - 数学库
- [ ] datacache - 数据缓存
- [ ] datamodel - 数据模型

### 阶段 4: 迁移中间件

- [ ] appframework - 应用框架
- [ ] filesystem - 文件系统
- [ ] materialsystem - 材质系统
- [ ] studiorender - 模型渲染

### 阶段 5: 迁移游戏引擎

- [ ] engine - 核心引擎
- [ ] game/client - 客户端
- [ ] game/server - 服务器
- [ ] particles - 粒子系统

### 阶段 6: 迁移工具和UI

- [ ] vgui2 - VGUI2
- [ ] vguimatsurface - VGUI 材质表面
- [ ] gameui - 游戏UI
- [ ] serverbrowser - 服务器浏览器
- [ ] utils/ - 各种工具

### 阶段 7: 可选组件

- [ ] dedicated - 专用服务器
- [ ] tests - 单元测试
- [ ] togl - ToGL 渲染
- [ ] togles - ToGL ES

---

## 4. 平台特定处理

### 4.1 Windows

```cmake
if(WIN32)
    add_definitions(-DWIN32=1 -D_WIN32=1 -D_WINDOWS)
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    target_link_libraries(${PROJECT} PRIVATE
        user32 shell32 gdi32 advapi32 dbghelp
        psapi ws2_32 rpcrt4 winmm wininet ole32 shlwapi
    )
endif()
```

### 4.2 Linux/BSD

```cmake
if(UNIX AND NOT APPLE)
    add_definitions(-DLINUX=1 -D_LINUX=1 -DPOSIX=1)
    find_package(Threads REQUIRED)
    target_link_libraries(${PROJECT} PRIVATE Threads::Threads dl)
endif()
```

### 4.3 macOS

```cmake
if(APPLE)
    add_definitions(-DOSX=1 -D_OSX=1)
    target_link_libraries(${PROJECT} PRIVATE
        "-framework Cocoa"
        "-framework OpenGL"
        "-framework IOKit"
    )
endif()
```

---

## 5. 依赖检测策略

### 5.1 使用 CMake Find模块

```cmake
find_package(SDL2 QUIET)
if(SDL2_FOUND)
    add_definitions(-DUSE_SDL)
    target_include_directories(${PROJECT} PRIVATE ${SDL2_INCLUDE_DIRS})
    target_link_libraries(${PROJECT} PRIVATE ${SDL2_LIBRARIES})
endif()
```

### 5.2 自定义 Find 模块

对于 CMake 未提供的库，创建自定义 Find 模块：
- `cmake/FindFreetype.cmake`
- `cmake/FindFontconfig.cmake`
- `cmake/FindOpenAL.cmake`
- `cmake/FindOpus.cmake`

### 5.3 pkg_check_modules (Unix)

```cmake
find_package(PkgConfig QUIET)
pkg_check_modules(PNG REQUIRED libpng)
pkg_check_modules(JPEG REQUIRED libjpeg)
pkg_check_modules(CURL REQUIRED libcurl)
```

---

## 6. 构建选项映射

| Waf 选项 | CMake 选项 | 说明 |
|---------|-----------|------|
| `-4/--32bits` | `-DENABLE_32BIT=ON` | 32位构建 |
| `-d/--dedicated` | `-DBUILD_DEDICATED=ON` | 专用服务器 |
| `--tests` | `-DBUILD_TESTS=ON` | 单元测试 |
| `-D/--debug-engine` | `-DDEBUG_BUILD=ON` | 调试构建 |
| `--use-sdl` | `-DUSE_SDL=ON` | SDL 支持 |
| `--use-togl` | `-DUSE_TOGL=ON` | ToGL 支持 |
| `--togles` | `-DUSE_TOGLES=ON` | ToGL ES |
| `--enable-opus` | `-DENABLE_OPUS=ON` | Opus 编码器 |
| `--sanitize` | `-DSANITIZER=<type>` |  sanitizer |

---

## 7. 已知挑战和解决方案

### 7.1 源文件条件编译

Waf 使用 `[$WIN32]`, `[$POSIX]` 等条件包含源文件。

**解决方案**: 使用 CMake 的 generator expressions

```cmake
set(PLATFORM_SOURCES
    win32_impl.cpp
    $<$<BOOL:${UNIX}>:posix_impl.cpp>
)
```

### 7.2 预编译头文件

Waf 使用预编译头 (pch)。

**解决方案**: CMake 原生支持

```cmake
target_precompile_headers(${PROJECT} PRIVATE
    "<${CMAKE_SOURCE_DIR}/public/tier0/pch_tier0.h>"
)
```

### 7.3 安装路径

**解决方案**: 使用 GNUInstallDirs

```cmake
include(GNUInstallDirs)
install(TARGETS ${PROJECT} DESTINATION ${CMAKE_INSTALL_LIBDIR})
```

---

## 8. 实施建议

1. **增量迁移**: 从核心库 (tier0-tier3) 开始，逐步迁移到更高级别的组件
2. **保持兼容**: 暂时保留 wscript，验证 CMake 构建后再考虑移除
3. **测试驱动**: 每个子项目迁移后进行构建测试
4. **自动化**: 编写脚本自动转换部分 wscript 配置到 CMake

---

## 9. 验证步骤

1. 配置: `cmake -B build -DBUILD_DEDICATED=OFF`
2. 构建: `cmake --build build`
3. 测试: `ctest --test-dir build`

---

*文档版本: 1.0*
*最后更新: 2026-03-18*
