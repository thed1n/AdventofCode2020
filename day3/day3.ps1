$trees = Get-Content .\day3\part3.txt

$trees.Count
$trees = @"
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"@
$trees= ($trees -split '\n').trim()
#Flyttar träden eftersom mönstrerna upprepar sig så vandrar tillbaka med pekaren 
#.
#   .
#     .
#.
#   .
#      .
# .
#     .
#        .



$t = 0
[int32]$hit = 0
$slope = for ($i = 0; $i -lt $trees.Count; $i++) {
    [char[]]$row = $trees[$i]
    if ($row[$t] -eq '#') {$hit++;$row[$t]='X'}
    else {$row[$t] = 'O'}
    #write-host $t
    $t+=$r
    if ($t -ge $trees[0].Length) { $t = $t - $trees[0].Length}
    <#
    switch ($t) {
        ($trees[0].length-1) {$t=2;break}
        ($trees[0].length-2) {$t=1;break}
        ($trees[0].length-3) {$t=0;break}
        Default {$t=$t+3}
    }
    #>
    $row -as [string]
    #write-host $t
}

$hit

$slope


## PART 2


$p2 = "1,1","3,1","5,1","7,1","1,2"

[System.Collections.ArrayList]$treehits = @()
[System.Collections.ArrayList]$slopes = @()
$p2 | %{
    [int32]$r,[int32]$d = $_ -split ","

$t = 0
[int32]$hit = 0
$slope = for ($i = 0; $i -lt $trees.Count; $i=$i+$d) {

    #VID 2 ITERATIONER
  if ($d -eq 2) {
    [char[]]$row = $trees[$i]
    [char[]]$row2 = $trees[$i+1]

    if ($row[$t] -eq '#') {$hit++;$row[$t]='X'}
    else {$row[$t] = 'O'}

}

else {[char[]]$row = $trees[$i]}

if ($d -eq 1) {
 if ($row[$t] -eq '#') {$hit++;$row[$t]='X'}
 else {$row[$t] = 'O'}

}
    #write-host $t

    $t+=$r
    if ($t -ge $trees[0].Length) { $t = $t - $trees[0].Length}
<#
    if ($r -eq 1) {
        switch ($t) {
            ($trees[0].length-1) {$t=$r-1;break}
            Default {$t=$t+1}
    }
    }
    elseif ($r -eq 3) {
        switch ($t) {
            ($trees[0].length-1) {$t=2;break}
            ($trees[0].length-2) {$t=1;break}
            ($trees[0].length-3) {$t=0;break}
            Default {$t=$t+3}
        }
    }
    elseif ($r -eq 5) {
        switch ($t) {
            #{$trees[0].length-1} {$t=($r-$r);break}
            ($trees[0].length-1) {$t=4;break}
            ($trees[0].length-2) {$t=3;break}
            ($trees[0].length-3) {$t=2;break}
            ($trees[0].length-4) {$t=1;break}
            ($trees[0].length-5) {$t=0;break}
            Default {$t=$t+5}
        }
    }
    elseif ($r -eq 7) {
    switch ($t) {
        #{$trees[0].length-1} {$t=($r-$r);break}
        ($trees[0].length-1) {$t=6;break}
        ($trees[0].length-2) {$t=5;break}
        ($trees[0].length-3) {$t=4;break}
        ($trees[0].length-4) {$t=3;break}
        ($trees[0].length-5) {$t=2;break}
        ($trees[0].length-6) {$t=1;break}
        ($trees[0].length-7) {$t=0;break}
        Default {$t=$t+7}
    }
    }
    elseif (($r -eq 1) -and ($d -eq 2)){
        switch ($t) {
            ($trees[0].length-1) {$t=0;break}
            Default {$t=$t+$r}
    }
    }
    #>
    $row -as [string]
    if ($d -eq 2) {
        $row2 -as [string]
    }
    #write-host $t

}

$hit
[void]$treehits.add($hit)
[void]$slopes.add($slope)
}

$result = 1
for ($i = 0; $i -lt $treehits.Count; $i++) {
    $result = $treehits[$i] * $result
}
$result

#$slope

#$slopes[4]
