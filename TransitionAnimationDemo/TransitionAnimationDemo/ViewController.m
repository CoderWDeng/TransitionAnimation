//
//  ViewController.m
//  TransitionAnimationDemo
//
//  Created by WDeng on 2017/9/12.
//  Copyright © 2017年 WDeng. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "UIViewController+Transition.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,weak) UITableView *tableView ;
@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [self.dataArr addObject:[NSString stringWithFormat:@"0%d.jpeg", i]];
    }
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.rowHeight = 200;
//    tableView.allowsSelection = NO;
//    tableView.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.scrollDirection = UICollectionViewScrollDirectionVertical;
        fl.itemSize = CGSizeMake(100, 100);
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:fl];
        self.collectionView.delegate = self;
        self.collectionView.dataSource =self;
        [self.view addSubview:self.collectionView];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
}
#pragma mark - tableView dataSource And delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 180)];
        img.image = [UIImage imageNamed:self.dataArr[indexPath.row]];
        img.userInteractionEnabled = YES;
        [cell addSubview:img];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImg:)];
        [img addGestureRecognizer:tap];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, img.frame.origin.y + img.frame.size.height, SCREEN_W, 20)];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"标题";
        [cell addSubview:label];
    }
    
    return cell;
}

- (void)tapImg:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        SecondViewController *vc = [SecondViewController new];
        [self presentDetailAnimationViewController:vc aniImgView:(UIImageView *)tap.view toFrom:CGRectMake(0, 0, SCREEN_W, 180)];
    }
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    img.image = [UIImage imageNamed:self.dataArr[indexPath.row]];
    img.userInteractionEnabled = YES;
    [cell addSubview:img];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImg:)];
    [img addGestureRecognizer:tap];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
