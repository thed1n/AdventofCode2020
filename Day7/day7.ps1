$bagdata = get-content -Path .\Day7\part7.txt
$pattern3 = '^(?<bag>\w+ \w+)|(?<contain>\d \w+ \w+)'

## Region Functions
function get-keyvalue ($v) {

    $tempvalue = $bag.GetEnumerator().name | % {
        $key = $_
        $bag[$_] | ? {$_ -like "*$v*"} | %{
            $string = $_.ToString()
            $n = $string.substring(0, 1)
            $b = $string.substring(2)
        [pscustomobject]@{
            bag = $key
            #gold = $_
            n   = $n
            b   = $b
        }
        }
    }
     
    return ,$tempvalue

}

function get-key ($key) {

    $tempstring = $script:bag[$key] | % {
        $_.ToString().Substring(2)
    }
     
    return $tempstring

}

## End Region Functions


## Region Populate hashtable of bagdata

$bag = @{}
($bagdata | sls -Pattern $pattern3 -AllMatches).matches | % {
    
    if ($_.groups['bag'].value) {
        $tempbag = $_.groups['bag'].value
    }
    if ($_.groups['contain'].value) {
        
        $bag[$tempbag] += @($_.groups['contain'].value)
    }
}

## End Region bagdata

[uint32]$bags = 0
[hashtable]$uniquebags = @{}
$goldbags = $bag.GetEnumerator() | % {
    $key = $_.key
    $bag[$key] | ? { $_ -like "*shiny gold*" } | % {
        $string = $_.ToString()
        $n = $string.substring(0, 1)
        $b = $string.substring(2)
        [pscustomobject]@{
            bag = $key
            #gold = $_
            n   = $n
            b   = $b
        }
        $uniquebags[$key]++
    }
}

$bags += $goldbags.Count


$goldbags.bag | %{
    $v = $_
$bag.GetEnumerator().name | % {
    $key = $_
    $bag[$_] | ? {$_ -like "*$v*"} | %{
        $string = $_.ToString()
        $n = $string.substring(0, 1)
        $b = $string.substring(2)
    [pscustomobject]@{
        bag = $key
        #gold = $_
        n   = $n
        b   = $b
    }
    }
}}

$test = $goldbags.bag | %{get-keyvalue $_}

$test.bag | %{get-keyvalue $_}






$v = 'striped maroon'

for ($i = 0; $i -lt $goldbags.Count; $i++) {
    
    $tempkeys = get-key $goldbags[0].bag 

    for ($i = 0; $i -lt $tempkeys.Count; $i++) {
        get-key $tempkeys[$i]
    }

}







$i = 0
while ($null -eq $crap) {

    if ($bag.ContainsKey($goldbags[$i].bag)) {

        :inner while ($null -eq $crap2) {


            $bag[$goldbags[$i].bag] | % {
                $tempstring = $_.ToString().Substring(2)
                $uniquebags[$tempstring]++

                #fortsätter nedåt
                if ($bag.ContainsKey($tempstring)) {
                    $bag[$tempstring] | % {
                        $tempstring2 = $_.ToString().Substring(2)
                        $uniquebags[$tempstring2]++


                    }
                }
            }
            
            break :inner
        }
    }
    if ($i -lt $goldbags.count) { break }
    $i++
}

$uniquebags.count

$goldbags.bag | % {
    $uniquebags[$_]++
    get-key -key $_ | % {
        $uniquebags[$_]++
        get-key $_ | % {
            $uniquebags[$_]++
            get-key $_ | % {
                $uniquebags[$_]++
                get-key $_ | % {
                    $uniquebags[$_]++
                    get-key $_ | % {
                        $uniquebags[$_]++
                        get-key $_ | % {
                            $uniquebags[$_]++
                            get-key $_ | % {
                                $uniquebags[$_]++
                            }
                        }
                    }
                }
            }
        }

    }
}

$uniquebags.count

$bag['striped maroon']
$bag['vibrant tomato']
$bag['striped gold']
$bag['mirrored cyan']

