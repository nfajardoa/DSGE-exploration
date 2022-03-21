group <- list(out_1,out_2)
plot <- arrangeGrob(grobs = group, ncol = 1, nrow=2)
ggsave(file="prueba.png", plot, width = 10, height = 5, units = "in", dpi = 300, limitsize = FALSE)