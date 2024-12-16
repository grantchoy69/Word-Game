library("igraph")


wordsFrame <- read.csv("D:/Word Game/wordsFrame.csv", header=TRUE)
wordsFrame = wordsFrame[-1,]
wordsFrame = wordsFrame[!duplicated(wordsFrame),]

tooShort = nchar(wordsFrame$X3) == (nchar(wordsFrame$X1) + nchar(wordsFrame$X2))
wordsFrame = wordsFrame[tooShort,]

wordsList = data.frame(unique(c(wordsFrame$X1, wordsFrame$X2)))
wordCount = nrow(wordsList)
for(i in 1:wordCount){
  wordsList[i,2] = sum(wordsFrame$X1 == wordsList[i,1])
  wordsList[i,3] = sum(wordsFrame$X2 == wordsList[i,1])
}

wordsList = wordsList[wordsList$V3 > 1,]
wordsList = wordsList[wordsList$V2 > 1,]
freqWords = wordsFrame[wordsFrame$X1 %in% wordsList$unique.c.wordsFrame.X1..wordsFrame.X2..,]
fullMap = matrix(nrow = nrow(wordsList), ncol = nrow(wordsList))
testMat = data.frame(matrix(nrow = nrow(wordsList), ncol = nrow(wordsList)))

for(i in 1:nrow(wordsList)){
  for(j in 1:nrow(wordsList)){
    fullMap[i,j] = sum((freqWords$X1 == wordsList[i,1] & freqWords$X2 == wordsList[j,1])) > 0
    if(fullMap[i,j]){
      testMat[i,j] = paste(wordsList[i,1], wordsList[j,1])
    }
  }
}


puzzle = data.frame(matrix(nrow = 3, ncol =3))
steps = matrix(c(1, 3, 7, 2, 4, 8, 5, 6, 9), nrow = 3)
checkSteps = cbind(c(1,1,2,3,2,5,4,3,4,7,6,8),c(2,3,4,4,5,6,6,7,8,8,9,9))
parentMap = cbind(c(0,1,1,1,1,2,2,3,3), c(0,1,1,2,2,2,1,1,2))


puzzle[1,1] = curWord

testPuzzle = puzzle
testPuzzle[2,1] = "head"
testPuzzle[1,2] = "master"


checker = function(puzzle, stop){
  checkSingleNode = function(parent,child){
    parIndex = which(wordsList[,1] == parent)
    childIndex  = which(wordsList[,1] == child)
    return(fullMap[parIndex,childIndex])
  }
  allGood = TRUE
  j = 1
  while((j < stop)){
    parNode = puzzle[steps == checkSteps[j,1]]
    chiNode = puzzle[steps == checkSteps[j,2]]
    print(parNode)
    print(chiNode)
    allGood = checkSingleNode(parNode, chiNode)
    print(allGood)
    j = j+1
    }
  return(allGood)
}
checker(testPuzzle, 3)




generator = function(curLoc, puz){
  if(curLoc == 10){
    return(puz)
  }
  curParent = puz[parentMap[curLoc,1],parentMap[curLoc,2]]
  subsetter = freqWords$X1 == curParent
  curBacks = freqWords[subsetter,3]
  
  canContine = TRUE
  j = 1
  while(canContine){
    nextWord = freqWords[freqWords$X1 == curBacks[j],3]
    if((sum(!is.na(nextWord)) == 0)){
      j = j + 1
    } else {
      canContine = FALSE
    }
    if(j == length(curBacks)){
      canContine = FALSE
    }
  }
  puz[steps == curLoc] = curBacks[j]
  print(puz)
  generator(curLoc + 1, puz)
}

generator(2, puz = puzzle)

#


# 
# curBacks = wordsFrame[wordsFrame$X1 == curWord,]
# nextWords = wordsFrame[wordsFrame$X1 %in% curBacks$X2,]
# moreOne = data.frame(table(nextWords$X2), stringsAsFactors=FALSE)
# moreOne = moreOne[moreOne[,2]>=2,1] # this needs to have at least 1 value
# 
# layerTwo = nextWords[nextWords$X2 %in% moreOne,] # this is the only item that needs intersections
# interSecSuff = wordsFrame[wordsFrame$X1 %in% layerTwo$X2, ]
# 
# nextSuff = wordsFrame[wordsFrame$X1 %in% layerTwo$X1,]
# allPossNext = wordsFrame[wordsFrame$X1 %in% nextSuff$X2,]
# layerThree = allPossNext$X2
# layerThreeSuff = wordsFrame[wordsFrame$X1 %in% layerThree,]
# intersect(interSecSuff$X2, layerThreeSuff$X2)
# 
# moreTwo = data.frame(table(nextSuff$X2), stringsAsFactors = FALSE)
# 
# 
# moreTwo = moreTwo[moreTwo[,2] >= 2,1]
# nextSuff = nextSuff[nextSuff$X2 %in% moreTwo,]
# wordsFrame[wordsFrame$X1 %in% moreTwo,]
# 
# # 
# 







