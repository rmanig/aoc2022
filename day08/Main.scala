import scala.collection.mutable
import scala.collection.mutable.*
import scala.io.Source

object Main {

    def main(args: Array[String]): Unit = {
        val bufferedSource = Source.fromResource("input.txt")
        val forest: ArrayBuffer[ArrayBuffer[Int]] = ArrayBuffer()
        for (line <- bufferedSource.getLines) {
            val treeLine = line.toCharArray.map(it => it.asDigit).to(ArrayBuffer)
            forest.addOne(treeLine)
        }

        var visibleTrees = 0
        var highestScenicScore = 0
        forest.zipWithIndex.foreach { (horizontal, y) =>
            horizontal.zipWithIndex.foreach { (tree, x) =>
                val west = horizontal.slice(0, x)
                val east = horizontal.slice(x + 1, horizontal.size)
                val vertical = forest.map(horizontal => horizontal(x))
                val north = vertical.slice(0, y)
                val south = vertical.slice(y + 1, vertical.size)
                val isVisible = ArrayBuffer(west, east, south, north).exists(direction => isVisibleTree(tree, direction))
                val scenicScore = ArrayBuffer(west.reverse, east, south, north.reverse).map(direction => getScenicScore(tree, direction)).product
                if (isVisible) visibleTrees = visibleTrees + 1
                if (scenicScore > highestScenicScore) highestScenicScore = scenicScore
            }
        }

        println("the solution for part one is: " + visibleTrees)
        println("the solution for part two is: " + highestScenicScore)

        bufferedSource.close
    }

    def isVisibleTree(height: Int, treeLine: ArrayBuffer[Int]): Boolean = {
        treeLine.isEmpty || treeLine.forall(tree => tree < height)
    }

    def getScenicScore(height: Int, treeLine: ArrayBuffer[Int]): Int = {
        if (treeLine.isEmpty) 0
        else {
            val smallerTrees = treeLine.takeWhile(tree => tree < height).map(_ => 1).sum
            if (smallerTrees < treeLine.size) smallerTrees + 1 else smallerTrees
        }
    }

}