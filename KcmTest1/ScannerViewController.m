//
//  ScannerViewController.m
//  KcmTest1
//
//  Created by wimz-kcm on 2017. 7. 7..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import "ScannerViewController.h"

@interface ScannerViewController ()

@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _captureSession = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![_captureSession isRunning]) {
        [self startReading];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if ([_captureSession isRunning]) {
        [_captureSession stopRunning];
    }
    
    [_videoPreviewLayer removeFromSuperlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)startReading {
    NSError *error;
    
    AVCaptureDevice *captuerDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captuerDevice error:&error];
    
    if (!input) {
        NSLog(@"%@", error.localizedDescription);
        return;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeEAN13Code]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer  setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_scanView.layer.bounds];
    [_scanView.layer addSublayer:_videoPreviewLayer];
    
    [_captureSession startRunning];
}

- (void)stopReading:(NSString *)scanData {
    [_captureSession stopRunning];
    _captureSession = nil;
    
    _scanNumLabel.text = scanData;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
//    if (metadataObjects != nil && [metadataObjects count] > 0) {
//        
//        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
//       
//        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode] || [[metadataObj type] isEqualToString:AVMetadataObjectTypeCode128Code] || [[metadataObj type] isEqualToString:AVMetadataObjectTypeEAN13Code]) {
//            
//            [self performSelectorOnMainThread:@selector(stopReading:) withObject:[metadataObj stringValue] waitUntilDone:NO];
//
//        }
//    }
    
    for (AVMetadataObject *metadata in metadataObjects) {
        
        AVMetadataMachineReadableCodeObject *object = (AVMetadataMachineReadableCodeObject *)metadata;
        
        [self performSelectorOnMainThread:@selector(stopReading:) withObject:[object stringValue] waitUntilDone:NO];

        NSLog(@"object.type : %@, object.stringValue : %@", object.type, object.stringValue);
    }
}

#pragma mark - IBAction

- (IBAction)touchUpInsideReScan:(id)sender {
    
    if (![_captureSession isRunning]) {
        _scanNumLabel.text = @"";
        [self startReading];
    }
}

@end
