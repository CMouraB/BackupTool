Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

if ($PSScriptRoot -ne $null -and $PSScriptRoot -ne "") {
    $scriptPath = $PSScriptRoot
} else {
    $scriptPath = [System.IO.Path]::GetDirectoryName([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName)
}

$configFile = Join-Path $scriptPath "settings.json"
$script:lastLogFile = ""
$paypalUrl = "https://www.paypal.com/donate/?business=AJQHMVMPV9APS&no_recurring=0&currency_code=USD"
$privacyUrl = "https://moura.in.net/backuptool-privacy.html"

$langDict = @{
    PT = @{ Title="BackupTool"; LblOrigem="Origem:"; LblDestino="Destino:"; LblIgnore="Ignorar Extensões (ex: *.tmp *.log):"; BtnSelect="Selecionar..."; BtnExec="INICIAR BACKUP"; BtnLog="Abrir Log"; BtnDonate="Doar (PayPal)"; BtnPrivacy="Política de Privacidade"; ChkMirror="Modo Espelho (Deleta arquivos no destino inexistentes na origem)"; MenuLang="Idiomas"; MenuHelp="Ajuda"; MenuAbout="Sobre"; MsgEmpty="Selecione origem e destino."; MsgSame="Origem e Destino iguais!"; MsgNoSource="Origem nao encontrada."; StatusWait="Executando Backup... (Isso pode demorar)"; StatusDone="Finalizado com Sucesso!"; AboutText="BackupTool v1.0`n`nFuncionalidade:`nCompara origem e destino para copias rapidas.`n`nModo Padrao: Copia apenas novos/alterados.`nModo Espelho: Remove arquivos extras no destino." }
    EN = @{ Title="BackupTool"; LblOrigem="Source:"; LblDestino="Destination:"; LblIgnore="Ignore Extensions (ex: *.tmp *.log):"; BtnSelect="Browse..."; BtnExec="START BACKUP"; BtnLog="Open Log"; BtnDonate="Donate (PayPal)"; BtnPrivacy="Privacy Policy"; ChkMirror="Mirror Mode (Deletes extra files in destination)"; MenuLang="Languages"; MenuHelp="Help"; MenuAbout="About"; MsgEmpty="Select source and destination."; MsgSame="Source/Dest are same!"; MsgNoSource="Source not found."; StatusWait="Running Backup... (This may take a while)"; StatusDone="Finished Successfully!"; AboutText="BackupTool v1.0`n`nFeatures:`nCompares source and destination for fast copies.`n`nDefault Mode: Copies only new/changed files.`nMirror Mode: Deletes extra files in destination." }
    ES = @{ Title="BackupTool"; LblOrigem="Origen:"; LblDestino="Destino:"; LblIgnore="Ignorar Extensiones:"; BtnSelect="Seleccionar..."; BtnExec="INICIAR"; BtnLog="Abrir Log"; BtnDonate="Donar (PayPal)"; BtnPrivacy="Política de Privacidad"; ChkMirror="Modo Espejo (Borra archivos extras en destino)"; MenuLang="Idiomas"; MenuHelp="Ayuda"; MenuAbout="Acerca de"; MsgEmpty="Seleccione origen y destino."; MsgSame="Origen y Destino iguales!"; MsgNoSource="Origen no encontrado."; StatusWait="Ejecutando... (Espere)"; StatusDone="Finalizado con Exito!"; AboutText="BackupTool v1.0`n`nFuncionalidad:`nCompara origen y destino para copias rapidas.`n`nModo Estandar: Copia solo archivos nuevos/modificados.`nModo Espejo: Elimina archivos extras en el destino." }
    DE = @{ Title="BackupTool"; LblOrigem="Quelle:"; LblDestino="Ziel:"; LblIgnore="Erweiterungen ignorieren:"; BtnSelect="Auswahlen..."; BtnExec="STARTEN"; BtnLog="Log offnen"; BtnDonate="Spenden (PayPal)"; BtnPrivacy="Datenschutzerklärung"; ChkMirror="Spiegelmodus (Loscht Dateien im Ziel)"; MenuLang="Sprachen"; MenuHelp="Hilfe"; MenuAbout="Uber"; MsgEmpty="Quelle und Ziel wahlen."; MsgSame="Quelle und Ziel sind gleich!"; MsgNoSource="Quelle nicht gefunden."; StatusWait="Ausfuhren... (Bitte warten)"; StatusDone="Erfolgreich beendet!"; AboutText="BackupTool v1.0`n`nFunktion:`nVergleicht Quelle und Ziel fur schnelle Kopien.`n`nStandardmodus: Kopiert nur neue/geanderte Dateien.`nSpiegelmodus: Loscht uberflussige Dateien im Ziel." }
    FR = @{ Title="BackupTool"; LblOrigem="Source:"; LblDestino="Destination:"; LblIgnore="Ignorer les extensions:"; BtnSelect="Selectionner..."; BtnExec="LANCER"; BtnLog="Ouvrir Log"; BtnDonate="Faire un don"; BtnPrivacy="Politique de Confidentialité"; ChkMirror="Mode Miroir (Supprime fichiers extras)"; MenuLang="Langues"; MenuHelp="Aide"; MenuAbout="A propos"; MsgEmpty="Selectionner source et destination."; MsgSame="Source/Dest identiques !"; MsgNoSource="Source introuvable."; StatusWait="Execution en cours..."; StatusDone="Termine avec succes !"; AboutText="BackupTool v1.0`n`nFonctionnalite :`nCompare la source et la destination pour des copies rapides.`n`nMode Standard : Copie uniquement les nouveaux fichiers/modifies.`nMode Miroir : Supprime les fichiers en trop dans la destination." }
    IT = @{ Title="BackupTool"; LblOrigem="Origine:"; LblDestino="Destinazione:"; LblIgnore="Ignora estensioni:"; BtnSelect="Seleziona..."; BtnExec="AVVIA"; BtnLog="Apri Log"; BtnDonate="Dona (PayPal)"; BtnPrivacy="Informativa sulla Privacy"; ChkMirror="Modalita Specchio (Rimuove file extra)"; MenuLang="Lingue"; MenuHelp="Aiuto"; MenuAbout="Info"; MsgEmpty="Seleziona origine e destinazione."; MsgSame="Origine/Dest uguali!"; MsgNoSource="Origine non trovata."; StatusWait="Esecuzione... (Attendere)"; StatusDone="Finito con Successo!"; AboutText="BackupTool v1.0`n`nFunzionalita:`nConfronta origine e destinazione per copie rapide.`n`nModalita Standard: Copia solo file nuovi/modificati.`nModalita Specchio: Rimuove i file extra nella destinazione." }
    RU = @{ Title="BackupTool"; LblOrigem="Источник:"; LblDestino="Назначение:"; LblIgnore="Игнорировать расширения:"; BtnSelect="Выбрать..."; BtnExec="НАЧАТЬ"; BtnLog="Открыть лог"; BtnDonate="Пожертвовать"; BtnPrivacy="Политика конфиденциальности"; ChkMirror="Зеркало (Удаляет лишние файлы)"; MenuLang="Языки"; MenuHelp="Помощь"; MenuAbout="О программе"; MsgEmpty="Выберите источник и назначение."; MsgSame="Папки совпадают!"; MsgNoSource="Источник не найден."; StatusWait="Выполнение... (Ждите)"; StatusDone="Успешно завершено!"; AboutText="BackupTool v1.0`n`nФункциональность:`nСравнивает источник и назначение для быстрого копирования.`n`nСтандартный режим: Копирует только новые/измененные файлы.`nРежим зеркала: Удаляет лишние файлы в папке назначения." }
    HI = @{ Title="BackupTool"; LblOrigem="स्रोत:"; LblDestino="गंतव्य:"; LblIgnore="एक्सटेंशन छोड़ें:"; BtnSelect="चुनें..."; BtnExec="शुरू करें"; BtnLog="लॉग खोलें"; BtnDonate="दान करें (PayPal)"; BtnPrivacy="गोपनीयता नीति"; ChkMirror="मिरर मोड (अतिरिक्त फ़ाइलें हटाता है)"; MenuLang="भाषाएं"; MenuHelp="सहायता"; MenuAbout="के बारे में"; MsgEmpty="स्रोत और गंतव्य चुनें।"; MsgSame="स्रोत और गंतव्य समान हैं!"; MsgNoSource="स्रोत नहीं मिला।"; StatusWait="चल रहा है... (प्रतीक्षा करें)"; StatusDone="सफलतापूर्वक समाप्त!"; AboutText="BackupTool v1.0`n`nविशेषताएं:`nतेज़ कॉपी के लिए स्रोत और गंतव्य की तुलना करता है।`n`nडिफ़ॉल्ट मोड: केवल नई/परिवर्तित फ़ाइलों को कॉपी करता है।`nमिरर मोड: गंतव्य में अतिरिक्त फ़ाइलों को हटा देता है।" }
    AR = @{ Title="BackupTool"; LblOrigem="المصدر:"; LblDestino="الوجهة:"; LblIgnore="تجاهل الامتدادات:"; BtnSelect="تحديد..."; BtnExec="بدء"; BtnLog="فتح السجل"; BtnDonate="تبرع (PayPal)"; BtnPrivacy="سياسة الخصوصية"; ChkMirror="وضع المرآة (حذف الملفات الزائدة)"; MenuLang="اللغات"; MenuHelp="مساعدة"; MenuAbout="حول"; MsgEmpty="حدد المصدر والوجهة."; MsgSame="المصدر والوجهة متطابقان!"; MsgNoSource="المصدر غير موجود."; StatusWait="جاري التنفيذ... (انتظر)"; StatusDone="تم الانتهاء بنجاح!"; AboutText="BackupTool v1.0`n`nالميزات:`nيقارن المصدر والوجهة للنسخ السريع.`n`nالوضع الافتراضي: ينسخ الملفات الجديدة/المعدلة فقط.`nوضع المرآة: يحذف الملفات الزائدة في الوجهة." }
    JP = @{ Title="BackupTool"; LblOrigem="元:"; LblDestino="先:"; LblIgnore="拡張子を無視:"; BtnSelect="選択..."; BtnExec="開始"; BtnLog="ログを開く"; BtnDonate="寄付する (PayPal)"; BtnPrivacy="プライバシーポリシー"; ChkMirror="ミラーモード (不要ファイルを削除)"; MenuLang="言語"; MenuHelp="ヘルプ"; MenuAbout="情報"; MsgEmpty="元と先を選択してください。"; MsgSame="フォルダが同じです！"; MsgNoSource="元が見つかりません。"; StatusWait="実行中... (お待ちください)"; StatusDone="正常に完了しました！"; AboutText="BackupTool v1.0`n`n機能:`n元と先を比較して高速にコピーします。`n`n通常モード: 新規または変更されたファイルのみコピーします。`nミラーモード: 先にある不要なファイルを削除します。" }
    CN = @{ Title="BackupTool"; LblOrigem="来源:"; LblDestino="目标:"; LblIgnore="忽略扩展名:"; BtnSelect="选择..."; BtnExec="开始"; BtnLog="打开日志"; BtnDonate="捐款 (PayPal)"; BtnPrivacy="隐私政策"; ChkMirror="镜像模式 (删除多余文件)"; MenuLang="语言"; MenuHelp="帮助"; MenuAbout="关于"; MsgEmpty="请选择来源和目标。"; MsgSame="文件夹相同！"; MsgNoSource="来源未找到。"; StatusWait="执行中... (请稍候)"; StatusDone="成功完成！"; AboutText="BackupTool v1.0`n`n功能:`n比较来源和目标以进行快速复制。`n`n默认模式: 仅复制新文件或已更改的文件。`n镜像模式: 删除目标中多余的文件。" }
}

$langDisplayMap = @{
    "Português" = "PT"; "English" = "EN"; "Español" = "ES"; "Deutsch" = "DE"; "Français" = "FR";
    "Italiano" = "IT"; "Русский" = "RU"; "हिन्दी" = "HI"; "العربية" = "AR"; "日本語" = "JP"; "中文" = "CN"
}

$sysCulture = (Get-UICulture).TwoLetterISOLanguageName.ToUpper()
if ($sysCulture -eq "ZH") { $sysCulture = "CN" }
if ($langDict.ContainsKey($sysCulture)) { $currentLang = $sysCulture } else { $currentLang = "EN" }

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(600, 600)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$menuStrip = New-Object System.Windows.Forms.MenuStrip
$form.Controls.Add($menuStrip)
$menuLang = New-Object System.Windows.Forms.ToolStripMenuItem("")
[void]$menuStrip.Items.Add($menuLang)
$menuAjuda = New-Object System.Windows.Forms.ToolStripMenuItem("")
[void]$menuStrip.Items.Add($menuAjuda)
$itemSobre = New-Object System.Windows.Forms.ToolStripMenuItem("")
[void]$menuAjuda.DropDownItems.Add($itemSobre)

$fontBold = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
$fontNormal = New-Object System.Drawing.Font("Segoe UI", 9)
$fontStatus = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$fontLog = New-Object System.Drawing.Font("Consolas", 8)

$lblOrigem = New-Object System.Windows.Forms.Label
$lblOrigem.Font = $fontBold; $lblOrigem.Location = New-Object System.Drawing.Point(20,40); $lblOrigem.AutoSize = $true
$form.Controls.Add($lblOrigem)

$txtOrigem = New-Object System.Windows.Forms.TextBox
$txtOrigem.Size = New-Object System.Drawing.Size(430,25); $txtOrigem.Location = New-Object System.Drawing.Point(20,60); $txtOrigem.Font = $fontNormal
$form.Controls.Add($txtOrigem)

$btnOrigem = New-Object System.Windows.Forms.Button
$btnOrigem.Location = New-Object System.Drawing.Point(460,58); $btnOrigem.Size = New-Object System.Drawing.Size(100,27)
$form.Controls.Add($btnOrigem)

$lblDestino = New-Object System.Windows.Forms.Label
$lblDestino.Font = $fontBold; $lblDestino.Location = New-Object System.Drawing.Point(20,95); $lblDestino.AutoSize = $true
$form.Controls.Add($lblDestino)

$txtDestino = New-Object System.Windows.Forms.TextBox
$txtDestino.Size = New-Object System.Drawing.Size(430,25); $txtDestino.Location = New-Object System.Drawing.Point(20,115); $txtDestino.Font = $fontNormal
$form.Controls.Add($txtDestino)

$btnDestino = New-Object System.Windows.Forms.Button
$btnDestino.Location = New-Object System.Drawing.Point(460,113); $btnDestino.Size = New-Object System.Drawing.Size(100,27)
$form.Controls.Add($btnDestino)

$lblIgnore = New-Object System.Windows.Forms.Label
$lblIgnore.Font = $fontBold; $lblIgnore.Location = New-Object System.Drawing.Point(20,150); $lblIgnore.AutoSize = $true
$form.Controls.Add($lblIgnore)

$txtIgnore = New-Object System.Windows.Forms.TextBox
$txtIgnore.Size = New-Object System.Drawing.Size(540,25); $txtIgnore.Location = New-Object System.Drawing.Point(20,170); $txtIgnore.Font = $fontNormal
$form.Controls.Add($txtIgnore)

$chkMirror = New-Object System.Windows.Forms.CheckBox
$chkMirror.Location = New-Object System.Drawing.Point(20, 205); $chkMirror.Size = New-Object System.Drawing.Size(550, 20); $chkMirror.Font = $fontNormal; $chkMirror.ForeColor = "DarkRed" 
$form.Controls.Add($chkMirror)

$btnExecutar = New-Object System.Windows.Forms.Button
$btnExecutar.Font = $fontBold; $btnExecutar.Size = New-Object System.Drawing.Size(410,40); $btnExecutar.Location = New-Object System.Drawing.Point(20,235); $btnExecutar.BackColor = "LightGreen"
$form.Controls.Add($btnExecutar)

$btnOpenLog = New-Object System.Windows.Forms.Button
$btnOpenLog.Font = $fontBold; $btnOpenLog.Size = New-Object System.Drawing.Size(120,40); $btnOpenLog.Location = New-Object System.Drawing.Point(440,235); $btnOpenLog.Enabled = $false
$form.Controls.Add($btnOpenLog)

$lblStatus = New-Object System.Windows.Forms.Label
$lblStatus.Location = New-Object System.Drawing.Point(20, 285); $lblStatus.Size = New-Object System.Drawing.Size(540, 25); $lblStatus.Font = $fontStatus; $lblStatus.TextAlign = "MiddleCenter"; $lblStatus.Text = ""
$form.Controls.Add($lblStatus)

$txtLog = New-Object System.Windows.Forms.TextBox
$txtLog.Multiline = $true; $txtLog.ScrollBars = "Vertical"; $txtLog.ReadOnly = $true; $txtLog.Location = New-Object System.Drawing.Point(20, 315); $txtLog.Size = New-Object System.Drawing.Size(540, 180); $txtLog.Font = $fontLog; $txtLog.BackColor = "Black"; $txtLog.ForeColor = "Lime"
$form.Controls.Add($txtLog)

$btnDonateMain = New-Object System.Windows.Forms.Button
$btnDonateMain.Font = $fontBold; $btnDonateMain.Size = New-Object System.Drawing.Size(120,30); $btnDonateMain.Location = New-Object System.Drawing.Point(440,505); $btnDonateMain.BackColor = "Gold"
$btnDonateMain.Add_Click({ [System.Diagnostics.Process]::Start($paypalUrl) })
$form.Controls.Add($btnDonateMain)

$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog

function Atualizar-Interface {
    $t = $langDict[$currentLang]
    $form.Text = $t.Title; $lblOrigem.Text = $t.LblOrigem; $lblDestino.Text = $t.LblDestino; $lblIgnore.Text = $t.LblIgnore
    $btnOrigem.Text = $t.BtnSelect; $btnDestino.Text = $t.BtnSelect; $btnExecutar.Text = $t.BtnExec; $btnOpenLog.Text = $t.BtnLog
    $chkMirror.Text = $t.ChkMirror; $menuLang.Text = $t.MenuLang; $menuAjuda.Text = $t.MenuHelp; $itemSobre.Text = $t.MenuAbout
    $btnDonateMain.Text = $t.BtnDonate
}

function Carregar-Config {
    if (Test-Path $configFile) {
        try {
            $json = Get-Content $configFile -Raw | ConvertFrom-Json
            if ($json.Origem) { $txtOrigem.Text = $json.Origem }
            if ($json.Destino) { $txtDestino.Text = $json.Destino }
            if ($json.Espelhar) { $chkMirror.Checked = $json.Espelhar }
            if ($json.Ignore) { $txtIgnore.Text = $json.Ignore }
            if ($json.Lang -and $langDict.ContainsKey($json.Lang)) { $script:currentLang = $json.Lang }
        } catch {}
    }
    Atualizar-Interface
}

function Salvar-Config {
    try {
        $data = @{ Origem=$txtOrigem.Text; Destino=$txtDestino.Text; Espelhar=$chkMirror.Checked; Ignore=$txtIgnore.Text; Lang=$script:currentLang }
        $data | ConvertTo-Json | Set-Content $configFile
    } catch {}
}

foreach ($displayName in $langDisplayMap.Keys) {
    $item = New-Object System.Windows.Forms.ToolStripMenuItem($displayName)
    $item.Add_Click({ $script:currentLang = $langDisplayMap[$this.Text]; Atualizar-Interface })
    [void]$menuLang.DropDownItems.Add($item)
}

$form.Add_Load({ Carregar-Config })
$form.Add_FormClosing({ Salvar-Config })

$itemSobre.Add_Click({
    $t = $langDict[$currentLang]
    $frmSobre = New-Object System.Windows.Forms.Form
    $frmSobre.Text = $t.MenuAbout; $frmSobre.Size = New-Object System.Drawing.Size(350, 280); $frmSobre.StartPosition = "CenterParent"; $frmSobre.FormBorderStyle = "FixedToolWindow"
    
    $lblInfo = New-Object System.Windows.Forms.Label
    $lblInfo.Text = $t.AboutText; $lblInfo.Location = New-Object System.Drawing.Point(20, 20); $lblInfo.Size = New-Object System.Drawing.Size(300, 120)
    $frmSobre.Controls.Add($lblInfo)
    
    $lblDev = New-Object System.Windows.Forms.Label
    $lblDev.Text = "Desenvolvido por Moura"; $lblDev.Location = New-Object System.Drawing.Point(20, 150); $lblDev.AutoSize = $true; $lblDev.Font = $fontBold
    $frmSobre.Controls.Add($lblDev)
    
    $linkSite = New-Object System.Windows.Forms.LinkLabel
    $linkSite.Text = "moura.in.net"; $linkSite.Location = New-Object System.Drawing.Point(20, 170); $linkSite.AutoSize = $true
    $linkSite.Add_LinkClicked({ [System.Diagnostics.Process]::Start("http://moura.in.net") })
    $frmSobre.Controls.Add($linkSite)

    $linkPrivacy = New-Object System.Windows.Forms.LinkLabel
    $linkPrivacy.Text = $t.BtnPrivacy
    $linkPrivacy.Location = New-Object System.Drawing.Point(20, 190); $linkPrivacy.AutoSize = $true
    $linkPrivacy.Add_LinkClicked({ [System.Diagnostics.Process]::Start($privacyUrl) })
    $frmSobre.Controls.Add($linkPrivacy)
    
    $btnDonateSobre = New-Object System.Windows.Forms.Button
    $btnDonateSobre.Font = $fontBold; $btnDonateSobre.Size = New-Object System.Drawing.Size(120,30); $btnDonateSobre.Location = New-Object System.Drawing.Point(200,150); $btnDonateSobre.BackColor = "Gold"
    $btnDonateSobre.Text = $t.BtnDonate
    $btnDonateSobre.Add_Click({ [System.Diagnostics.Process]::Start($paypalUrl) })
    $frmSobre.Controls.Add($btnDonateSobre)

    [void]$frmSobre.ShowDialog()
})

$btnOrigem.Add_Click({ if ($folderBrowser.ShowDialog() -eq "OK") { $txtOrigem.Text = $folderBrowser.SelectedPath } })
$btnDestino.Add_Click({ if ($folderBrowser.ShowDialog() -eq "OK") { $txtDestino.Text = $folderBrowser.SelectedPath } })
$btnOpenLog.Add_Click({ if ($script:lastLogFile -ne "" -and (Test-Path $script:lastLogFile)) { Start-Process "notepad.exe" $script:lastLogFile } })

$btnExecutar.Add_Click({
    $t = $langDict[$currentLang]

    if ([string]::IsNullOrWhiteSpace($txtOrigem.Text) -or [string]::IsNullOrWhiteSpace($txtDestino.Text)) { [System.Windows.Forms.MessageBox]::Show($t.MsgEmpty, "Erro", 0, 16); return }
    if ($txtOrigem.Text.Trim().TrimEnd('\') -eq $txtDestino.Text.Trim().TrimEnd('\')) { [System.Windows.Forms.MessageBox]::Show($t.MsgSame, "Erro", 0, 16); return }
    if (-not (Test-Path $txtOrigem.Text)) { [System.Windows.Forms.MessageBox]::Show($t.MsgNoSource, "Erro", 0, 16); return }

    $btnExecutar.Enabled = $false; $btnOpenLog.Enabled = $false; $lblStatus.Text = $t.StatusWait; $lblStatus.ForeColor = "Orange"; $txtLog.Text = ""
    [System.Windows.Forms.Application]::DoEvents()

    $src = $txtOrigem.Text
    if ($src.EndsWith("\")) { $src += "\" }
    
    $dst = $txtDestino.Text
    if ($dst.EndsWith("\")) { $dst += "\" }
    
    $modoCopia = if ($chkMirror.Checked) { "/MIR" } else { "/E", "/XO" }
    $ignoreArgs = if ($txtIgnore.Text) { "/XF " + $txtIgnore.Text } else { "" }
    
    # Execução Direta (Sem Estimativa Previa) para maxima performance
    $script:lastLogFile = "$env:TEMP\BackupLog_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    $lblStatus.ForeColor = "Red"
    
    # Removemos /NJH /NJS para que o Robocopy gere o sumario nativo no final do log
    $robocopyArgs = "`"$src`" `"$dst`" $modoCopia /FFT /MT:16 /R:1 /W:1 /NP /XD `"System Volume Information`" `"`$RECYCLE.BIN`" $ignoreArgs /NDL /NC /NS"
    
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "robocopy.exe"
    $pinfo.Arguments = $robocopyArgs
    $pinfo.UseShellExecute = $false
    $pinfo.RedirectStandardOutput = $true
    $pinfo.CreateNoWindow = $true
    $pinfo.StandardOutputEncoding = [System.Text.Encoding]::UTF8

    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null

    while (-not $p.HasExited) {
        $line = $p.StandardOutput.ReadLine()
        if ($line) { $txtLog.AppendText($line + "`r`n") }
        [System.Windows.Forms.Application]::DoEvents()
    }
    
    $rest = $p.StandardOutput.ReadToEnd()
    if ($rest) { $txtLog.AppendText($rest + "`r`n") }
    
    $txtLog.Text | Set-Content $script:lastLogFile -Encoding UTF8
    $btnExecutar.Enabled = $true; $btnOpenLog.Enabled = $true; $lblStatus.Text = $t.StatusDone; $lblStatus.ForeColor = "Green"
})

[void]$form.ShowDialog()