//
//  ViewController.m
//  CloseToHomeApp
//
//  Created by Asher Rosenblatt on 8/6/15.
//  Copyright (c) 2015 Asher Rosenblatt. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "ResultsViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property NSString *urlString;
@property NSArray *organizedData;
@property NSDictionary *openRawData;
@property (weak, nonatomic) IBOutlet UISwitch *babySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *childSwitch;
@property NSString *quillStory;
@property (weak, nonatomic) IBOutlet UISwitch *teenSwitch;
@property (weak, nonatomic) IBOutlet UITextField *zipField;
@property (strong, nonatomic) UIImageView *loadingPage;
@property (strong, nonatomic) UIActivityIndicatorView *loadingIndicator;
@property NSDictionary *placesDic;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.loadingPage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"load"]];
    [self.loadingPage setContentMode:UIViewContentModeScaleToFill];
    [self.loadingPage setFrame:self.view.frame];
    [self.loadingPage setBounds:self.view.bounds];
    self.loadingIndicator = [UIActivityIndicatorView new];
    [self.loadingIndicator setFrame:self.view.frame];
}

-(BOOL)textFieldShouldReturn:(nonnull UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(NSArray *)pullOpenData:(NSString *)urlString
{
    NSData *openData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSArray *openRawData = [NSJSONSerialization JSONObjectWithData:openData options:NO error:nil];
    return openRawData;
}

-(NSArray *)pullParks:(NSString *)zip
{
    NSArray *parks = [self pullOpenData:@"https://data.cityofchicago.org/resource/wwy2-k7b3.json"];
    NSMutableArray *modParks = [NSMutableArray new];
    for (NSDictionary *park in parks)
    {
        if ([park[@"zip"] isEqualToString:zip]) {
            NSMutableDictionary *modPark = [NSMutableDictionary new];
            modPark[@"park_name"] = park[@"park_name"];
            modPark[@"zip"] = park[@"zip"];
            modPark[@"street_address"] = park[@"street_address"];
            modPark[@"dog_friendly"] = park[@"dog_friendly"];
            modPark[@"playground_park"] = park[@"playground_park"];
            modPark[@"fitness_center"] = park[@"fitness_center"];
            modPark[@"pool_outdoor"] =  park[@"pool_outdoor"];
            modPark[@"basketball_courts"] = park[@"basketball_courts"];
            modPark[@"baseball_jr_softball_t_ball"] = park[@"baseball_jr_softball_t_ball"];
            modPark[@"community_garden"] =  park[@"community_garden"];
            [modParks addObject:modPark];
        }
    }
    return modParks;
}

-(NSArray *)pullHighSchools:(NSString *)zip
{
    NSArray *schools = [self pullOpenData:@"https://data.cityofchicago.org/resource/2m8w-izji.json"];
    NSMutableArray *modSchools = [NSMutableArray new];
    for (NSDictionary *school in schools)
    {
        if ([school[@"zip"] isEqualToString:zip]) {
            NSMutableDictionary *modSchool = [NSMutableDictionary new];
            modSchool[@"safe"] = school[@"safe"];
            modSchool[@"name_of_school"] = school[@"name_of_school"];
            modSchool[@"location"] = school[@"location"];
            modSchool[@"street_address"] = school[@"street_address"];
            modSchool[@"zip_code"] = school[@"zip"];
            modSchool[@"website"] = school[@"website"];
            modSchool[@"effective_leaders"] = school[@"effective_leaders"];
            modSchool[@"_4_year_graduation_rate_percentage_2013"] =  school[@"_4_year_graduation_rate_percentage_2013"];
            [modSchools addObject:modSchool];
        }
    }
    return modSchools;
}

-(NSArray *)pullElemantarySchools:(NSString *)zip
{
    NSArray *schools = [self pullOpenData:@"https://data.cityofchicago.org/resource/tj8h-mnuv.json"];
    NSMutableArray *modSchools = [NSMutableArray new];
    for (NSDictionary *school in schools)
    {
        if ([school[@"zip"] isEqualToString:zip]) {
            NSMutableDictionary *modSchool = [NSMutableDictionary new];
            modSchool[@"safe"] = school[@"safe"];
            modSchool[@"name_of_school"] = school[@"name_of_school"];
            modSchool[@"location"] = school[@"location"];
            modSchool[@"street_address"] = school[@"street_address"];
            modSchool[@"zip_code"] = school[@"zip_code"];
            modSchool[@"website"] = school[@"website"];
            modSchool[@"effective_leaders"] = school[@"effective_leaders"];
            modSchool[@"student_attendance_percentage_2013"] =  school[@"student_attendance_percentage_2013"];
            [modSchools addObject:modSchool];
        }
    }
    return modSchools;
}

-(NSArray *)pullEarlyChildhoodPrograms:(NSString *)zip
{
    NSArray *schools = [self pullOpenData:@"https://data.cityofchicago.org/resource/ck29-hb9r.json"];
    NSMutableArray *modSchools = [NSMutableArray new];
    for (NSDictionary *school in schools)
    {
        if ([school[@"zip"] isEqualToString:zip]) {
            NSMutableDictionary *modSchool = [NSMutableDictionary new];
            modSchool[@"weekday_availability"] = school[@"weekday_availability"];
            modSchool[@"site_name"] = school[@"site_name"];
            modSchool[@"location"] = school[@"location"];
            modSchool[@"street_address"] = school[@"address"];
            modSchool[@"zip_code"] = school[@"zip"];
            modSchool[@"url"] = school[@"url"];
            modSchool[@"duration_hours"] = school[@"duration_hours"];
            modSchool[@"program_information"] =  school[@"program_information"];
            modSchool[@"quality_rating"] = school[@"quality_rating"];
            [modSchools addObject:modSchool];
        }
    }
    return modSchools;
}

- (BOOL)validZip :(NSString *)userZip
{
    NSArray *zips = @[@"60618", @"60068", @"60176", @"60601", @"60602", @"60603", @"60604", @"60605", @"60606", @"60607", @"60608", @"60609", @"60610", @"60611", @"60612", @"60613", @"60614", @"60615", @"60616", @"60617", @"60618", @"60619", @"60620", @"60621", @"60622", @"60623", @"60624", @"60625", @"60626", @"60628", @"60630", @"60631", @"60632", @"60634", @"60636", @"60637", @"60639", @"60640", @"60641", @"60642", @"60643", @"60644", @"60645", @"60646", @"60647", @"60649", @"60651", @"60652", @"60653", @"60654", @"60655", @"60656", @"60657", @"60659", @"60660", @"60661", @"60706", @"60707", @"60714"];
    for (NSString *zip in zips)
    {
        if ([userZip isEqualToString:zip]) {
            return true;
        }
    }
    return false;
}

-(NSData *)pullAllData:(NSString *)zip :(NSString *)personna
{
    NSMutableDictionary *allData = [NSMutableDictionary new];
    if (![self validZip:zip]) {
        allData[@"error"] = @"zip_not_in_chicago";
    }
    allData[@"personna"] = personna;
    allData[@"parks"] = [self pullParks:zip];
    allData[@"highSchools"] = [self pullHighSchools:zip];
    allData[@"elementarySchools"] = [self pullElemantarySchools:zip];
    allData[@"earlyChildHoodPrograms"] = [self pullEarlyChildhoodPrograms:zip];
    self.placesDic = allData;
    return [NSJSONSerialization dataWithJSONObject:allData options:NO error:nil];
}


-(void)getQuillStory :(NSString *)zip :(NSString *)personna
{
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"https://api.narrativescience.com/v4/editorial/55b135718ff57d597c2fb6e6/story/"]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json"
   forHTTPHeaderField:@"content-type"];
    [request setValue:@"json"
   forHTTPHeaderField:@"x-ns-accepts"];
    [request setValue:@"55b13546374bb105eefa0d69"
   forHTTPHeaderField:@"x-ns-api-token"];
    [request setValue:@"55b1357a8ff57d597c2fb6f6"
   forHTTPHeaderField:@"x-ns-template"];
    
    [request setHTTPBody:[self pullAllData:zip :personna]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * __nullable response, NSData * __nullable data, NSError * __nullable connectionError) {
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.quillStory = [json objectAtIndex:0][@"content"];
        [self.loadingPage removeFromSuperview];
        [self.loadingIndicator stopAnimating];
        [self.loadingIndicator removeFromSuperview];
        [self performSegueWithIdentifier:@"results" sender:self];
    }];
}


