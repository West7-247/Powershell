Function UnGZip-File{
    Param(
        $infile,
        $outfile = ($infile -replace '\.gz$','')
        )

    $input = New-Object System.IO.FileStream $inFile, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
    $output = New-Object System.IO.FileStream $outFile, ([IO.FileMode]::Create), ([IO.FileAccess]::Write), ([IO.FileShare]::None)
    $gzipStream = New-Object System.IO.Compression.GzipStream $input, ([IO.Compression.CompressionMode]::Decompress)

    $buffer = New-Object byte[](1024)
    while($true){
        $read = $gzipstream.Read($buffer, 0, 1024)
        if ($read -le 0){break}
        $output.Write($buffer, 0, $read)
        }

    $gzipStream.Close()
    $output.Close()
    $input.Close()
}


Function GZip-File{
    Param(
        $infile,
        $outfile = ($infile +[DateTime]::Now.Tostring("yyyyMMddHHmmss")+".gz")
        )

    $input = New-Object System.IO.FileStream $inFile, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
    $output = New-Object System.IO.FileStream $outFile, ([IO.FileMode]::Create), ([IO.FileAccess]::Write), ([IO.FileShare]::None)
    $gzipStream = New-Object System.IO.Compression.GzipStream $output, ([IO.Compression.CompressionMode]::Compress)

    $buffer = New-Object byte[](1024)
    while($true){
        $read = $input.Read($buffer, 0, 1024)
        if ($read -le 0){break}
        $gzipStream.Write($buffer, 0, $read)
        }

    $gzipStream.Close()
    $output.Close()
    $input.Close()
}

#解凍
$infile="E:\@DevEnv\@code\powershell\zip-unzip\gzip-test.txt.gz"
UnGZip-File $infile 


#圧縮
$infile="E:\@DevEnv\@code\powershell\zip-unzip\gzip-test.txt"
GZip-File $infile "test.gz"
