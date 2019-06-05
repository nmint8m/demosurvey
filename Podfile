source 'https://github.com/cocoapods/specs.git'
platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

def app_pods
    pod 'ObjectMapper', '3.4.1'
    pod 'Alamofire', '4.8.2'
    pod 'AlamofireNetworkActivityIndicator', '2.3.0'
    pod 'SwifterSwift', '4.5.0'
    pod 'AsyncSwift', '2.0.4'
    pod 'SDWebImage', '4.4.1'
    pod 'SVProgressHUD', '2.2.5'
    pod 'SwiftLint', '0.29.0'
    pod 'CHIPageControl/Aji', '0.1.7'
end

def test_pods
    pod 'Nimble', '8.0.1'
    pod 'Quick', '1.3.2'
    pod 'OHHTTPStubs/Swift', '7.0.0'
end
    

target 'DemoSurvey' do
    project 'DemoSurvey'
    app_pods
  

    target 'DemoSurveyTests' do
        inherit! :search_paths
        test_pods
    end
end
