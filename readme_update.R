#!/usr/bin/env Rscript



args <- commandArgs(trailingOnly = TRUE)


# 参数验证
if (length(args) < 2) {
  stop("Usage: Rscript generate_packages_md.R <input.csv> <output.md>", call. = FALSE)
}
packages_csv <- args[1]
output_file <- args[2]

pkg_data <-as.data.frame(installed.packages())


write.csv(pkg_data[,c('Package', 'Version')], packages_csv, row.names=FALSE,quote=FALSE)




# 修改后的Markdown生成函数
generate_table_with_citations <- function(pkg_data) {
  # 获取引用信息
  citations <- sapply(pkg_data$Package, function(p) {
    tryCatch({
      format(citation(p),style='text')
    }, error = function(e) "Citation not available")
  })
  
  # 生成带引用的表格
  c(
    "## Installed Packages with Citations\n",
    "\n| Package | Version |  ", 
    "|---------|---------|",
    sprintf("| %s | %s |", pkg_data$Package, pkg_data$Version),
    "\n",
    "## Citations\n",
    "\n",
    sprintf("- %s\n",citations),
    "\n"
  )
}

# 修改文件写入部分
writeLines(generate_table_with_citations(pkg_data), output_file)



