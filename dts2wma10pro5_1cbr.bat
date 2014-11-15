@REM
@REM dts2wma10pro5_1cbr.bat
@REM %1 = SourceFile with path
@REM %2 = Source FileName Without Ext
@REM %3 = Source file Ext (dts or dtshd)
@REM %4 = Destination filename with path
@REM
@ECHO DTS to WMA 10 Pro 5.1 convertor
@ECHO Copyright (C) 2014. All rights reserved.
@ECHO.
@ECHO Converting %2.%3 to %2.wma with WMA 10 Pro codec...
@ECHO.
@ECHO Preparing to convert...
@MKDIR C:\tmp_dts2wma
CD C:\tmp_dts2wma
DEL *.wav /F /Q
DEL *.wma /F /Q
DEL *.txt /F /Q
DEL *.dts /F /Q
DEL *.dtshd /F /Q
DEL *.%3 /F /Q
CD C:\tmp_dts2wma
COPY %1 C:\tmp_dts2wma\audioclip.%3

@ECHO Extracting Audio tracks from %2.%3...
@ECHO.

@IF NOT %3==dts C:\Tools\dts2wmapro\tools\eac3to\eac3to.exe C:\tmp_dts2wma\audioclip.%3 C:\tmp_dts2wma\audioclip.dts
C:\Tools\dts2wmapro\tools\Tranzcode.exe C:\tmp_dts2wma\audioclip.dts

@ECHO.
@ECHO Preparing 5.1 wav Audio tracks...
@ECHO.
C:\Tools\dts2wmapro\tools\ffmpeg.exe -i audioclip-FL.wav audioclip-FL1.wav
C:\Tools\dts2wmapro\tools\ffmpeg.exe -i audioclip-FR.wav audioclip-FR1.wav
C:\Tools\dts2wmapro\tools\ffmpeg.exe -i audioclip-C.wav audioclip-C1.wav
C:\Tools\dts2wmapro\tools\ffmpeg.exe -i audioclip-SL.wav audioclip-SL1.wav
C:\Tools\dts2wmapro\tools\ffmpeg.exe -i audioclip-SR.wav audioclip-SR1.wav
C:\Tools\dts2wmapro\tools\ffmpeg.exe -i audioclip-LFE.wav audioclip-LFE1.wav
@REM Pause
@ECHO.
@ECHO.
@ECHO Sourcing from multichannel audio files...
@"C:\Program Files\Windows Media Components\Encoder\wmenc.exe" "C:\Tools\dts2wmapro\profile\dts2wma10pro5_1cbr.wme" /START
@REM "C:\Program Files\Windows Media Components\Encoder\wmenc.exe" "C:\Tools\dts2wmapro\profile\dts2wma10pro5_1cbr.wme"

@COPY C:\tmp_dts2wma\audioclip.wma %4

@ECHO.
@ECHO Cleaning up...
CD C:\tmp_dts2wma
DEL *.wav /F /Q
DEL *.wma /F /Q
DEL *.txt /F /Q
DEL *.dts /F /Q
DEL *.dtshd /F /Q
DEL *.%3 /F /Q
CD \
RMDIR C:\tmp_dts2wma

@ECHO.
@ECHO Converting %2.%3 to %2.wma with WMA 10 Pro codec...Done
@ECHO.
