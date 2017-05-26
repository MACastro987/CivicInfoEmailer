# CivicInfoEmailer

This iOS Application connects users to their Representatives in the U.S. Government. Leverage Google’s Civic Info Api to retreive data on those who represent you both locally and nationally. Compose and send and email or contact your representatives via phone.

### Architecture

CivicInfoEmailer demonstrates the Model-View-Presenter architecture pattern

###### View

```Swift
class MainViewController: UIViewController
{
    fileprivate var mainPresenter = MainPresenter()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainPresenter.attachView(view: self)
        mainPresenter.getInitialRepresentatives()
    }
}
```

###### Presenter

```Swift
class MainPresenter {
    
    private var representativeView : RepresentativeView?
    
    func attachView(view: RepresentativeView) {
        representativeView = view
    }
    
    func detachView() {
        representativeView = nil
    }
    
    func getInitialRepresentatives()
    {
        ClientService.requestRepresentatives()
    }
}
```

### Tests

The SampleJSON.txt file contains data to mock a CivicInfo Api response. This data may be modified in order to test deserialization methods. 

Load mock JSON data by switching this bool value in MainPresenter.swift.

```Swift
class MainPresenter {
    
    //TESTING?
    private var inTestMode: Bool = true
```

Setting this 'true' prompts the presenter's address property to load from the local JSON file.

```Swift
private var address: Address? {
        didSet {
            
            if self.inTestMode {
                //TEST
                ClientService.testRequest(completion: {
                    
                    (representatives: [Representative]?) in
                    
                    if (representatives != nil) {
                        self.mainView?.update(representatives: representatives!)
                    }
                })
            }
```

### Motivation

This application is meant to remove barriers between U.S. Representatives and their constituents. Scroll through the Representatives who make legislation that directly affects your life. If Google's Civic Info Api provides an email address for the Representative, you may easily compose and send an email.
