//
//  FloorProgram.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "FloorProgram.h"

@implementation FloorProgram

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        char* vertexShaderSource =
        "uniform mat4 transform;\n"
        "uniform vec3 position;\n"
        "\n"
        "attribute vec3 vertex;\n"
        "attribute vec4 color;\n"
        "\n"
        "varying vec3 fragmentVertex;\n"
        "varying vec4 fragmentColor;\n"
        "\n"
        "void main()\n"
        "{\n"
        "  fragmentVertex = vertex;\n"
        "  gl_Position = transform * vec4(vertex + position, 1);\n"
        "  fragmentColor = color;"
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
        "\n"
        "void main()\n"
        "{\n"
        "  if (fragmentVertex.x - floor(fragmentVertex.x) < 0.01 || fragmentVertex.z - floor(fragmentVertex.z) < 0.01)"
        "  {\n"
        "    float depth = gl_FragCoord.z / gl_FragCoord.w;\n"
        "    gl_FragColor = max(0.0, (9.0 - depth) / 9.0) * vec4(1, 1, 1, 1) + min(1.0, depth / 9.0) * fragmentColor;\n"
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
        self.vertex = glGetAttribLocation(self.program, "vertex");
        self.color = glGetAttribLocation(self.program, "color");
    }
    return self;
}
@end
