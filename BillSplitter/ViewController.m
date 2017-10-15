//
//  ViewController.m
//  BillSplitter
//
//  Created by Sanjay Shah on 2017-10-14.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *noOfPeoplePicker;

@property (weak, nonatomic) IBOutlet UILabel *splitAmountLabel;

@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;

@property (weak, nonatomic) IBOutlet UISlider *tipAmountSlider;

@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property NSArray *noOfPeopleArray;

@property float defaultTip;
@property float splitAmount;



@end

@implementation ViewController


- (IBAction)tipSlider:(UISlider *)sender {
    
    float tipAmount = sender.value;
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%.02f", tipAmount];
    
    [self autoCalculateTip];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tipPercentageTextField.delegate = self;
    self.billAmountTextField.delegate = self;
    
    self.noOfPeopleArray = [NSArray arrayWithObjects:@1, @2, @3, @4, @5, @6, @7, @8, nil];
    
    self.noOfPeoplePicker.dataSource = self;
    self.noOfPeoplePicker.delegate = self;
    
    self.defaultTip = 15.0;
    self.splitAmount = 0;
    
    
    
}

- (IBAction)splitBill:(UIButton *)sender {
    
    [self autoCalculate];
    [self autoCalculateTip];
    //make keyboard disappear
    [self.billAmountTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];

}

-(void) autoCalculate {
    
    float billAmount = [self.billAmountTextField.text floatValue];
    float noOfPeople = [self.noOfPeoplePicker selectedRowInComponent:0] + 1;
    NSLog(@"%f", noOfPeople);
    self.splitAmount = billAmount/noOfPeople;
    
    self.splitAmountLabel.text = [NSString stringWithFormat:@"Each owes: $%.02f", self.splitAmount];

    
    // NSInteger billAmountNumber = [NSNumberFormatter self.billAmount ];
    
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.noOfPeopleArray.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@",  self.noOfPeopleArray[row]];
            
}

-(void) billAmountTextFieldDidBeginEditing: (UITextField*) billAmountTextField {
    
    if (self.billAmountTextField.isFirstResponder == true) {
        billAmountTextField.placeholder = nil;
        
    }
}

-(void) tipPercentageTextFieldDidBeginEditing: (UITextField*) tipPercentageTextField {
    
    if (self.tipPercentageTextField.isFirstResponder == true) {
        tipPercentageTextField.placeholder = nil;
    }
}


-(void) autoCalculateTip {
    
    if (self.tipPercentageTextField.text.length < 1){
        
       
        float tipAmount = (self.splitAmount * (self.defaultTip/100));
        
        self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.02f", tipAmount];
    }
    
    else{
        
        
        float tipPercent = [self.tipPercentageTextField.text floatValue];
        
        float tipAmount = (self.splitAmount * (tipPercent/100));
        
        self.tipAmountLabel.text = [NSString stringWithFormat:@"Each Tip: $%.02f", tipAmount];
    }
    
}




// fires when the return key is tapped which allows us to respond accordingly
-(BOOL) textFieldShouldReturn:(UITextField*)  textField {
    
    [textField resignFirstResponder];
    [self autoCalculate];
    [self autoCalculateTip];
    
    return true;
}


// fires when the clear button is about to fire
- (BOOL)textFieldShouldClear:(UITextField *) textField {
    
    if (textField == self.tipPercentageTextField)
    {
        NSLog(@"In textFieldShouldClear:");
        self.defaultTip = 15.0;
        textField.text = @"";
        //    [self.tipPercentageTextField.text isEqualToString:@""];
        //    [self.billAmountTextField.text isEqualToString:@""];
    }
    [self autoCalculate];
    [self autoCalculateTip];
    
    return true;
}



-(void) clearAllFields{
    self.billAmountTextField.text = @"";
    self.tipPercentageTextField.text = @"";
}




@end
