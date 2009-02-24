use strict;
use warnings;
use FindBin::libs;
use Test::LoadAllModules;

all_uses_ok(search_path => 'MyApp', except => ['MyApp::Test', qr/MyApp::RegEx*/]);

