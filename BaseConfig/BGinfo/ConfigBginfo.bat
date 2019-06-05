@echo on

del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"\Bginfo.*

xcopy /Y "C:\Users\Administrator\Desktop\BaseConfig\BGinfo\Bginfo.exe" "C:\Windows\"
xcopy /Y "C:\Users\Administrator\Desktop\BaseConfig\BGinfo\bginfo.bgi" "C:\Windows\"
xcopy /Y "C:\Users\Administrator\Desktop\BaseConfig\BGinfo\Bginfo.lnk" "C:\Users\All Users\Microsoft\Windows\Start Menu\Programs\StartUp\"

"C:\Users\All Users\Microsoft\Windows\Start Menu\Programs\StartUp\Bginfo.lnk"





