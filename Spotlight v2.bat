::v2
@echo off

setlocal enabledelayedexpansion
set User=%userprofile%
set Source=%User%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets
set Dest="A:\Pictures\Spotlight\Originals"
set Temp=%Dest%\Tmp
set Limit=250000
set "trash=2a26671ea9.jpg 6c3324def2.jpg be23eb4c1b.jpg cac20c6934.jpg e85f6cfcc3.jpg fc261895ec.jpg 1d855b562d.jpg 2a26671ea9.jpg be23eb4c1b.jpg e85f6cfcc3.jpg fc261895ec.jpg"

set "original=e4e7d4e9e8.jpg 7b29ea8e20.jpg dc80eb34ad.jpg 4ac4f1ef79.jpg 0970ab4f46.jpg 543b58b97e.jpg a82a9ae83d.jpg 60559629a5.jpg 7998ffb0f2.jpg 32783d7a95.jpg 393d1a60de.jpg 794241813c.jpg 0a47e3f636.jpg 0c2a4724b9.jpg 1a00497a41.jpg 2fdbb8c87e.jpg 3d6813858c.jpg 3ebfe985b4.jpg 5ad70a3299.jpg 5e3164290a.jpg 5ec348218f.jpg 07dc4b9d91.jpg 7aa36a66d9.jpg 7d4deff6aa.jpg 8d972f2553.jpg 8eed0ac530.jpg 9a3c6d21e6.jpg 9b6a28c20c.jpg 9b9414d712.jpg 13c92fd055.jpg 89f4907a69.jpg ca372069c0.jpg 19fc758b9a.jpg 20a55b20c2.jpg 22d135c3a6.jpg 23fe46029a.jpg 35e36de540.jpg 38c84b3d62.jpg 40cdd4aa6e.jpg 41c417a6a5.jpg 52b88d6505.jpg 54e9814ba2.jpg 63eabd5550.jpg 65d60dd44a.jpg 78ff97053f.jpg 87dc4c56f8.jpg 90db351ffb.jpg 93e4c7b235.jpg 94e9d956f2.jpg 95eb0afb60.jpg 98b45722b5.jpg 99efb96d8b.jpg 165f5741c5.jpg 301be118be.jpg 330abaa73c.jpg 571b213064.jpg 943a5c2888.jpg 1405f336fb.jpg 2003f84b12.jpg 5923f36c01.jpg 8356bfb383.jpg 9423a3628b.jpg 19607cf66f.jpg 52901e21ba.jpg 75782a2108.jpg 77387eec48.jpg 98713ec6f3.jpg 237972fafb.jpg 277313d62a.jpg 497675cb3a.jpg 7814294e50.jpg 8877057ceb.jpg df6d21d687.jpg 478014449b.jpg 1973115490.jpg a3d4692ff8.jpg a3ea339d14.jpg a6bf69dd7d.jpg a9c76416b4.jpg a9f0241267.jpg a53b58720e.jpg a55d54bb7c.jpg "

set "small=7367e80acf-sm.jpg 356778ffb0-sm.jpg 2e3267a60a-sm.jpg 6aa0da31e9-sm.jpg 8a117d2c9a-sm.jpg dee116c382-sm.jpg ad7716b937-sm.jpg 0e4c9ad20e-sm.jpg 1c94b60a51-sm.jpg 47719e9955-sm.jpg 4ac0ddda07-sm.jpg f005cc4075-sm.jpg c09666d6d7-sm.jpg 93d1744980-sm.jpg c1df49d3e9-sm.jpg c7783f801f-sm.jpg e19b4babc3-sm.jpg 94eca0962f-sm.jpg 86e67d92a5-sm.jpg 75cf462427-sm.jpg e164d2c479-sm.jpg c201e78402-sm.jpg f4bfd2f77d-sm.jpg 49a883073e-sm.jpg 33a57fc592-sm.jpg 5a03caccb5-sm.jpg 3a465ce502-sm.jpg 20b061ddb1-sm.jpg 2d86bf9453-sm.jpg 519428bcf9-sm.jpg c98cf2fe5b-sm.jpg 846cc5e6a2-sm.jpg 392edf8b98-sm.jpg cf68fd4323-sm.jpg 9bd0b59b87-sm.jpg 19f049121f-sm.jpg c9ad0d53d0-sm.jpg 6c44de0522-sm.jpg 0dc5cb8af0-sm.jpg 020a1d1ebd-sm.jpg 3a1d91aac5-sm.jpg 3695e2d2ea-sm.jpg 0f44a3bcf3-sm.jpg 47719e9955-sm.jpg 61cffc5ec2-sm.jpg c15911ff6a-sm.jpg 521578cc01-sm.jpg 69158d48d5-sm.jpg 3c8ccdf307-sm.jpg 66af89494e-sm.jpg ea57d818d4-sm.jpg 8f7bb89735-sm.jpg 4fcb5b1ca9-sm.jpg f438151d99-sm.jpg c51aaf7245-sm.jpg 95d5be0076-sm.jpg c906934da4-sm.jpg 62248fc6f0-sm.jpg b619c3a42c-sm.jpg 63211b755f-sm.jpg 53e803b423-sm.jpg 97f521f3b4-sm.jpg e9fb06e24e-sm.jpg 42e4efa8d9-sm.jpg b4e168d708-sm.jpg 9b513868be-sm.jpg a798d64af5-sm.jpg b71b849837-sm.jpg 8e9668d65c-sm.jpg 2d31d5b4b1-sm.jpg 93f07873f8-sm.jpg 7cc1f5dce4-sm.jpg f4517dc6d4-sm.jpg 674ece24a1-sm.jpg 4fa2121793-sm.jpg ac3ac05001-sm.jpg 97fc2bf939-sm.jpg 07e1d6eea7-sm.jpg ffc286f271-sm.jpg ce8908f889-sm.jpg 54798ee767-sm.jpg 51a7f02fdd-sm.jpg "

echo "Your files will be saved to %Dest%
if not exist %Dest% mkdir %Dest%
if not exist %Temp% mkdir %Temp%
for %%a in ("%Source%\*") do if %%~za GEQ %Limit% copy "%%a" %Temp%

for %%a in ("%Temp%\*") do (
  set NewFileName=%%~na
  set NewFileName=!NewFileName:~0,10!%%~xa
  ren "%%~a" !NewFileName!.jpg
)

move %Temp%\* %Dest%
rmdir %Temp%
cd %Dest%
for %%a in (%trash%) do del %Dest%\%%a

set i=0
for %%a in (%original%) do set /A i+=1 & set original[!i!]=%%a
set i=0
for %%b in (%small%) do set /A i+=1 & set small[!i!]=%%b
set n=%i%
for /L %%i in (1,1,%n%) do (
  echo Pair %%i- !original[%%i]! renamed to !small[%%i]!
  move !original[%%i]! !small[%%i]!
)

set /p input=[Do you want to open the Spotlight folder? (y/n)]
if %input%==y (
  %SystemRoot%\explorer.exe %Dest%
) else (
  echo "Have a nice day!"
)

pause >nul
