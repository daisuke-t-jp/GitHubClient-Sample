platform :ios, '11.0'
use_frameworks!

install! 'cocoapods',
            :warn_for_unused_master_specs_repo => false

target 'GitHubClient-Sample' do
    pod 'SwiftLint'
    pod 'Kingfisher', '~> 6.0'
    pod 'ImageViewer.swift', '~> 3.0'
    pod 'Toast-Swift', '~> 5.0.1'
end


post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
    end
end


plugin 'cocoapods-keys', {
    :project => "GitHubClient-Sample",
    :keys => [
        "GitHubPersonalAccessToken",
    ]}
