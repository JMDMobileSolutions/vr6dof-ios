//
//  CubeProgram.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "CubeProgram.h"

@implementation CubeProgram

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        char* vertexShaderSource =
        "uniform mat4 transform;\n"
        "uniform vec3 position;\n"
        "uniform float focused;\n"
        "\n"
        "attribute vec3 vertex;\n"
        "attribute vec4 color;\n"
        "\n"
        "varying vec3 fragmentVertex;\n"
        "varying vec4 fragmentColor;\n"
        "varying float fragmentFocused;\n"
        "\n"
        "void main()\n"
        "{\n"
        "  fragmentVertex = vertex;\n"
        "  gl_Position = transform * vec4(vertex + position, 1);\n"
        "  fragmentColor = color;"
        "  fragmentFocused = focused;"
        "}\n";
        GLuint vertexShader = [self loadShader:GL_VERTEX_SHADER withSource:vertexShaderSource];
        if (vertexShader == 0)
        {
            return self;
        }
        char* fragmentShaderSource =
        "precision mediump float;\n"
        "\n"
        "varying vec3 fragmentVertex;\n"
        "varying vec4 fragmentColor;\n"
        "varying float fragmentFocused;\n"
        "\n"
        "void main()\n"
        "{\n"
        "  if (fragmentFocused != 0.0)"
        "  {\n"
        "    int borderCount = 0;"
        "    if (abs(fragmentVertex.x) > 0.95)"
        "    {"
        "       borderCount++;"
        "    }\n"
        "    if (abs(fragmentVertex.y) > 0.95)"
        "    {"
        "       borderCount++;"
        "    }\n"
        "    if (abs(fragmentVertex.z) > 0.95)"
        "    {"
        "       borderCount++;"
        "    }\n"
        "    if (borderCount >= 2)"
        "    {\n"
        "      gl_FragColor = vec4(1, 1, 1, 1);\n"
        "    }\n"
        "    else\n"
        "    {\n"
        "      gl_FragColor = fragmentColor + vec4(0.5, 0.5, 0.5, 0.5);\n"
        "    }\n"
        "  }\n"
        "  else\n"
        "  {\n"
        "    gl_FragColor = fragmentColor;\n"
        "  }\n"
        "}\n";
        GLuint fragmentShader = [self loadShader:GL_FRAGMENT_SHADER withSource:fragmentShaderSource];
        if (fragmentShader == 0)
        {
            glDeleteShader(vertexShader);
            return self;
        }
        self.program = [self linkVertexShader:vertexShader andFragmentShader:fragmentShader];
        if (self.program == 0)
        {
            glDeleteShader(fragmentShader);
            glDeleteShader(vertexShader);
            return self;
        }
        self.transform = glGetUniformLocation(self.program, "transform");
        self.position = glGetUniformLocation(self.program, "position");
        self.focused = glGetUniformLocation(self.program, "focused");
        self.vertex = glGetAttribLocation(self.program, "vertex");
        self.color = glGetAttribLocation(self.program, "color");
    }
    return self;
}
@end
