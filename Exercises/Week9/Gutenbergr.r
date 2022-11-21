# Read in Project Gutenberg Book using gutenbergr
# Find plain text URL, plug into readLines
book_lines <- readLines("https://www.gutenberg.org/cache/epub/17192/pg17192.txt") #Book: The Raven by Edgar Allan Poe

# Transform into a dataframe
book_data <- data.frame(line=1:length(book_lines), text=book_lines)
