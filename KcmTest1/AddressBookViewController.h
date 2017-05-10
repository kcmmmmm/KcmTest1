//
//  AddressBookViewController.h
//  KcmTest1
//
//  Created by openobject on 2017. 4. 18..
//  Copyright © 2017년 kcm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface AddressBookViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lbPhoneNumber;

- (IBAction)showPicker:(id)sender;

@end
