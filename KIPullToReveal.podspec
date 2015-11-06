Pod::Spec.new do |s|
  s.name         = "KIPullToReveal"
  s.version      = "1.0.2"
  s.summary      = "This UITableViewController is used to combine a search result's UITableView with a MKMapView."
  s.homepage     = "https://github.com/kimar/KIPullToReveal"
  s.license      = 'MIT'
  s.license      = {
    :type => 'MIT',
    :text => 'LICENSE'
  }

  s.author       = { "Marcus Kida" => "mail@marcuskida.de" }

  s.source       = { :git => "https://github.com/kimar/KIPullToReveal.git", :tag => "#{s.version}" }
  s.platform = :ios, '5.0'

  s.source_files = 'PullToReveal/KIPullToReveal/*.{h,m}'
  s.resources = 'PullToReveal/KIPullToReveal/*.{xib}'

  s.requires_arc = true
end
