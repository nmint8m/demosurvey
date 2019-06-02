source 'https://github.com/cocoapods/specs.git'
platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

workspace 'DemoSurvey.xcodeproj'

def app_pods
    pod 'ObjectMapper', '3.4.1'
    pod 'Alamofire', '4.8.2'
    pod 'SwiftDate', '4.5.1'
    pod 'AsyncSwift', '2.0.4'
    pod 'SDWebImage', '4.4.1'
    pod 'SVProgressHUD', '2.2.5'
end

def test_pods
    pod 'Nimble', '7.3.1'
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
