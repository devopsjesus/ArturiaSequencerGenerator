function New-Scale
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
        $AddHighOctave,
        
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
        $return = $return[0],$return[2],$return[4]
    }

    if ($AddHighOctave -and (-not $DescendingArpeggio))
    {
        $return += $return[0] + 12
    }
    elseif ($AddHighOctave -and $DescendingArpeggio)
    {
        $return += ($return[0] + 12), $return[2], $return[1]
    }
    elseif ($DescendingArpeggio)
    {
        $return += $return[1]
    }

    return $return
}
