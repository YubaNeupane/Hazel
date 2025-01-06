workspace "Hazel"
	architecture "x64"
	startproject "Sandbox"
	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Hazel/vendor/GLFW/include"
IncludeDir["Glad"] = "Hazel/vendor/Glad/include"


include "Hazel/vendor/GLFW"
include "Hazel/vendor/Glad"


project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" ..outputdir.. "/%{prj.name}")
	objdir ("bin-int/" ..outputdir.. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"


	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}"

	}

	links{
		"GLFW",
		"Glad",
		"opengl32.lib",
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" ..outputdir.. "/Sandbox")
		}
		buildoptions {
			"/utf-8",
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		symbols "On"
		buildoptions {
			"/utf-8",
			"/MDd"
		}

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"
		buildoptions {
			"/utf-8",
			"/MD"
		}

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"
		buildoptions {
			"/utf-8",
			"/MD"
		}

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" ..outputdir.. "/%{prj.name}")
	objdir ("bin-int/" ..outputdir.. "/%{prj.name}")

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}
	includedirs{
		"Hazel/vendor/spdlog/include",
		"Hazel/src"
	}

	links{
		"Hazel"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"
		defines{
			"HZ_PLATFORM_WINDOWS",
		}
		buildoptions {
			"/utf-8",
		}
	filter "configurations:Debug"
		defines "HZ_DEBUG"
		buildoptions {
			"/utf-8",
			"/MDd"
		}
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		buildoptions {
			"/utf-8",
			"/MD"
		}
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		buildoptions {
			"/utf-8",
			"/MD"
		}
		optimize "On"