Pod::Spec.new do |s|
  s.name             = "SQLite.swift"
  s.version          = "0.12.2-gh"
  s.summary          = "A type-safe, Swift-language layer over SQLite3 for iOS and macOS."

  s.description      = <<-DESC
    SQLite.swift provides compile-time confidence in SQL statement syntax and
    intent.
                       DESC

  s.homepage         = "https://github.com/gideon-health/SQLite.swift"
  s.license          = 'MIT'
  s.author           = { "Stephen Celis" => "stephen@stephencelis.com" }
  s.source           = { :git => "git@github.com:gideon-health/SQLite.swift.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/stephencelis'

  s.module_name      = 'SQLite'
  s.default_subspec  = 'standard'
  s.swift_versions = ['4.2', '5']


  ios_deployment_target = '8.0'
  tvos_deployment_target = '9.1'
  osx_deployment_target = '10.10'
  watchos_deployment_target = '2.2'

  s.ios.deployment_target = ios_deployment_target
  s.tvos.deployment_target = tvos_deployment_target
  s.osx.deployment_target = osx_deployment_target
  s.watchos.deployment_target = watchos_deployment_target

  s.subspec 'standard' do |ss|
    ss.source_files = 'Sources/{SQLite,SQLiteObjc}/**/*.{c,h,m,swift}'
    ss.exclude_files = 'Sources/**/Cipher.swift'
    ss.private_header_files = 'Sources/SQLiteObjc/*.h'
    ss.library = 'sqlite3'

    ss.test_spec 'tests' do |test_spec|
      test_spec.resources = 'Tests/SQLiteTests/fixtures/*'
      test_spec.source_files = 'Tests/SQLiteTests/*.swift'
      test_spec.ios.deployment_target = ios_deployment_target
      test_spec.tvos.deployment_target = tvos_deployment_target
      test_spec.osx.deployment_target = osx_deployment_target
    end
  end

  s.subspec 'standalone' do |ss|
    ss.source_files = 'Sources/{SQLite,SQLiteObjc}/**/*.{c,h,m,swift}'
    ss.exclude_files = 'Sources/**/Cipher.swift'
    ss.private_header_files = 'Sources/SQLiteObjc/*.h'

    ss.xcconfig = {
      'OTHER_SWIFT_FLAGS' => '$(inherited) -DSQLITE_SWIFT_STANDALONE',
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SQLITE_SWIFT_STANDALONE=1'
    }
    ss.dependency 'sqlite3'

    ss.test_spec 'tests' do |test_spec|
      test_spec.resources = 'Tests/SQLiteTests/fixtures/*'
      test_spec.source_files = 'Tests/SQLiteTests/*.swift'
      test_spec.ios.deployment_target = ios_deployment_target
      test_spec.tvos.deployment_target = tvos_deployment_target
      test_spec.osx.deployment_target = osx_deployment_target
    end
  end
end
