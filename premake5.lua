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
IncludeDir["ImGui"] = "Hazel/vendor/imgui"
IncludeDir["glm"] = "Hazel/vendor/glm"


group "Dependencies"
	include "Hazel/vendor/GLFW"
	include "Hazel/vendor/Glad"
	include "Hazel/vendor/imgui"
group ""

project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" ..outputdir.. "/%{prj.name}")
	objdir ("bin-int/" ..outputdir.. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazel/src/hzpch.cpp"


	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl",
	}

	includedirs{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}"
	}

	links{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib",
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"

		defines{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands{
			("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
		}
		buildoptions {
			"/utf-8",
		}

	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "On"
		buildoptions {
			"/utf-8",
			"/MDd"
		}

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "On"
		buildoptions {
			"/utf-8",
			"/MD"
		}

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "On"
		buildoptions {
			"/utf-8",
			"/MD"
		}

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" ..outputdir.. "/%{prj.name}")
	objdir ("bin-int/" ..outputdir.. "/%{prj.name}")

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}
	includedirs{
		"Hazel/vendor/spdlog/include",
		"Hazel/src",
		"%{IncludeDir.glm}"
	}

	links{
		"Hazel"
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"
		defines{
			"HZ_PLATFORM_WINDOWS",
		}
		buildoptions {
			"/utf-8",
		}
	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		buildoptions {
			"/utf-8",
			"/MDd"
		}
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		buildoptions {
			"/utf-8",
			"/MD"
		}
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		buildoptions {
			"/utf-8",
			"/MD"
		}
		optimize "On"