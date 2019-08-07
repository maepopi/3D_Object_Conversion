set blenderPath=..\Blender\blender.exe
set conversion_script=..\Blender\2.79\scripts\addons\object_convert.py


for %%I in (%1) do set name=%%~nxI

mkdir %1\..\..\Output\%name%

set inputFullPath=%1

set outputFullPath=%1\..\..\Output\%name%


if exist "%inputFullPath%\%name%.obj" goto:obj
if exist "%inputFullPath%\%name%.fbx" goto:fbx
if exist "%inputFullPath%\%name%.gltf" goto:gltf
if exist "%inputFullPath%\%name%.glb" goto:glb
if exist "%inputFullPath%\%name%.stl" goto:stl
if exist "%inputFullPath%\%name%.ply" goto:ply
if exist "%inputFullPath%\%name%.3ds" goto:3ds
if exist "%inputFullPath%\%name%.dae" goto:dae


:obj
set object_extension=obj
goto:object_extension_done

:fbx
set object_extension=fbx
goto:object_extension_done

:gltf
set object_extension=gltf
goto:object_extension_done

:glb
set object_extension=glb
goto:object_extension_done

:stl
set object_extension=stl
goto:object_extension_done

:ply
set object_extension=ply
goto:object_extension_done

:3ds
set object_extension=3ds
goto:object_extension_done

:dae
set object_extension=dae
goto:object_extension_done


:object_extension_done
echo object extension is %object_extension%

if exist "%inputFullPath%\%name%.jpg" goto:jpg
if exist "%inputFullPath%\%name%.jpeg" goto:jpeg
if exist "%inputFullPath%\%name%.png" goto:png

:jpg
set image_extension=jpg
goto:image_extension_done

:jpeg
set image_extension=jpeg
goto:image_extension_done

:png
set image_extension=png
goto:image_extension_done

:image_extension_done
echo image_extension is %image_extension%


REM BASIC VARIABLES

set inPath=%1\%name%.%object_extension%
set colorPath=%1\%name%.%image_extension%

REM For now, the output file won't have any indication on the texture resolution. As it is supposed to not be changed or having be changed before, we ought to record the resolution somewhere so that it is always displayed on the object name. 
REM set diffuse_resolution=512
REM set normal_resolution=512
REM set resolution_indicator=%diffuse_resolution%-%normal_resolution%

if exist "%inputFullPath%\%name%_normal.%image_extension%" (goto:normal) else (goto:notnormal)

:normal
set normalPath=%inputFullPath%\%name%_normal.%image_extension%
goto:normal_done

:notnormal
set normalPath=None
set normal_resolution=None
goto:normal_done

:normal_done
echo normalPath is %normalPath%



REM mkdir %1\..\..\Output\%name%\%resolution_indicator%\glb
mkdir %1\..\..\Output\%name%\glb

REM set outputFullPath=%1\..\..\Output\%name%\%resolution_indicator%\glb
REM set gltf_output_path=%1\..\..\Output\%name%\%resolution_indicator%

set outputFullPath=%1\..\..\Output\%name%\glb
set gltf_output_path=%1\..\..\Output\%name%\


%blenderPath% -b -P %conversion_script% -- %inPath% %object_extension% %outputFullPath% %colorPath% %normalPath% %name% %gltf_output_path%











echo The process is done ! You can close the console !

pause