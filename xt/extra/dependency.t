use Test::Dependencies
	exclude => [qw/Test::Dependencies Test::Base Test::Perl::Critic Test::LoadAllModules/],
	style   => 'light';
ok_dependencies();
