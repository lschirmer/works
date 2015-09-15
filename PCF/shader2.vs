#version 330 core

layout(location = 0) in vec3 vertexPosition_modelspace;
layout(location = 2) in vec3 vertexNormal_modelspace;

out vec3 Position_worldspace;
out vec3 Normal_cameraspace;
out vec3 EyeDirection_cameraspace;
out vec3 LightDirection_cameraspace;
out vec4 ShadowCoord;

uniform mat4 MVP;
uniform mat4 V;
uniform mat4 M;
uniform vec3 LightInvDirection_worldspace;
uniform mat4 DepthBiasMVP;


void main(){	
	gl_Position =  MVP * vec4(vertexPosition_modelspace,1);
	ShadowCoord = DepthBiasMVP * vec4(vertexPosition_modelspace,1);
	Position_worldspace = (M * vec4(vertexPosition_modelspace,1)).xyz;
	EyeDirection_cameraspace = vec3(0,0,0) - ( V * M * vec4(vertexPosition_modelspace,1)).xyz;
	LightDirection_cameraspace = (V*vec4(LightInvDirection_worldspace,0)).xyz;
	Normal_cameraspace = ( V * M * vec4(vertexNormal_modelspace,0)).xyz;
}

