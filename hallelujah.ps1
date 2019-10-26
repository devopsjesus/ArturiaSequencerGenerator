$path = Join-Path -Path $PSScriptRoot -ChildPath 'createScales.ps1'
. $path

$c = (New-Scale -RootChord 'c' -Octave 3 -TonicTriadArpeggio -AddHighOctave -DescendingArpeggio) -join ' '
$am = (New-Scale -RootChord 'a' -Minor -Octave 2 -TonicTriadArpeggio -AddHighOctave -DescendingArpeggio) -join ' '
$f = (New-Scale -RootChord 'f' -Octave 3 -TonicTriadArpeggio -AddHighOctave -DescendingArpeggio) -join ' '
$fhalf = (New-Scale -RootChord 'f' -Octave 3 -TonicTriadArpeggio) -join ' '
$g = (New-Scale -RootChord 'g' -Octave 3 -TonicTriadArpeggio -AddHighOctave -DescendingArpeggio) -join ' '
$ghalf = (New-Scale -RootChord 'g' -Octave 3 -TonicTriadArpeggio) -join ' '
$em = (New-Scale -RootChord 'e' -Minor -Octave 3 -TonicTriadArpeggio -AddHighOctave -DescendingArpeggio) -join ' '

$line1 = "$c $am $c $am"

$line2 = "$f $g $c $g"

$line3 = "$c $fhalf $ghalf $am $f"

$line4 = "$g $e $am"

$line5 = "$f $am $f $c $g $c"

"$intro $line1 $line2 $line3 $line4 $line5"

#$foo = "$intro $line1 $line2" $line3 $line4 $line5" -split ' '
#$foo[0..63] -join ' '