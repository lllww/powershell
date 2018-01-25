# grab relevant lines from file
$KeyValPairs = Get-Content .\tokens.ini | Where {$_ -like "*=*" }

# join strings together as one big string
$KeyValPairString = $KeyValPairs -join [Environment]::NewLine

# create hashtable/dictionary from string with ConvertFrom-StringData
$Dictionary = $KeyValPairString |ConvertFrom-StringData


Get-Content .\template.txt |ForEach-Object { 
    [Regex]::Replace($_, '%(\p{L}+)%', {
        param($Match)

        # look term up in dictionary
        return $Dictionary[$Match.Groups[1].Value]
    }) 
}