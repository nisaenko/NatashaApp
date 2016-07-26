//
//  AddBuilderViewController.m
//  NatashaApp
//
//  Created by Natasha Isaenko on 2015-03-05.
//  Copyright (c) 2015 Natasha Isaenko. All rights reserved.
//

#import "AddBuilderViewController.h"
#import "Company+AddCompany.h"

@interface AddBuilderViewController ()

@end

@implementation AddBuilderViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0) {
        [self takePicture];
    }
}
#pragma mark - button selectors


- (IBAction)cancelButton:(id)sender
{
    [self.delegate addBuilderViewControllerDidCancel:self];
    
}

- (IBAction)doneButton:(id)sender
{
    Company *company = [Company addCompanyWithBuilderName:self.builderName.text BuilderAddress:self.builderAddress.text
                                              phoneNumber:self.phone.text
                                              andPrice:self.price.text
                                              andPicture:self.picture.image
                                              intoDatbase:self.database];
    
    [self.delegate addBuilderViewControllerDidAddBuilder:self didAddBuilder:company];
}

-(void)takePicture
{
    UIActionSheet *act = nil;
    
    //  action  when user  choose for picture open  cancelbutton
    act = [[UIActionSheet alloc] initWithTitle:@""
                                         delegate:self
                                cancelButtonTitle:@"Cancel"
                           destructiveButtonTitle:nil
                                otherButtonTitles:@"Choose Photo", @"Edit Photo", nil];
    
    act.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [act showFromRect:self.picture.frame inView:self.view animated:YES];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    BOOL cCancel = NO;
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.allowsEditing = YES;
    
    switch (buttonIndex)
    {        case 0: // exist picture
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        }
        case 1: // edit picture
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                photoPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            break;
        }
        default:
            // cancel
            cCancel = YES;
            break;
    }
    if ( !cCancel )
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
