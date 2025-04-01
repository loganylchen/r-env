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

# 新增：去重引用生成函数
generate_unique_citations <- function(packages) {
  unique_pkgs <- unique(packages)  # 先去重包名
  cites <- lapply(unique_pkgs, function(p) {
    tryCatch({
      cit <- citation(p)
      # 生成唯一标识（基于引用标题和年份）
      id <- paste(attr(cit, "title"), attr(cit, "year"), sep = "|")
      list(id = id, text = format(cit, style = "text"))
    }, error = function(e) {
      list(id = p, text = paste("No formal citation available for package", p))
    })
  })
  
  # 基于ID去重
  unique_ids <- !duplicated(sapply(cites, `[[`, "id"))
  cites <- cites[unique_ids]
  
  # 生成格式化的引用内容
  c(
    "# R Package Citations\n\n",
    sapply(cites, function(x) {
      pkg_name <- ifelse(grepl("^No formal citation", x$text), 
                        sub(".*for package (\\w+).*", "\\1", x$text),
                        attr(citation(sub("\\|.*", "", x$id)), "package")$pkg)
      paste("##", pkg_name, "\n\n", x$text, "\n")
    })
  )
}

# 写入文件


# 在文件写入部分添加引用生成（修改这部分）
if (length(args) > 2) {
    writeLines(md_content, output_file)
  writeLines(generate_unique_citations(pkg_data$Package), args[3]) 
}else{
    writeLines(c(md_content,generate_unique_citations(pkg_data$Package)), output_file)
}

