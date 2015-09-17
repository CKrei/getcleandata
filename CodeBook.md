---
title: "CodeBook"
author: "Christoph Kreibich"
date: "Thursday, September 17, 2015"
output: html_document
---

This markdown document produces the codebook that describes the variables in the resultData.txt.
There are two keys:
- Outcome: The activity.
- Subject: The individual performing the activity.

All remaining columns are straightforward transformations and consist of the mean value grouped by the two key variables.
A more detailled description can be found in the original files features.txt and features_info.txt.

```{r}
require(dplyr)
data <- read.table("resultData.txt", header=TRUE) %>%
          tbl_df()
code <- tbl_df(as.data.frame(matrix(NA, ncol=1, nrow=length(names(data)))))
names(code) <- c("Variable")
code$Variable <- names(data)
code
```

