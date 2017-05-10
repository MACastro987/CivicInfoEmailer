# CivicInfoEmailer

This iOS Application connects users to their Representatives in the U.S. Government. Leverage Google’s Civic Info Api to retreive data on those who represent you both locally and nationally. Compose and send and email or contact your representatives via phone.

### Code Examples

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

```
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

### Motivation

This application is meant to remove barriers between U.S. Representatives and their constituents. Simply scroll through the people who make legislation that directly affects your life. If Google's Civic Info Api provides an email address for the Representative, you may easily compose and send an email.
