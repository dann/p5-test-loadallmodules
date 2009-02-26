use strict;
use warnings;
use Test::LoadAllModules;
use File::Spec;
use lib File::Spec->catfile('t','lib2');

BEGIN {
    all_uses_ok( search_path => 'MyApp2', lib => [ File::Spec->catfile('t','lib2') ] );
}
