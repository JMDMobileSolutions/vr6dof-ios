//
//  ViewController.m
//  CubeHunt
//
//  Created by Heriberto Delgado on 3/16/19.
//  Copyright © 2019 Heriberto Delgado. All rights reserved.
//

#import "ViewController.h"
#include "Renderer.h"
#import <ARKit/ARKit.h>

@interface ViewController () <ARSessionDelegate>

@end

@implementation ViewController
{
    Renderer* renderer;
    ARSession* session;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    renderer = [[Renderer alloc] init];
    GVRRendererViewController* child = [[GVRRendererViewController alloc] initWithRenderer:renderer];
    child.rendererView.VRModeEnabled = YES;
    child.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:child.view];
    [self addChildViewController:child];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:child.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:child.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:child.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:child.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    ARWorldTrackingConfiguration* configuration = [[ARWorldTrackingConfiguration alloc] init];
    session = [[ARSession alloc] init];
    session.delegate = self;
    [session runWithConfiguration:configuration];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame
{
    [renderer updateTransform:frame.camera.transform isTracking:(frame.camera.trackingState == ARTrackingStateNormal)];
}

@end
