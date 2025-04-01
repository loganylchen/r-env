#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

# 参数验证
if (length(args) < 2) {
  stop("Usage: Rscript generate_packages_md.R <input.csv> <output.md>", call. = FALSE)
}

input_file <- args[1]
output_file <- args[2]

# 检查文件存在性
if (!file.exists(input_file)) {
  stop(paste("Error: Input file", input_file, "not found!"), call. = FALSE)
}

# 读取CSV文件（自动处理引号）
pkg_data <- read.csv(input_file, header = TRUE, stringsAsFactors = FALSE)

# 生成Markdown内容
md_content <- c(
  "## Installed Packages\n",
  "\n| Package | Version |", 
  "|---------|---------|",
  sprintf("| %s | %s |", pkg_data$Package, pkg_data$Version),
  "\n"
)

# 写入文件
writeLines(md_content, output_file)

