#include <stdio.h>

enum result { win=6, lose=0, draw=3};
enum hand { rock=1, paper, scissor };

enum hand getHandByChar(char hand) {
    if (hand == 'X' || hand == 'A') {
        return rock;
    } else if (hand == 'Y' || hand == 'B') {
        return paper;
    } else {
        return scissor;
    }
}

enum result getStrategyByChar (char strategy) {
    return strategy == 'X' ? lose : strategy == 'Y' ? draw : win;
}

enum hand getHandByStrategy(enum result strategy, enum hand opponent) {
    if (strategy == lose) {
        return opponent == rock ? scissor : opponent == paper ? rock : paper;

    } else if (strategy == draw) {
        return opponent == rock ? rock : opponent == paper ? paper : scissor;

    } else {
        return opponent == rock ? paper : opponent == paper ? scissor : rock;
    }
}

enum result getGameScore(enum hand candidate, enum hand opponent) {
    if (candidate == rock) {
        return opponent == rock ? draw : opponent == paper ? lose : win;

    } else if (candidate == paper) {
        return opponent == rock ? win : opponent == paper ? draw : lose;

    } else {
        return opponent == rock ? lose : opponent == paper ? win : draw;
    }
}

int main(int argc, const char * argv[]) {
    int bufferLength = 255;
    char buffer[bufferLength];
    FILE* fp = fopen("input.txt", "r");

    int totalScorePart1 = 0;
    int totalScorePart2 = 0;

    while(fgets(buffer, bufferLength, fp)) {
        char opponent = buffer[0];
        char elve = buffer[2];

        enum hand opponentsHand = getHandByChar(opponent);

        // part 1
        enum hand elvesHand = getHandByChar(elve);
        totalScorePart1 += getGameScore(elvesHand, opponentsHand) + elvesHand;

        // part 2
        enum result strategy = getStrategyByChar(elve);
        enum hand guidedHand = getHandByStrategy(strategy, opponentsHand);
        totalScorePart2 += getGameScore(guidedHand, opponentsHand) + guidedHand;;
    }

    printf("the total score for part 1 is %d\n", totalScorePart1);
    printf("the total score for part 2 is %d\n", totalScorePart2);

    fclose(fp);
    return 0;
}
