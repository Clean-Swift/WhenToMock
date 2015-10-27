//
//  UserViewController.swift
//  WhenToMock
//
//  Created by Raymond Law on 10/26/15.
//  Copyright (c) 2015 Raymond Law. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol UserViewControllerInput
{
  func displayUser(viewModel: UserViewModel)
}

protocol UserViewControllerOutput
{
  func fetchUser(request: UserRequest)
}

class UserViewController: UIViewController, UserViewControllerInput
{
  var output: UserViewControllerOutput!
  var router: UserRouter!
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var profilePhotoImageView: UIImageView!
  
  // MARK: Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    UserConfigurator.sharedInstance.configure(self)
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    fetchUserOnLoad()
  }
  
  // MARK: Event handling
  
  func fetchUserOnLoad()
  {
    let request = UserRequest(userID: 1)
    output.fetchUser(request)
  }
  
  // MARK: Display logic
  
  func displayUser(viewModel: UserViewModel)
  {
    nameLabel.text = viewModel.name
    phoneLabel.text = viewModel.phone
    profilePhotoImageView.image = viewModel.profilePhoto
  }
}