library(yyplot)
library(ggplot2)

term <- c("Lung Adenocarcinoma", "NSCLC", "SCLC")
pm   <- pubmed_trend(term, year=2001:2018)

plot(pm) + theme_bw()
#ggplot(pm, aes(x=year, y=number, color=TERM)) + geom_point() 

term2 <- "TCGA"
pm2   <- pubmed_trend(term2, year=2001:2018)
p2 <- ggplot(pm2, aes(x=year, y=number)) + geom_point() + geom_line() + theme_bw() + xlab("Year") + ylab("Number of Publication per Year")

ggsave("pubmed_trends_of_study_basedon_TCGA.pdf", plot=p2, width=6, height=4)

term3 <- "neoantigen"
pm3   <- pubmed_trend(term3, year=2001:2018)
p3 <- ggplot(pm3, aes(x=year, y=number)) + geom_point() + geom_line() + theme_bw() + xlab("Year") + ylab("Number of Publication per Year")
ggsave("pubmed_trends_of_neoantigen_study.pdf", plot=p3, width=6, height=4)