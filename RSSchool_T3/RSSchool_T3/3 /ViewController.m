#import "ViewController.h"

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f and %f", self.view.frame.size.height, self.view.frame.size.width);
    
    // Creating labelResultColor
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 100, 35)];
    self.labelResultColor.text = @"Color";
    [self.view addSubview:_labelResultColor];
    
    // Creating viewResultColor
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(120, 100, 260, 35)];
    self.viewResultColor.layer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_viewResultColor];
    
    // Creating labelRed
    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 100, 35)];
    self.labelRed.text = @"RED";
    [self.view addSubview:_labelRed];
    
    // Creating textFieledRed
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(110, 170, 270, 35)];
    self.textFieldRed.layer.borderWidth = 1.0;
    self.textFieldRed.layer.cornerRadius = 5.0;
    self.textFieldRed.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.textFieldRed setPlaceholder:@"0..255"];
    [self.view addSubview:_textFieldRed];
    
    // Creating labelGreen
    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(30, 250, 100, 35)];
    self.labelGreen.text = @"GREEN";
    [self.view addSubview:_labelGreen];
    
    // Creating textFieldGreen
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(110, 250, 270, 35)];
    self.textFieldGreen.layer.borderWidth = 1.0;
    self.textFieldGreen.layer.cornerRadius = 5.0;
    self.textFieldGreen.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.textFieldGreen setPlaceholder:@"0..255"];
    [self.view addSubview:_textFieldGreen];
    
    // Creating labelBlue
    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(30, 330, 100, 35)];
    self.labelBlue.text = @"BLUE";
    [self.view addSubview:_labelBlue];
    
    // Creating textFieldBlue
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(110, 330, 270, 35)];
    self.textFieldBlue.layer.borderWidth = 1.0;
    self.textFieldBlue.layer.cornerRadius = 5.0;
    self.textFieldBlue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.textFieldBlue setPlaceholder:@"0..255"];
    [self.view addSubview:_textFieldBlue];
    
    // Creating buttonProcess
    self.buttonProcess = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 410, 100, 30)];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:_buttonProcess];
    
    // Action that will happen when the button is pressed
    [self.buttonProcess addTarget:self action:@selector(buttonTapped) forControlEvents: UIControlEventTouchUpInside];
    
    // Action that will happen when you tap on one of text fields
    [self.textFieldRed addTarget:self action:@selector(redFieldTapped) forControlEvents: UIControlEventTouchDown];
    [self.textFieldGreen addTarget:self action:@selector(greenFieldTapped) forControlEvents: UIControlEventTouchDown];
    [self.textFieldBlue addTarget:self action:@selector(blueFieldTapped) forControlEvents: UIControlEventTouchDown];

    
    
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}

- (void) buttonTapped {
    [self.view endEditing:YES];
    BOOL isError = FALSE;
    int redColor = [self.textFieldRed.text intValue];
    int greenColor = [self.textFieldGreen.text intValue];
    int blueColor = [self.textFieldBlue.text intValue];
    
    // empty field check
    if (self.textFieldRed.text.length != 0
        && self.textFieldGreen.text.length != 0
        && self.textFieldBlue.text.length != 0) {
        
        // symbols check for redField
        for (int i = 0; i < self.textFieldRed.text.length; i++) {
            if ([self.textFieldRed.text characterAtIndex:i] < 48
                || [self.textFieldRed.text characterAtIndex:i] > 57 ) {
                isError = TRUE;
                break;
            }
        }
        
        // symbols check for greenField
        if (!isError) {
            for (int i = 0; i < self.textFieldGreen.text.length; i++) {
                if ([self.textFieldGreen.text characterAtIndex:i] < 48
                    || [self.textFieldGreen.text characterAtIndex:i] > 57 ) {
                    isError = TRUE;
                    break;
                }
            }
            
            // symbols check for blueField
            if (!isError) {
                for (int i = 0; i < self.textFieldBlue.text.length; i++) {
                    if ([self.textFieldBlue.text characterAtIndex:i] < 48
                        || [self.textFieldBlue.text characterAtIndex:i] > 57 ) {
                        isError = TRUE;
                        break;
                    }
                }
            }
            
        }
        
        // range check (0..255)
        if (redColor >= 0 && redColor <= 255
            && greenColor >= 0 && greenColor <= 255
            && blueColor >= 0 && blueColor <= 255) {
            UIColor *resultColor = [UIColor colorWithRed:redColor/255.f green:greenColor/255.f blue:blueColor/255.f alpha:1];
            self.viewResultColor.layer.backgroundColor = resultColor.CGColor;
            
            const CGFloat* components = CGColorGetComponents(resultColor.CGColor);

            self.labelResultColor.text = [NSString stringWithFormat:@"0x%02lX%02lX%02lX",
                                          lroundf(components[0]*255),
                                          lroundf(components[1]*255),
                                          lroundf(components[2]*255)];;
        }
        else isError = TRUE;
    }
    else isError = TRUE;
    if (isError) self.labelResultColor.text = @"Error";
    
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
}

- (void) redFieldTapped {
    if (![self.labelResultColor.text isEqualToString:@"Color"])
        self.labelResultColor.text = @"Color";
}

- (void) greenFieldTapped {
    if (![self.labelResultColor.text isEqualToString:@"Color"])
        self.labelResultColor.text = @"Color";
}

- (void) blueFieldTapped {
    if (![self.labelResultColor.text isEqualToString:@"Color"])
        self.labelResultColor.text = @"Color";
}

@end
