//
//  TitleMenuTVC.m
//  SinaWB
//
//  Created by 赵麦 on 7/31/16.
//  Copyright © 2016 歹徒. All rights reserved.
//

#import "TitleMenuTVC.h"

@implementation TitleMenuTVC




#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"基友";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"损友";
    }
    
    return cell;
}


@end