- (IBAction)onSearchPressed:(id)sender
{
    
    if ([self.zipField.text isEqualToString:@""] || !(self.babySwitch.isOn||self.childSwitch.isOn||self.teenSwitch.isOn))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Enough Info!" message:@"It looks like you forgot something. Please try again." delegate:nil cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self.view addSubview:self.loadingPage];
        [self.view addSubview:self.loadingIndicator];
        [self.loadingIndicator setHidden:NO];
        [self.loadingIndicator startAnimating];
        
        NSMutableString *personnaString = [NSMutableString new];
        if (self.babySwitch.isOn)
        {
            [personnaString appendString:@"baby"];
        }
        if (self.childSwitch.isOn)
        {
            [personnaString appendString:@"child"];
        }
        if (self.teenSwitch.isOn)
        {
            [personnaString appendString:@"teen"];
        }
        [self getQuillStory:self.zipField.text :personnaString];
    }
}

- (IBAction)onBabySelected:(id)sender
{
    [self.childSwitch setOn:NO];
    [self.teenSwitch setOn:NO];
}

- (IBAction)onChildSelected:(id)sender
{
    [self.babySwitch setOn:NO];
    [self.teenSwitch setOn:NO];
}

- (IBAction)onTeenSelected:(id)sender
{
    [self.babySwitch setOn:NO];
    [self.childSwitch setOn:NO];
}


-(void) prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender
{
    ResultsViewController *vc = segue.destinationViewController;
    vc.quillStory = self.quillStory;
    vc.zipCode = self.zipField.text;
    vc.placesDictionary = self.placesDic;
}


@end
