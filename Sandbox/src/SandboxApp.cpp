#include <Hazel.h>
#include "imgui/imgui.h"


class ExampleLayer : public Hazel::Layer {
public:
	ExampleLayer() : Layer("Example") {

	}
	void OnUpdate() override {



	}

	virtual void OnImGuiRender() override
	{
		ImGui::Begin("Test");
		ImGui::Text("Hello World");
		ImGui::End();
	}

	void OnEvent(Hazel::Event& event) override {
		if (event.GetEventType() == Hazel::EventType::KeyPressed) {
			Hazel::KeyPressedEvent& e = (Hazel::KeyPressedEvent&)event;

		}
	}
};

class Sandbox : public Hazel::Application {
public:
	Sandbox() {
		PushLayer(new ExampleLayer());
	}
	~Sandbox() {
	}

};

Hazel::Application* Hazel::CreateApplication() {
	return new Sandbox();
}