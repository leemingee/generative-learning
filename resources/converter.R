#-------------------------------
# bidirectional MD to HTML to MD converter for Google Bookmark
library(rvest)
library(dplyr)
library(stringr)
library(purrr)

# HTML to Markdown Lists --------------------------------------------------
bookmark_page = read_html("./resources/bookmarks_2018_10_8.html")
bookmark_page

dir_nodes = bookmark_page %>% html_nodes(xpath = "//dl/dt/h3[@personal_toolbar_folder='true']/../../dl/dl") 
dir_names = dir_nodes %>% html_nodes(xpath = "../dt/h3") %>% html_text()

# dir_nodes[1] %>% html_nodes(xpath = "./dt") %>% html_structure()
# dir_nodes[1] %>% html_nodes(xpath = "./dt/a") %>% html_name()
# 
# decode_nodes = function(node){
#     
# }

#===========
bookmark_page2 = readLines("./resources/bookmarks_2018_10_8.html")
h3_exist = grepl(pattern = "<DT><H3", x = bookmark_page2)
href_exist = grepl(pattern = "<DT><A", x = bookmark_page2)

df = data.frame(page = bookmark_page2)

df %>% 
    mutate(content = case_when(
        all(!h3_exist, !href_exist) ~ NA_character_,
        h3_exist ~ gsub(pattern = ".*H3.*>(.*)</H3>.*", 
                        replacement = "\\1",
                        x = page),
        href_exist ~ gsub(pattern = "^.*<DT><A HREF=\"([^ ]*)\".*>(.*)</A>.*$",
                          replacement = "[\\2](\\1)",
                          x = page)
    )) %>% 
    filter(content != "书签栏") %>% 
    filter(!is.na(content)) %>% 
    mutate(isLink = grepl(pattern = "\\[*\\]\\(.*\\)", content)) -> res

map2(res$content, res$isLink, function(x, y){
    print(x, y)
})

