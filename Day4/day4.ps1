$inputtest = get-content .\day4\test.txt
$inputtest -split '\s{2,}'

$inputprod = get-content .\Day4\part4.txt
$inputtest = $inputprod | select -first 20
$pattern = '(?<ecl>ecl:\w+)|(?<pid>pid:\d+)|(?<eyr>eyr:\d+)|(?<byr>byr:\d+)|(?<iyr>iyr:\d+)|(?<hcl>hcl:#\w+)|(?<hgt>hgt:\d+\w{2})'
$pattern2 = '(?<ecl>ecl:\w+)|(?<pid>pid:\d+)|(?<eyr>eyr:\d+)|(?<byr>byr:\d+)|(?<iyr>iyr:\d+)|(?<hcl>hcl:#\w+)|(?<hgt>hgt:\d+\w{2})|(?<cid>cid:\d+)'


class Passport {
    #[uint32]$byr
    #[uint32]$iyr
    #[uint32]$eyr
    #[string]$hgt
    #[string]$hcl
    #[string]$ecl
    #[uint32]$passid
    #[uint32]$cid
    [hashtable]$passport = [hashtable]::new()
    [bool]$valid
    
    #Passport ($byr,$iyr,$eyr,$hgt,$hcl,$ecl,$passid,$cid) {
        
    #}
    Passport () {}

    CheckValid () {
        #"byr","iyr","eyr","hgt","hcl","ecl","pid","cid"
        $amount = 0
        "byr","iyr","eyr","hgt","hcl","ecl","pid","cid" | % {
        if ($this.passport.containskey($_) -eq $true) {$amount++}
        }

        #write-debug $amount
        if ($amount -eq 8) {$this.valid = $true} 
        elseif (($amount -eq 7) -and ($this.passport.containskey('cid') -eq $false)) {$this.valid = $true}
        else {$this.valid = $false}
        #if (($amount -eq 7) -and ($this.passport.containskey('cid') -eq $true)) {$this.valid = $true}

    }
    Addvalue ($key,$value) {
        $this.passport.add($key,$value)
    }
    ##Part2
    Addvaluevalidate ($key,$value) {
      
        switch ($key) {
            "byr" { if (($value -match '\d{4}') -and ($value -ge 1920 -and $value -le 2002)) {$this.passport.add($key,$value)}}
            "iyr" { if (($value -match '\d{4}') -and ($value -ge 2010 -and $value -le 2020)) {$this.passport.add($key,$value)}}
            "eyr" { if (($value -match '\d{4}') -and ($value -ge 2020 -and $value -le 2030)) {$this.passport.add($key,$value)}}
            "hgt" {
                
                 if (($value -match '\d+in') -and (($value.trimend('in')) -ge 59 -and ($value.trimend('in')) -le 76)) {$this.passport.add($key,$value)}
                 elseif (($value -match '\d+cm') -and (($value.trimend('cm')) -ge 150 -and ($value.trimend('com')) -le 193)) {$this.passport.add($key,$value)}
            }
            "hcl" { if ($value -match '#[a-f0-9]{6}') {$this.passport.add($key,$value)}}
            "ecl" { $pattern = "amb|blu|brn|gry|grn|hzl|oth"; if ($value -match $pattern) {$this.passport.add($key,$value)}}
            #^\d{9}$ <-- start and end anchors dvs, måste vara exakt 9
            "pid" {if (($value -match '^\d{9}$') -and ($value.length -eq 9)) {$this.passport.add($key,$value)}}
            "cid" {$this.passport.add($key,$value)}
            Default {}
        }

    }


}

$data = $inputprod | %{
    $_ -split '\s'  
}



$o = 0


[passport[]]$passports = for ($i = 0; $i -lt $data.Count; $i++) {
    
    if ($o -eq 0) {
        $passport = [passport]::new()
        $o = 1
    }

    if ($data[$i] -eq '') {
        #write-host "blank rad"
        $passport.checkvalid()
        $passport
        $o = 0
        continue
        #$i+=1
    }

    else {
    $key,$datavalue = $data[$i] -split ':'
    #write-host $key","$datavalue
    #part1
    #$passport.Addvalue($key,$datavalue)
    #part2
    $passport.Addvaluevalidate($key,$datavalue)
    }

    if ($i -eq $data.count-1) {
        $passport.checkvalid()
        $passport
    }
}

$i = 0
$passports| %{if ($_.valid -eq $true) {$i++}}
$i




