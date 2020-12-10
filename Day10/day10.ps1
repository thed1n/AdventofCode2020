$input10 = get-content .\Day10\part10.txt
$input10 = Get-Content .\Day10\test10.txt
$input10 = Get-Content .\Day10\test10_2.txt
#rated 3 higher than highest adapter (adapter+3)
#de kan leverera rätt ouput 3 under sitt värde.
#väggkontakt 0 jolts
class adapters {
[int32]$start = 0
[int32[]]$adapters = @(0)
[int32]$onejolt = 0
[int32]$threejolt = 1 # hantera datorn
[int32]$twojolt = 0
[int32]$fourjolt = 0
[int32]$fivejolt = 0
[int32]$sixjolt = 0
[int32]$compterjolt = 0
[int32]$chain = 0
adapters ([int32[]]$input) {
    
    $this.adapters += $input|sort
    
    $this.compterjolt = ($this.adapters[-1]+3)


}
calculate () {

    $failed = $false
    for ($i = 1; $i -lt $this.adapters.Count; $i++) {
        
        switch (($this.adapters[$i] - $this.adapters[$i-1])) {
            1 { $this.onejolt++;break }
            2 { $this.twojolt++;break }
            3 { $this.threejolt++;break }
            4 { $this.fourjolt++;break }
            5 { $this.fivejolt++;break }
            6 { $this.sixjolt++;break }
            Default {$failed = $true}
        }
        if ($failed -eq $true) {break} 
    }
    $this.chain = $i
}

calculatepart2 () {

    #Tribonnaci 
    
    for ($i = 1; $i -lt $this.adapters.Count; $i++) {
        $failed = $false
        for ($x = 0; $x -lt $this.adapters.Count; $x++) {

        switch (($this.adapters[$i] - $this.adapters[$i-1])) {
            1 { $this.onejolt++;break }
            2 { $this.twojolt++;break }
            3 { $this.threejolt++;break }
            4 { $this.fourjolt++;break }
            5 { $this.fivejolt++;break }
            6 { $this.sixjolt++;break }
            Default {$failed = $true}
        }
        if ($failed -eq $true) {break} 
    }
    $this.chain = $i
}
}

[int32[]] resultpart2 (){
    #combinations
    $low = ($this.adapters | where {$_ -lt 10}).Count
    $medium = ($this.adapters | where {$_ -ge 10 -and $_ -lt 100}).Count
    $middle = ($this.adapters | where {$_ -ge 100 -and $_ -lt 1000}).Count
    $last = ($this.adapters | where {$_ -ge 1000 -and $_ -lt 10000}).Count
    return @($low,$medium,$middle,$last)
    #10*100*1000/$this.chain
    #return [math]::Floor([math]::Sqrt(($this.onejolt*$this.twojolt*$this.threejolt)))
}

[int32] result () {
    return ($this.onejolt * $this.threejolt)
}
}

$jolt = [adapters]::new($input10)

#$jolt
$result = 
[math]::Pow(2,7)*[math]::pow(2,5)

$jolt.calculate()
$jolt.result()
$jolt.resultpart2()
$jolt.calculatepart2()



[math]::Pow((7*5))
[math]::Sqrt(70)

Tribonnaci 220

$jolt.adapters.count
function Tribonnaci($n) {

    if ($n -eq 0 -or $n -eq 1 -or $n -eq 2) {return 0}

    if ($n -eq 3) {return 1}
    else {
        #write-debug $n
        return ((Tribonnaci ($n -1))+(Tribonnaci ($n -2))+(Tribonnaci ($n -3)))
    }
}




for ($i = 0; $i -lt 11; $i++) {
    Tribonnaci $i} 
    
    $sum|Measure-Object -sum

    Tribonnaci 
    $n = 10