//
//  ForcastCell.swift
//  EarthlyAllergies
//
//  Created by Shane Nelson on 6/21/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import UIKit

class ForcastCell: UITableViewCell
{
  @IBOutlet weak var dailyIcon: UIImageView!
  @IBOutlet weak var dailySummaryLabel: UILabel!
  @IBOutlet weak var dailyTemperatureLabel: UILabel!

  override func awakeFromNib()
  {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool)
  {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }

}
