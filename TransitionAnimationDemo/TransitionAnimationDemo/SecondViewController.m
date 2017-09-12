//
//  SecondViewController.m
//  TransitionAnimationDemo
//
//  Created by WDeng on 2017/9/12.
//  Copyright © 2017年 WDeng. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewController+Transition.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic,weak) UITableView *tableView ;
@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_W, SCREEN_H - 180) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 60;
    tableView.alpha = 0;
    tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self set];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
}

- (void)set {
    
    
    [UIView animateWithDuration:TransitionAni_Duration delay:0 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(0, 180, SCREEN_W, SCREEN_H - 180);
            self.tableView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"列表内容";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self dismissDetailAnimationViewController];
    
    [UIView animateWithDuration:TransitionAni_Duration animations:^{
        self.tableView.alpha = 0.0;
        self.tableView.frame = CGRectMake(0, 180, SCREEN_W, SCREEN_H - 150);
    }];
    
}

- (void)dealloc {
    NSLog(@"dealloc----%@",[self class]);
}

@end
