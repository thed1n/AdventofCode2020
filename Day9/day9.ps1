[double[]]$input9 = Get-Content -Path .\Day9\part9.txt
[double[]]$input9 = Get-Content -Path .\Day9\test9.txt


function get-potentialsum ($intarray,[double]$premble) {
    #[System.Collections.Generic.HashSet[double]]$temparray =@()
 
    $start = 0
    #$preamble = 41682220
    $stop = $startpointer = $intarray.count
    :outer while ($true) {
        $value = 0
        for ($i = $startpointer; $i -lt $array.Count; $i--) {
           
            $start = $i
            $value += $intarray[$i]
            
            if ($value -gt $preamble) {
                break
            }
            elseif ($value -eq $preamble) {
                break :outer
            }
   
        }


    }
    return @($start,$stop)
}

function get-contiguousset ($intarray) {

    [System.Collections.Generic.HashSet[double]]$temparray =@()
 
    foreach ($i in $intarray) {
        foreach ($subi in $intarray) {
            [void]$temparray.add(($i+$subi))
        }
    }
    return ,$temparray
}

#Preamble Length
$pl = 25

for ($i = $pl-1; $i -lt $input9.Count; $i++) {
    $preamble = get-potentialsum $input9[($i-$pl-1)..$i]
    
    if ($preamble.contains($input9[$i+1]) -eq $false) {
        $missing = $input9[$i+1]
        break
    }

}

$lessthanbug = $input9 | where {$_ -lt $missing}
get-potentialsum -intarray $lessthanbug -premble $missing

[PSCustomObject]@{
    Part1 = $Missing
}

