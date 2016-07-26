//
//  UpdateBuilderViewController.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-06.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "UpdateBuilderViewController.h"

@interface UpdateBuilderViewController ()

@end

@implementation UpdateBuilderViewController

{
    Company *_company;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _company = self.company;
    
    if (_company)
    {
        self.builderName.text = _company.bname;
        self.builderAddress.text = _company.adr;
        self.phoneNumber.text = _company.phone;
        self.price.text = _company.price;
        self.picture.image = _company.picture;}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.builderName becomeFirstResponder];
}
#pragma mark - Table view data source



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        [self takePicture];
    }
}

- (IBAction)save:(id)sender

{
    if (_company) {
        _company.bname = self.builderName.text;
        _company.adr = self.builderAddress.text;
        _company.phone = self.phoneNumber.text;
        _company.price = self.price.text;
        _company.picture = self.picture.image;
}
        [self.delegate updateBuilderViewControllerDidUpdate:self withCompany:_company];

}

- (IBAction)cancel:(id)sender
{
    [self.delegate updateBuilderViewControllerDidCancel:self];
}

-(void)takePicture
{
    UIActionSheet *act = nil;
    act = [[UIActionSheet alloc] initWithTitle:@""
                                         delegate:self
                                cancelButtonTitle:@"Cancel"
                           destructiveButtonTitle:nil
                                otherButtonTitles: @"Choose Photo", @"Edit Photo", nil];
    
    act.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    if ([self.builderName isFirstResponder]) {
        [self.builderName resignFirstResponder];
    }
    if ([self.builderAddress isFirstResponder]) {
        [self.builderAddress resignFirstResponder];
    }
    if ([self.phoneNumber isFirstResponder]) {
        [self.phoneNumber resignFirstResponder];
    }
    if ([self.price isFirstResponder]) {
        [self.price resignFirstResponder];
    }
    [act showFromRect:self.picture.frame inView:self.view animated:YES];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL bCancel = NO;
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.allowsEditing = YES;
    
    switch (buttonIndex)
    {
                case 0:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        }
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                photoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            break;
        }
        default:
            // cancel
            bCancel = YES;
            break;
    }
    if ( !bCancel )
    {
        [self presentViewController:photoPicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = (UIImage *)[info valueForKey:UIImagePickerControllerEditedImage];
    if ( selectedImage != nil )
    {
        self.picture.image = selectedImage;
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
