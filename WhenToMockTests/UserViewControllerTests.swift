import XCTest

class UserViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var userViewController: UserViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupUserViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupUserViewController()
  {
    let bundle = NSBundle(forClass: self.dynamicType)
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    userViewController = storyboard.instantiateViewControllerWithIdentifier("UserViewController") as! UserViewController
    _ = userViewController.view
    addViewToWindow()
  }
  
  func addViewToWindow()
  {
    window.addSubview(userViewController.view)
    NSRunLoop.currentRunLoop().runUntilDate(NSDate())
  }
  
  // MARK: Test doubles
  
  class UILabelMock: UILabel
  {
    var _text: String?
    var textSetterWasCalled = false
    
    override var text: String? {
      get {
        return self._text
      }
      set {
        self._text = newValue
        textSetterWasCalled = true
      }
    }
  }
  
  class UIImageViewMock: UIImageView
  {
    var _image: UIImage?
    var imageSetterWasCalled = false
    
    override var image: UIImage? {
      get {
        return self._image
      }
      set {
        self._image = newValue
        imageSetterWasCalled = true
      }
    }
  }
  
  // MARK: Test displaying user
  
  func testDisplayUserShouldDisplayNameAndPhoneAndProfilePhotoWithMocks()
  {
    // Given
    let profilePhoto = UIImage(named: "JohnDoe")!
    let viewModel = UserViewModel(name: "John Doe", phone: "123-456-7890", profilePhoto: profilePhoto)
    
    let nameLabelMock = UILabelMock()
    userViewController.nameLabel = nameLabelMock
    let phoneLabelMock = UILabelMock()
    userViewController.phoneLabel = phoneLabelMock
    let profilePhotoImageViewMock = UIImageViewMock()
    userViewController.profilePhotoImageView = profilePhotoImageViewMock
    
    // When
    userViewController.displayUser(viewModel)
    
    // Then
    let displayedName = nameLabelMock.text
    XCTAssert(nameLabelMock.textSetterWasCalled)
    XCTAssertEqual(displayedName, "John Doe", "Displaying an user should display the name in the name label")
    
    let displayedPhone = phoneLabelMock.text
    XCTAssert(phoneLabelMock.textSetterWasCalled)
    XCTAssertEqual(displayedPhone, "123-456-7890", "Displaying an user should display the phone in the phone label")
    
    let displayedProfilePhoto = profilePhotoImageViewMock.image
    XCTAssert(profilePhotoImageViewMock.imageSetterWasCalled)
    XCTAssertEqual(displayedProfilePhoto, profilePhoto, "Displaying an user should display the profile photo in the profile photo image view")
  }
  
  func testDisplayUserShouldDisplayNameAndPhoneAndProfilePhoto()
  {
    // Given
    let profilePhoto = UIImage(named: "JohnDoe")!
    let viewModel = UserViewModel(name: "John Doe", phone: "123-456-7890", profilePhoto: profilePhoto)
    
    // When
    userViewController.displayUser(viewModel)
    
    // Then
    let displayedName = userViewController.nameLabel.text
    XCTAssertEqual(displayedName, "John Doe", "Displaying an user should display the name in the name label")
    
    let displayedPhone = userViewController.phoneLabel.text
    XCTAssertEqual(displayedPhone, "123-456-7890", "Displaying an user should display the phone in the phone label")
    
    let displayedProfilePhoto = userViewController.profilePhotoImageView.image
    XCTAssertEqual(displayedProfilePhoto, profilePhoto, "Displaying an user should display the profile photo in the profile photo image view")
  }
}
