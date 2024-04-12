# 1. 导入所需包
library(boot)
# 2. 读取数据
your_data <- read.csv("control.csv")  # 替换为您的文件路径
# 3. 创建结果存储文件夹
if (!dir.exists("bootstrap_results")) {
dir.create("bootstrap_results")
}
# 4. 定义Bootstrap函数
my_bootstrap <- function(data, indices, stepsize) {
sampled_data <- data[indices, ]
# 在这里可以执行您的Bootstrap操作，这里示例计算样本的均值
result <- mean(sampled_data)
# 输出样本列
sampled_columns <- colnames(data)[indices]
return(list(result = result, sampled_columns = sampled_columns))
}
# 5. 定义不同的stepsize
stepsize_values <- c(5,10, 15, 20, 25, 30)
# 6. 执行Bootstrap检验并保存结果
stepsize_folder <- file.path("bootstrap_results", as.character(stepsize))
if (!dir.exists(stepsize_folder)) {
dir.create(stepsize_folder, recursive = TRUE)
}
results <- numeric(1000)  # 存储每次Bootstrap的结果
for (i in 1:1000) {
result <- my_bootstrap(your_data, indices, stepsize)
# 保存结果到文件
result_file <- file.path(stepsize_folder, paste0("result_", i, ".txt"))
write.table(result$result, result_file)
