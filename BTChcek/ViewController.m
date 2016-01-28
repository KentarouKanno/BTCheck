//
//  ViewController.m
//  BTChcek
//
//  Created by KentarOu on 2015/10/01.
//  Copyright © 2015年 KentarOu. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate>

@end

@interface ViewController () {
    int count;
}
@property (nonatomic) CBCentralManager *bluetoothManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], CBCentralManagerOptionShowPowerAlertKey, nil];
    
    _bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];
    [_bluetoothManager scanForPeripheralsWithServices:nil options:options];

    [super viewDidLoad];
}

- (IBAction)detectBluetoothb {
    [self centralManagerDidUpdateState:self.bluetoothManager];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    count = 0;
    NSString *stateString = nil;
    switch(_bluetoothManager.state) {
            
        case CBCentralManagerStateResetting: stateString = @"The connection with the system service was momentarily lost, update imminent."; break;
        case CBCentralManagerStateUnsupported: stateString = @"The platform doesn't support Bluetooth Low Energy."; break;
        case CBCentralManagerStateUnauthorized: stateString = @"The app is not authorized to use Bluetooth Low Energy."; break;
        case CBCentralManagerStatePoweredOff: stateString = @"Bluetooth is currently powered off."; break;
        case CBCentralManagerStatePoweredOn: stateString = @"Bluetooth is currently powered on and available to use."; break;
        default:
        {
            count = 1;
            stateString = @"State unknown, update imminent.";
            break;
        }
    }
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Bluetooth state" message:stateString preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
