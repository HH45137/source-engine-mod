.\waf.bat configure -T release --disable-warns --prefix=""

.\waf.bat build

.\waf.bat install --destdir="I:\MyGames\HL2"




# 配置
cmake -B build -DBUILD_TESTS=OFF -DBUILD_DEDICATED=OFF

# 构建
cmake --build build
