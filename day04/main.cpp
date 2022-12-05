#include <iostream>
#include <fstream>
#include <string>

int main(int argc, const char * argv[]) {
    std::ifstream infile("input.txt");
    std::string line;
    
    int sumContain = 0;
    int sumOverlap = 0;
    while (std::getline(infile, line))
    {
        std::string firstRange = line.substr(0, line.find(","));
        std::string secondRange = line.substr(line.find(",") + 1, line.length());
        
        int firstRangeStart = std::stoi(firstRange.substr(0, firstRange.find("-")));
        int firstRangeEnd = std::stoi(firstRange.substr(firstRange.find("-") + 1, firstRange.length()));
        
        int secondRangeStart = std::stoi(secondRange.substr(0, secondRange.find("-")));
        int secondRangeEnd = std::stoi(secondRange.substr(secondRange.find("-") + 1, secondRange.length()));
        
        if ((firstRangeStart >= secondRangeStart && firstRangeEnd <= secondRangeEnd)
            || (firstRangeStart <= secondRangeStart && firstRangeEnd >= secondRangeEnd)) {
            sumContain++;
        }
        
        if ((firstRangeStart <= secondRangeStart && firstRangeEnd >= secondRangeStart)
            || (secondRangeStart <= firstRangeStart && secondRangeEnd >= firstRangeStart)) {
            sumOverlap++;
        }
    }
    std::cout << "The sum of assignment pairs fully contain the other is: " << sumContain << "\n";
    std::cout << "The sum of assignment pairs overlap the other is: " << sumOverlap << "\n";
    return 0;
}
