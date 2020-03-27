platform :ios,'10.0'
use_frameworks!
inhibit_all_warnings!
workspace 'MBRealmKit'


def pods
	# code analyser
	pod 'SwiftLint', '~> 0.30'

	# public libs
	pod 'RealmSwift', '~> 4.0'

	# module
	pod 'MBCommonKit/Logger', '~> 2.0'
end


target 'Example' do
	project 'Example/Example'
	
	pods
end

target 'MBRealmKit' do
	project 'MBRealmKit/MBRealmKit'
	
	pods

	target 'MBRealmKitTests' do
	end
end

target 'MBRealmKitUI' do
	project 'MBRealmKit/MBRealmKit'
	
	pods

	target 'MBRealmKitUITests' do
	end
end


post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '5.0'
		end
	end
end
