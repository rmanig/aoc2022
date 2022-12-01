import java.io.BufferedReader

fun main() {
    val inputStream = object {}.javaClass.getResourceAsStream("day01/input.txt")!!
    val lines = inputStream.bufferedReader().use(BufferedReader::readText)
    val caloriesByElves = lines.split("\n\n")
            .map { line -> line.split("\n")
                    .fold(0) { a, b -> b.toInt() + a }
            }.sortedDescending()
    println(caloriesByElves.first())

    val topThreeElvesSum = caloriesByElves.take(3).fold(0) { t, u -> t + u }
    println(topThreeElvesSum)
}
