//
//  Renderer.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "Renderer.h"
#import "CubeProgram.h"
#import "FloorProgram.h"
#import "CubeBuffer.h"
#import "CubeColorBuffer.h"
#import "FloorBuffer.h"
#import "FloorColorBuffer.h"

@implementation Renderer
{
    CubeProgram* cubeProgram;
    FloorProgram* floorProgram;
    CubeBuffer* cubeBuffer;
    CubeColorBuffer* cubeColorBuffer;
    FloorBuffer* floorBuffer;
    FloorColorBuffer* floorColorBuffer;
    GLKVector3 cubePosition;
    GLKVector3 floorPosition;
    BOOL focused;
    GLKVector3 position;
    BOOL isTracking;
    GLKVector3 offset;
}

-(void)relocateCube
{
    float distance = 3 + (float)(drand48() * 5);
    float azimuth = (float)(drand48() * 2 * M_PI);
    float elevation = (float)(drand48() * M_PI / 2) - M_PI / 8;
    cubePosition.x = -cos(elevation) * sin(azimuth) * distance;
    cubePosition.y = sin(elevation) * distance;
    cubePosition.z = -cos(elevation) * cos(azimuth) * distance;
}

-(void)initializeGl
{
    [super initializeGl];
    
    cubeProgram = [[CubeProgram alloc] init];
    floorProgram = [[FloorProgram alloc] init];
    cubeBuffer = [[CubeBuffer alloc] init];
    cubeColorBuffer = [[CubeColorBuffer alloc] init];
    floorBuffer = [[FloorBuffer alloc] init];
    floorColorBuffer = [[FloorColorBuffer alloc] init];
    
    floorPosition = GLKVector3Make(0, -1.7, 0);
    
    srand48(time(0));
    
    [self relocateCube];
}

-(void)update:(GVRHeadPose*)headPose
{
    GLKMatrix4 head = GLKMatrix4Invert([headPose headTransform], nil);
    GLKVector4 direction = GLKMatrix4MultiplyVector4(head, GLKVector4Make(0, 0, -1, 1));
    GLKVector4 position = GLKVector4Make(self->position.x, self->position.y, self->position.z, 1);
    focused = [cubeBuffer isFocusedInDirection:direction atPosition:position andCubePosition:cubePosition];
    glClearColor(0, 0, 0, 1);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_SCISSOR_TEST);
}

-(void)draw:(GVRHeadPose *)headPose
{
    CGRect viewport = [headPose viewport];
    glViewport(viewport.origin.x, viewport.origin.y, viewport.size.width, viewport.size.height);
    glScissor(viewport.origin.x, viewport.origin.y, viewport.size.width, viewport.size.height);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    GLKMatrix4 projection = [headPose projectionMatrixWithNear:0.1 far:100];
    GLKMatrix4 eye = [headPose eyeTransform];
    GLKMatrix4 head = [headPose headTransform];
    GLKMatrix4 body = GLKMatrix4MakeTranslation(-position.x, -position.y, -position.z);
    GLKMatrix4 transform = GLKMatrix4Multiply(projection, GLKMatrix4Multiply(eye, GLKMatrix4Multiply(head, body)));

    glUseProgram(cubeProgram.program);
    
    glUniform3fv(cubeProgram.position, 1, cubePosition.v);
    glUniformMatrix4fv(cubeProgram.transform, 1, false, transform.m);
    glUniform1f(cubeProgram.focused, (GLfloat)focused);
    
    glBindBuffer(GL_ARRAY_BUFFER, cubeColorBuffer.buffer);
    glVertexAttribPointer(cubeProgram.color, 4, GL_FLOAT, GL_FALSE, sizeof(float) * 4, 0);
    glEnableVertexAttribArray(cubeProgram.color);
    
    glBindBuffer(GL_ARRAY_BUFFER, cubeBuffer.buffer);
    glVertexAttribPointer(cubeProgram.vertex, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 3, 0);
    glEnableVertexAttribArray(cubeProgram.vertex);
    
    glDrawArrays(GL_TRIANGLES, 0, cubeBuffer.length);
    
    glDisableVertexAttribArray(cubeProgram.vertex);
    glDisableVertexAttribArray(cubeProgram.color);
    
    glUseProgram(floorProgram.program);
    
    glUniform3fv(floorProgram.position, 1, floorPosition.v);
    glUniformMatrix4fv(floorProgram.transform, 1, false, transform.m);
    
    glBindBuffer(GL_ARRAY_BUFFER, floorColorBuffer.buffer);
    glVertexAttribPointer(floorProgram.color, 4, GL_FLOAT, GL_FALSE, sizeof(float) * 4, 0);
    glEnableVertexAttribArray(floorProgram.color);
    
    glBindBuffer(GL_ARRAY_BUFFER, floorBuffer.buffer);
    glVertexAttribPointer(floorProgram.vertex, 3, GL_FLOAT, GL_FALSE, sizeof(float) * 3, 0);
    glEnableVertexAttribArray(floorProgram.vertex);
    
    glDrawArrays(GL_TRIANGLES, 0, floorBuffer.length);
    
    glDisableVertexAttribArray(floorProgram.vertex);
    glDisableVertexAttribArray(floorProgram.color);
}

-(BOOL)handleTrigger
{
    if (focused)
    {
        [self relocateCube];
    }
    return YES;
}

-(void)addToHeadRotationYaw:(CGFloat)yaw andPitch:(CGFloat)pitch
{
    // Do nothing. This is to disable manual tracking.
}

-(void)updateTransform:(simd_float4x4)transform isTracking:(BOOL)isTracking
{
    if (isTracking)
    {
        if (self->isTracking)
        {
            position = GLKVector3Make(transform.columns[3][0] + offset.x, transform.columns[3][1] + offset.y, transform.columns[3][2] + offset.z);
        }
        else
        {
            offset = GLKVector3Make(transform.columns[3][0] - offset.x, transform.columns[3][1] - offset.y, transform.columns[3][2] - offset.z);
        }
    }
    self->isTracking = isTracking;
}
@end
