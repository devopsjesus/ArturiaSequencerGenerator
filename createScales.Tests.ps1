# Requires -Module Pester
#<function New-Scale
{
    param
    (
        [Parameter()]
        [string]
        $RootChord = 'c',

        [Parameter()]
        [ValidateRange(0,6)]
        [int]
        $Octave,

        [Parameter()]
        [switch]
        $Minor,

        [Parameter()]
        [switch]
        $TonicTriadArpeggio,
        
        [Parameter()]
        [switch]
        $DescendingArpeggio
    )

    $keys = @('c','c♯','d','e♭','e','f','f♯','g','a♭','a','b♭','b')

    if ($rootChord -notin $keys)
    {
        throw 'Not a valid root chord.'
    }

    $rootNote = ($Octave * 12) + ($keys.IndexOf($RootChord.ToLower()))

    if ($minor)
    {
        $scale = @('2','1','2','2','1','2','2')
    }
    else
    {
        $scale = @('2','2','1','2','2','2','1')
    }

    $return = @($rootNote)
    foreach ($step in $scale)
    {
        $nextKey = $return[-1] + $step
        $return += $nextKey
    }

    if ($TonicTriadArpeggio)
    {
        $return = @($return[0],$return[2],$return[4],$return[7])
    }

    if ($DescendingArpeggio)
    {
        $return = @($return, $return[2], $return[1])
    }

    return $return
}
#>

$path = Join-Path -Path $PSScriptRoot -ChildPath 'createScales.ps1'
. $path

Describe 'AudioModule' {
    
    Context 'New-Scale' {

        $keys = @('c','c♯','d','e♭','e','f','f♯','g','a♭','a','b♭','b')
        
        It 'Should return the proper Major scale' {
        
            $return = New-Scale -RootChord 'C' -Octave 3

            $return[0] | Should -Be 36
            $return[1] | Should -Be 38
            $return[2] | Should -Be 40
            $return[3] | Should -Be 41
            $return[4] | Should -Be 43
            $return[5] | Should -Be 45
            $return[6] | Should -Be 47
            $return[7] | Should -Be 48
        }

        It 'Should return the proper Minor scale' {
        
            $return = New-Scale -RootChord 'C' -Octave 3 -Minor

            $return[0] | Should -Be 36
            $return[1] | Should -Be 38
            $return[2] | Should -Be 39
            $return[3] | Should -Be 41
            $return[4] | Should -Be 43
            $return[5] | Should -Be 44
            $return[6] | Should -Be 46
            $return[7] | Should -Be 48
        }
        
        It 'Should return the proper Tonic Triad Arpeggio' {
        
            $return = New-Scale -RootChord 'C' -Octave 3 -TonicTriadArpeggio

            $return[0] | Should -Be 36
            $return[1] | Should -Be 40
            $return[2] | Should -Be 43
        }
        
        It 'Should return the proper Tonic Triad Arpeggio with High Octave note' {
        
            $return = New-Scale -RootChord 'G' -Octave 3 -TonicTriadArpeggio -AddHighOctave

            $return[0] | Should -Be (36 + 7)
            $return[1] | Should -Be (40 + 7)
            $return[2] | Should -Be (43 + 7)
            $return[3] | Should -Be (48 + 7)
        }
        
        It 'Should return the proper Descending Tonic Triad Arpeggio' {
        
            $return = New-Scale -RootChord 'G' -Octave 3 -TonicTriadArpeggio -DescendingArpeggio

            $return[0] | Should -Be (36 + 7)
            $return[1] | Should -Be (40 + 7)
            $return[2] | Should -Be (43 + 7)
            $return[3] | Should -Be (40 + 7)
        }
        
        It 'Should return the proper Descending Tonic Triad Arpeggio with High Octave note' {
        
            $return = New-Scale -RootChord 'b♭' -Octave 3 -TonicTriadArpeggio -DescendingArpeggio -AddHighOctave

            $return[0] | Should -Be (36 + 10)
            $return[1] | Should -Be (40 + 10)
            $return[2] | Should -Be (43 + 10)
            $return[3] | Should -Be (48 + 10)
            $return[4] | Should -Be (43 + 10)
            $return[5] | Should -Be (40 + 10)
        }
    }
}
