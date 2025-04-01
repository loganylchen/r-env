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


# 修改后的Markdown生成函数
generate_table_with_citations <- function(pkg_data) {
  # 获取引用信息
  citations <- sapply(pkg_data$Package, function(p) {
    tryCatch({
      format(citation(p),style='markdown')
    }, error = function(e) "Citation not available")
  })
  
  # 生成带引用的表格
  c(
    "## Installed Packages with Citations\n",
    "\n| Package | Version | Citation |", 
    "|---------|---------|----------|",
    sprintf("| %s | %s | %s |", pkg_data$Package, pkg_data$Version, citations),
    "\n"
  )
}

# 修改文件写入部分
writeLines(generate_table_with_citations(pkg_data), output_file)



