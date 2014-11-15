#SingleInstance,Force
#NoEnv

SetWorkingDir, %A_ScriptDir%

applicationname=DTStoWMA
Gui, Add, Picture, x12 y12 w300 h120 , img/DTS.png
Gui, Add, Picture, x12 y142 w300 h110 , img/DTSHD.jpg
Gui, Add, Picture, x322 y192 w480 h60 , img/WMALogo.jpg

Gui, Add, Picture, x334 y30 w32 h32 , img/WMA.ico

Gui, Add, GroupBox, x322 y12 w480 h132 , Audio Source
Gui, Show, x471 y340 h229 w819, Convert to WMA

Gui, Add, Text, x385 y33 w408 h41 , Type the name of a DTS or DTS-HD audio file and converter will generate WMA 5.1 surround sound with Windows Media Pro 10 Codec
Gui, Add, Text, x334 y75 w42 h21 , &File:
Gui, Add, Edit, WantCtrlA r1 vAudioFileName x385 y75 w401 h23 ,
Gui, Add, Button, x703 y105 w88 h23 , &Browse...
Gui, Add, Button, x703 y205 w88 h33 cBlue, &Convert

if strLen(1) > 0
    GuiControl,Text, AudioFileName, %1%
Gui, Show, AutoSize Center, Convert DTS/DTS-HD to WMA Pro 10 5.1
Return

ButtonBrowse...:
FileSelectFile, SelectedFile, 1, , Choose DTS or DTS-HD audio file, DTS Audio file (*.dts; *.dtshd)
if StrLen(SelectedFile) > 0
    GuiControl,Text, AudioFileName, %SelectedFile%
Return

ButtonConvert:

guiControlGet, AudioFileNameVal, , AudioFileName

if strLen(AudioFileNameVal) = 0 {
    MsgBox ,48, No DTS or DTSHD Audio source file, Error#101: No DTS or DTSHD Audio source file selected.`n`nPlease choose a DTS or DTSHD Audio source file to convert into WMA.
    Return
}

IfNotExist, %AudioFileNameVal%
{
    MsgBox, 16, DTS or DTSHD Audio source file not exists, Error#102: %AudioFileNameVal% not found.`n`nPlease choose exisiting DTS or DTSHD Audio source file to convert into WMA.
    Return
}

SplitPath, AudioFileNameVal,,AudioFilePathVal,AudioFileExtVal, AudioFileNameOnlyVal
RunWait "%A_ScriptDir%\dts2wma10pro5_1cbr.bat" "%AudioFileNameVal%" %AudioFileNameOnlyVal% %AudioFileExtVal% "%AudioFilePathVal%\%AudioFileNameOnlyVal%.wma"

IfExist, "%AudioFilePathVal%\%AudioFileNameOnlyVal%.wma"
{
    MsgBox, 64, Conversion successful, Converted %AudioFileNameOnlyVal%.%AudioFileExtVal% into %AudioFileNameOnlyVal%.wma with WMA PRO 10 Codec
}
Return

GuiClose:
ExitApp