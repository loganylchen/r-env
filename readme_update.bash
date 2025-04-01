#!/bin/bash


if [ ! -f "$1" ]; then
    echo "Error: CSV file $1 not found!"
    exit 1
fi

# 创建Markdown文件头
echo -e "## Installed Packages\n" > "$2"
echo -e "\n| Package | Version |" >> "$2"
echo -e "|---------|---------|\n" >> "$2"

# 处理CSV生成表格内容
awk -F, 'NR>1 {
    gsub(/^"|"$/, "", $1);
    gsub(/^"|"$/, "", $2);
    printf "| %s | %s |\n", $1, $2
}' "$1" >> "$2"

# 添加结尾换行符
echo "\n" >> "$2"