import java.io.BufferedReader
import java.io.File

fun main() {
    val inputStream = File("input.txt")
    val lines = inputStream.bufferedReader().use(BufferedReader::readText)
    val caloriesByElves = lines.split("\n\n")
            .map { line -> line.split("\n")
                    .fold(0) { a, b -> b.toInt() + a }
            }.sortedDescending()
    println(caloriesByElves.first())

    val topThreeElvesSum = caloriesByElves.take(3).fold(0) { t, u -> t + u }
    println(topThreeElvesSum)
}
