#! /usr/bin/perl
use strict;
use warnings;

my $solutionOne = watchMonkeys(20, 1, readInput());
print("the solution for part one is: " . $solutionOne . "\n");

my $solutionTwo = watchMonkeys(10000, 0, readInput());
print("the solution for part two is: " . $solutionTwo . "\n");

sub watchMonkeys {
    my $rounds = shift(@_);
    my $worry = shift(@_);
    my @monkeys = @_;

    my $modulo = $monkeys[0]->{'divisibleBy'};
    for (my $i = 1; $i < scalar(@monkeys); $i++) {
        $modulo *= $monkeys[$i]->{'divisibleBy'};
    }

    for (my $round = 1; $round <= $rounds; $round++) {
        for (my $i = 0; $i < scalar(@monkeys); $i++) {
            my $monkey = $monkeys[$i];
            my @items = @{$monkey->{'items'}};

            while (@items) {
                my $item = shift(@items);
                $monkey->{'inspected'}++;

                my $operand = $monkey->{'operand'};
                my $operator = $monkey->{'operator'};
                if ($monkey->{'operand'} eq "old") {
                    $operand = $item;
                }

                my $newItem;
                if ($operator eq "*") {
                    $newItem = $item * $operand;
                } elsif ($operator eq "+") {
                    $newItem = $item + $operand;
                }

                if ($worry == 1) {
                    $newItem = int($newItem / 3);
                } else {
                    $newItem = $newItem % $modulo;
                }

                my $nextMonkey = $monkey->{'testFalse'};
                if ($newItem % $monkey->{'divisibleBy'} == 0) {
                    $nextMonkey = $monkey->{'testTrue'};
                }

                push(@{$monkeys[$nextMonkey]->{'items'}}, $newItem);
            }
            $monkey->{'items'} = [];
        }
    }

    my @inspections;
    for (my $i = 0; $i < scalar(@monkeys); $i++) {
        push(@inspections, $monkeys[$i]->{'inspected'})
    }
    @inspections = sort { $b <=> $a } @inspections;
    return $inspections[0] * $inspections[1];
}

sub readInput {
    my $filename = 'input.txt';
    open(FH, '<', $filename) or die $!;
    my @monkeys = ();
    my %monkey;
    while(<FH>) {
        my $line = $_;

        if (index($line, "Monkey ") == 0) {
            %monkey = ();
            $monkey{'inspected'} = 0;

        } elsif (index($line, "  Starting items: ") == 0) {
            my $itemStr = substr($line, 18, length($line));
            $itemStr =~ s/[^0-9]/ /g;
            my @arr = split(' ', $itemStr);
            my @items;
            for (@arr) {
                push(@items, $_);
            }
            $monkey{'items'} = [@items];

        } elsif (index($line, "  Operation: new = old ") == 0) {
            my $str = substr($line, 23, length($line));
            my @arr = split(' ', $str);
            $monkey{'operator'} = $arr[0];
            $monkey{'operand'} = $arr[1];

        } elsif (index($line, "  Test: ") == 0) {
            my $str = substr($line, 8, length($line));
            my @arr = split(' ', $str);
            $monkey{'divisibleBy'} = $arr[2];

        } elsif (index($line, "    If true: ") == 0) {
            my @arr = split(' ', $line);
            $monkey{'testTrue'} = pop(@arr);

        } elsif (index($line, "    If false: ") == 0) {
            my @arr = split(' ', $line);
            $monkey{'testFalse'} = pop(@arr);
            push(@monkeys, { %monkey })
        }
    }
    close(FH);
    return @monkeys;
}