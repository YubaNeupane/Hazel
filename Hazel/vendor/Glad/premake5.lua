project "Glad"
    kind "StaticLib"
    staticruntime "On"
    language "C"
    
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    files
    {
        "include/glad/glad.h",
        "include/KHR/khrplatform.h",
        "src/glad.c"
    }
	includedirs
	{
		"include"
	}
    
    filter "system:windows"
        systemversion "latest"
        
		runtime "Debug"
		buildoptions {
			"/utf-8",
		}
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		buildoptions {
			"/utf-8",
		}
		optimize "on"

	filter "configurations:Dist"
		runtime "Release"
		buildoptions {
			"/utf-8",
		}
		optimize "on"
