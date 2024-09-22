#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <folder_name>"
    exit 1
fi

folder_name="$1"
folder_path="src/$folder_name"

source_cmake_dir="src/template"
source_cmake_file="$source_cmake_dir/CMakeLists.txt"
source_cc_file="$source_cmake_dir/template.cc"
source_h_file="$source_cmake_dir/template.h"

if [ ! -f "$source_cmake_file" ]; then
    echo "Source CMakeLists.txt file does not exist: $source_cmake_file"
    exit 1
fi

if [ ! -d "$folder_path" ]; then
    mkdir -p "$folder_path"
    echo "Created directory: $folder_path"

    file_name=$(basename "$folder_name")

    header_file="$folder_path/$file_name.h"
    if [ -f "$source_h_file" ]; then
        cp "$source_h_file" "$header_file"
        echo "Copied $source_h_file to $header_file"
    else
        echo "Source .h file does not exist: $source_h_file"
        exit 1
    fi

    source_file="$folder_path/$file_name.cc"
    if [ -f "$source_cc_file" ]; then
        cp "$source_cc_file" "$source_file"
        echo "Copied $source_cc_file to $source_file"

        include_line="#include \"$file_name.h\""
        
        if ! grep -q "$include_line" "$source_file"; then
            sed -i "/^#include/s/^/#include \"$file_name.h\"\n/" "$source_file"
            echo "Added '#include \"$file_name.h\"' in $source_file"
        else
            echo "'#include \"$file_name.h\"' already exists in $source_file"
        fi
    else
        echo "Source .cc file does not exist: $source_cc_file"
        exit 1
    fi
else
    echo "Folder already exists: $folder_path"
fi

cp "$source_cmake_file" "$folder_path/CMakeLists.txt"
echo "CMakeLists.txt has been copied to the $folder_path directory"
