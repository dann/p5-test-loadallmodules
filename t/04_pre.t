use strict;
use warnings;
use FindBin;
use File::Spec;
use lib File::Spec->catdir($FindBin::Bin, 'lib');

use Test::LoadAllModules;
use Test::More;

BEGIN {
    all_uses_ok(
        search_path => 'MyApp',
        pre => sub {
            ok 1;;
        },
    );
}