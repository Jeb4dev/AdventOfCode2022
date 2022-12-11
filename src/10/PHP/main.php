<?php

// Solution for Advent of Code 2022 day 10.

$lines = file('input.txt');
$clock = 0;
$register = 1;
$signalStrength = 0;
$CRT = array();
$debug = false;

function writeCRT() {
    global $register, $CRT;

    if ($register -1 <= count($CRT) % 40 and $register +1 >= count($CRT) % 40) {
        $CRT[] = "█";
    } else {
        $CRT[] = " ";
    }
}

function readCRT()
{
    global $CRT;
    $index = 0;

    foreach ($CRT as $pixel) {
        if ($index % 40 == 0) echo "\n";
        echo $pixel;
        $index++;

    }
}

function checkSignal()
{
    global $clock, $register, $signalStrength, $debug;

    $signal = array(20, 60, 100, 140, 180, 220);

    if (in_array($clock, $signal)) {
        $signalStrength += $register * $clock;
        if ($debug)
            echo "During the ", $clock, "th cycle, register X has the value ", $register, ", so the signal strength is ", $clock, " * ", $register, " = ", $register * $clock, ".\n";
    }
}

function processCycle() {
    writeCRT();
    checkSignal();
}

function main()
{
    // I don't know if this is PHP way of coding. Never coded on PHP before. But seems very nice language.
    global $clock, $register, $signalStrength, $lines, $CRT;

    foreach ($lines as $line) {

        $clock++;
        processCycle();

        // Split command by space
        $args = explode(" ", $line);

        // If args list have two objects ( it is addx command )
        if (count($args) == 2) {

            $clock++;
            processCycle();

            // After 2 clock cycles increment register value by given value
            $register += $args[1];
        }

    }

    echo "Part I: ", $signalStrength;
    echo "\n";
    echo "Part II: ";
    readCRT();
}

main();

?>
