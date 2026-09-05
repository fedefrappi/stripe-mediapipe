Pod::Spec.new do |s|
  s.name                     = 'StripeMediaPipe'

  s.version                  = '1.0.0'

  s.summary                  = 'MediaPipe Tasks Vision, packaged for the Stripe iOS SDK.'
  s.license                  = { type: 'Apache-2.0', file: 'LICENSE-MediaPipe' }
  s.homepage                 = 'https://github.com/fedefrappi/stripe-mediapipe'
  s.authors                  = { 'Stripe' => 'support+github@stripe.com' }

  s.source                   = {
    http: "https://github.com/fedefrappi/stripe-mediapipe/releases/download/#{s.version}/StripeMediaPipe-#{s.version}.zip"
  }

  s.platform                 = :ios
  s.ios.deployment_target    = '13.0'
  s.requires_arc             = true
  s.frameworks               = ['Accelerate', 'AVFoundation', 'CoreMedia', 'CoreVideo', 'Foundation']
  s.libraries                = 'c++', 'z'

  s.source_files             = 'Sources/MediaPipeSPMGraphReferences/**/*.{c,h}'
  s.private_header_files     = 'Sources/MediaPipeSPMGraphReferences/**/*.h'
  s.pod_target_xcconfig      = { 'OTHER_LDFLAGS' => '$(inherited) -ObjC' }
  s.vendored_frameworks      = [
    'Artifacts/MediaPipeCommonGraphLibraries.xcframework',
    'Artifacts/MediaPipeTasksCommon.xcframework',
    'Artifacts/MediaPipeTasksVision.xcframework',
  ]
  s.preserve_paths           = 'LICENSE-MediaPipe'
end
