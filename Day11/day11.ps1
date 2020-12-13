#$input11 = get-content .\Day11\part11.txt
$input11 = get-content .\Day11\test11.txt

#$input11


class seatingarea {

    [System.Collections.Specialized.OrderedDictionary]$seats = @{}
    [System.Collections.Specialized.OrderedDictionary]$tempseats = @{}
    [int64]$chairs
    [int64]$d
    [int64]$w
    [string]$lastcord
    [int64]$total

    build($input11) {

        $width = $input11[0].Length
        $depth = $input11.count
        $this.chairs = $width*$depth
        $this.d = $depth
        $this.w = $width
        #[char[]]$chars = $input11 | %{$_ -as [char[]]}
        for ($i = 0; $i -lt $depth; $i++) {
            [char[]]$chars = $input11[$i] | %{$_ -as [char[]]}
            for ($x = 0; $x -lt $width; $x++) {
            
                $this.seats.add(("$i,$x"),$chars[($x)])

            }
        }
    }

    populate() {
        #first
        for ($i = 0; $i -lt $this.d; $i++) {
            
            for ($x = 0; $x -lt $this.w; $x++) {
                
                if ($this.seats["$i,$x"] -eq "L") {$this.seats["$i,$x"] = '#'}
                if (($i -eq ($this.d-1) -and ($x -eq ($this.w-1)))) {$this.lastcord = "$i,$x"}
            }
        }
    }

    popluaterules ($depth,$width,$memo=@{},$n){
        
        
        if (($depth -gt $this.d) -and ($width -gt $this.d)) {
            $this.total++
        }
            $currentcords = "$depth,$width"
            #if ($memo.Contains($currentcords)) {return}
            #$memo.add($n,"$depth,$width")

            #$depth,$width = $cors -split ","
            #$depth,$width
            
            [int64]$hits = 0


          
            for ($i = $depth-1; $i -lt $depth+2; $i++) {
                
                for ($x = $width-1; $x -lt $width+2; $x++) {
                            
                            switch ($this.seats["$i,$x"]) {
                                '#' { $hits++ }
                                #'.' {  }
                                #'L' {  }
                                Default {}
                            }
                }
            }

            if ($this.seats["$currentcords"] -ne ".") {

            if ($hits -ge 4){$this.seats["$currentcords"] = "L"}
            elseif ($hits -eq 0) {$this.seats["$currentcords"] = "#"}

            }
            
            if (($width+1) -lt ($this.w)) {
                $this.popluaterules($depth,($width+1),$memo,($n+1))
            }
            if (($width -eq ($this.w-1)) -and (($depth+1) -lt $this.d-1)) {
                $this.popluaterules(($depth+1),0,$memo,($n+1))
            }
            
            #end
            #if ($currentcords -eq $this.lastcord) {
            #    return
            #}
      


    }
    draw () {
        for ($i = 0; $i -lt $this.d; $i++) {
            
            for ($x = 0; $x -lt $this.w; $x++) {
            
                write-host "$($this.seats["$i,$x"])" -NoNewline

            }
            write-host ""
        }
    }

}


$seating = [seatingarea]::new()
$seating.build($input11)
$seating.populate()
$seating.popluaterules(0,0,@{},0)

$seating.draw()
$seating.seats

test -depth 0 -width 0 -array $seating.seats

function test ($depth,$width,$array) {

    $currentcords = "$depth,$width"
    write-debug $currentcords
    [int64]$hits = 0
    for ($i = $depth-1; $i -lt $depth+2; $i++) {
        for ($x = $width-1; $x -lt $width+2; $x++) {
                    write-debug "$i,$x"
                    switch ($array["$i,$x"]) {
                        '#' { $hits++ }
                        #'.' {  }
                        #'L' {  }
                        Default {}
                    }
        }
    }
    write-debug $hits
    if ($hits -ge 4){$array["$currentcords"] = "L"}
    elseif ($hits -eq 0) {$array["$currentcords"] = "#"}

    
    if (($width+1) -lt 10) {
        write-debug "increas width"
        test -depth $depth -width ($width+1) -array $array
    
    }
    if ((($width) -eq (10-1)) -and (($depth+1) -lt 10)) {
        write-debug "increase depth"
        test -depth ($depth+1) -width 0 -array $array
    }
    #return ,$array
}

$width = 9