library(rvest)
library("jpeg")
library(readxl)
library(jsonlite)
library(readxl)
library(triebeard)
library(stringi)
library(rlist)

# myDumpPath = "D:/WikiDump/enwiktionary-latest-abstract.xml"
# wikiFull = read_html(myDumpPath)


downloadedWords <- read_excel("downloadedWords.xlsx")

testWords = tolower(as.vector(downloadedWords[nchar(downloadedWords$Word) >= 3,2])$Word)
backWords = stri_reverse(testWords)

testTrie = trie(testWords, testWords)
# 
# testCat = prefix_match(trie = testTrie, to_match = "cat")[[1]]
# testNap = prefix_match(trie = backTrie, to_match = stri_reverse("nap"))[[1]]
# intersect(testCat,testNap)
# 

numTests = length(testWords)
wordsToCheck = list()

for(i in 1:numTests){
  curWord = testWords[i]
  curMatchs = prefix_match(trie = testTrie, to_match = curWord)[[1]]
  if(length(curMatchs) > 1){
    wordsToCheck[[curWord]]= curMatchs
  }
}

frontWords = names(wordsToCheck)

wordsFrame = data.frame(matrix(ncol = 3))

for(k in 1:length(frontWords)){
  newWord = frontWords[k]
  curLen = nchar(newWord)
  
  needsMatch = as.vector(wordsToCheck[[newWord]])
  needsBack = stri_reverse(needsMatch)
  
  backTrie = trie(needsBack, needsMatch)
  
  curBack = testWords[nchar(testWords) > curLen]
  numBacks = length(curBack)
  print(newWord)
  for(j in 1:numBacks){
    possMatch = prefix_match(backTrie, stri_reverse(curBack[j]))[[1]]
    if(!is.na(possMatch[1])){
      print(possMatch)
      for(ballSack in possMatch){
        curRow = nrow(wordsFrame) + 1
        wordsFrame[curRow, 1] = newWord
        wordsFrame[curRow, 2] = curBack[j]
        wordsFrame[curRow, 3] = ballSack
      }
    }
  }
  if(k %% 100 == 0){
    write.csv(wordsFrame, "wordsFrame.csv")
  }
}

write.csv(wordsFrame, "wordsFrame.csv")








