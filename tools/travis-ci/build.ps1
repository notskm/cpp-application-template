conan install .. --build missing -s build_type=$env:BUILD_TYPE -pr default -pr ../tools/conan/build_tools -g virtualbuildenv

# Conan's virtualenv scripts set Powershell's prompt.
# There's currently a bug where running multiple activate*.ps1 scripts causes an
# infinite loop in the prompt function. Removing the lines where the prompt is
# set fixes the issue.
# https://github.com/conan-io/conan/issues/5535
Get-ChildItem ./*activate*.ps1 | ForEach-Object {
    $content = (get-content -Path $_ | Select-String -Pattern '_old_conan_prompt' -NotMatch)
    Set-Content -Path $_ -Value $content
}

./activate_build.ps1
./activate.ps1

(Get-Command cmake).Source
cmake --version

cmake .. -GNinja -DCMAKE_BUILD_TYPE=$env:BUILD_TYPE -DBUILD_TESTS=ON
cmake --build . --config $env:BUILD_TYPE
ctest --output-on-failure -C $env:BUILD_TYPE
