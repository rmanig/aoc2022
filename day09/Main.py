import math


def main():
    print("the solution for puzzle one is:  " + str(solve(2)))
    print("the solution for puzzle two is:  " + str(solve(10)))


def solve(knotCount):
    start = (0, 0)
    knots = []
    for knot in range(knotCount):
        knots.append(start)
    visited = {start}
    with open('input.txt') as file:
        for line in file:
            direction, distance = line.split()
            steps = doHeadSteps(knots[0], direction, int(distance))
            knots[0] = steps[-1]
            for knot in range(1, knotCount):
                steps = followSteps(knots[knot], steps)
                knots[knot] = steps[-1]
            visited.update(steps)
    return len(visited)


def followSteps(start, steps):
    tailSteps = [start]
    for idx, step in enumerate(steps):
        tx = tailSteps[-1][0]
        ty = tailSteps[-1][1]
        hx = step[0]
        hy = step[1]
        if calcDistance(tailSteps[-1], step) >= 2:
            if abs(tx - hx) >= 1:
                tx = tx + 1 if hx > tx else tx - 1
            if abs(ty - hy) >= 1:
                ty = ty + 1 if hy > ty else ty - 1
            tailSteps.append((tx, ty))
    return tailSteps


def calcDistance(one, another):
    return math.sqrt((one[0] - another[0]) ** 2 + (one[1] - another[1]) ** 2)


def doHeadSteps(pos, direction, distance):
    steps = [pos]
    for step in range(distance):
        steps.append(doOneStep(steps[-1], direction))
    return steps


def doOneStep(pos, direction):
    if direction == 'U':
        return pos[0], pos[1] + 1
    elif direction == 'D':
        return pos[0], pos[1] - 1
    elif direction == 'L':
        return pos[0] - 1, pos[1]
    elif direction == 'R':
        return pos[0] + 1, pos[1]


main()
