<?php
$squares = parseSquares();
$graph = buildGraph($squares);
$solutionOne = bfs($graph->start, $graph->adjacent)[$graph->end];
print("solution one  is " . $solutionOne . " steps.\n");
$solutionTwo = solutionTwo($graph);
print("solution two is " . $solutionTwo . " steps.\n");

function solutionTwo($graph) : int {
    $steps = array();
    foreach ($graph->elevations as $id => $elevation) {
        if ($elevation == "a") {
            $parents = bfs($id, $graph->adjacent);
            if (array_key_exists($graph->end, $parents)) {
                $steps[$id] = $parents[$graph->end];
            }
        }
    }
    asort($steps);
    return array_shift($steps);
}

function bfs($start, $adjacent): array {
    $current = $start;
    $visited[$current] = 0;
    $queue = array($current);
    while (count($queue) != 0) {
        $current = array_shift($queue);
        $nextSquares = $adjacent[$current];
        foreach ($nextSquares as $next) {
            if (!key_exists($next, $visited)) {
                $visited[$next] = $visited[$current] + 1;
                $queue[] = $next;
            }
        }
    }
    return $visited;
}

function isReachable($fromEle, $toEle): bool {
    return ord($toEle) <= ord($fromEle) + 1;
}

function getElevation($square) {
    if ($square == 'S') {
        return 'a';
    } else if ($square == 'E') {
        return 'z';
    } else {
        return $square;
    }
}

function buildGraph($squares): SquareGraph {
    $start = "";
    $end = "";
    $adjacent = array();
    $elevations = array();
    $height = count($squares);
    for ($y = 0; $y < $height; $y++) {
        $length = count($squares[$y]);
        for ($x = 0; $x < $length; $x++) {
            $id = sprintf('%02d%02d', $y, $x);
            if ($squares[$y][$x] == 'S') {
                $start = $id;
            } else if ($squares[$y][$x] == 'E') {
                $end = $id;
            }

            $elevation = getElevation($squares[$y][$x]);
            $elevations[$id] = $elevation;

            $adjacent[$id] = array();
            $up = $y - 1;
            if ($up >= 0 && isReachable($elevation, getElevation($squares[$up][$x]))) {
                $adjacent[$id][] = sprintf('%02d%02d', $up, $x);
            }
            $down = $y + 1;
            if ($down < $height && isReachable($elevation, getElevation($squares[$down][$x]))) {
                $adjacent[$id][] = sprintf('%02d%02d', $down, $x);
            }
            $left = $x - 1;
            if ($left >= 0 && isReachable($elevation, getElevation($squares[$y][$left]))) {
                $adjacent[$id][] = sprintf('%02d%02d', $y, $left);
            }
            $right = $x + 1;
            if ($right < $length && isReachable($elevation, getElevation($squares[$y][$right]))) {
                $adjacent[$id][] = sprintf('%02d%02d', $y, $right);
            }
        }
    }

    $graph = new SquareGraph();
    $graph->start = $start;
    $graph->end = $end;
    $graph->adjacent = $adjacent;
    $graph->elevations = $elevations;
    return $graph;
}

function parseSquares(): array {
    $squares = array();
    $handle = fopen("input.txt", "r");
    $lineIndex = 0;
    while (($line = fgets($handle)) !== false) {
        $chars = str_split(str_replace("\n", "", $line));
        $squares[$lineIndex] = $chars;
        $lineIndex++;
    }
    fclose($handle);
    return $squares;
}

class SquareGraph {

    public $start;
    public $end;
    public $adjacent;
    public $elevations;

}