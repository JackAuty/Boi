\name{P_hist}
\alias{P_hist}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
A Capitalized Title (ideally limited to 65 characters)
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
P_hist(df, column)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{df}{
%%     ~~Describe \code{df} here~~
}
  \item{column}{
%%     ~~Describe \code{column} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or standard data sets, see data().

## The function is currently defined as
function (df, column) 
{
    if (is.data.frame(df)) {
        print("dataframe provided")
        df <- as.data.frame(df[, column])
        colnames(df) <- "P_value"
    }
    if (missing(column)) {
        print("vector provided")
        df <- data.frame(df)
        colnames(df) <- "P_value"
    }
    bins <- seq(0, 1, by = 0.025)
    significant_count <- sum(df$P_value < 0.05)
    df$P_value_label <- factor(df$P_value < 0.05, levels = c(TRUE, 
        FALSE))
    hist_data <- ggplot(df, aes(x = P_value)) + geom_histogram(breaks = bins, 
        aes(y = ..count..), color = "black", stat = "bin")
    counts <- ggplot_build(hist_data)$data[[1]]$count
    ylim <- max(counts)
    plot <- ggplot(df, aes(x = P_value, fill = P_value_label)) + 
        geom_histogram(breaks = bins) + scale_fill_manual(values = c(`TRUE` = "#99009999", 
        `FALSE` = "#00999999"), labels = c(`TRUE` = "Significant", 
        `FALSE` = "Non-Significant"), ) + scale_x_continuous(expand = c(0, 
        0), limits = c(0, 1)) + scale_y_continuous(expand = c(0, 
        0), limits = c(0, 1.2 * ylim)) + labs(x = "P value", 
        y = "Count") + annotation_custom(grob = textGrob(paste0("Count of significant p-values: ", 
        significant_count), gp = gpar(fontsize = 10)), xmin = 0, 
        xmax = 1, ymin = -0.4 * ylim, ymax = -0.4 * ylim) + theme_classic() + 
        theme(legend.position = "bottom", legend.background = element_rect(fill = "transparent", 
            color = NA), legend.title = element_blank(), legend.text = element_text(size = 14, 
            face = "bold"), plot.margin = margin(c(10, 10, 30, 
            10))) + coord_cartesian(clip = "off")
    return(plot)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
