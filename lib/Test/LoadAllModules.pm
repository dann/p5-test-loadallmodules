package Test::LoadAllModules;
use strict;
use warnings;
use Module::Pluggable::Object;
use List::MoreUtils qw(any);
use Test::More ();

our $VERSION = '0.01';

use Exporter;
our @ISA    = qw/Exporter/;
our @EXPORT = qw/all_uses_ok/;

sub all_uses_ok {
    my %param       = @_;
    my $search_path = $param{search_path};
    unless ($search_path) {
        Test::More::plan skip_all => 'no search path';
        exit;
    }
    Test::More::plan('no_plan');
    my @exceptions = @{$param{except} || []};
    my $finder
        = Module::Pluggable::Object->new( search_path => $search_path, );
    my @modules = ( $search_path, $finder->plugins );
    foreach my $class (
        grep { !is_excluded( $_, @exceptions ) }
        sort @modules
        )
    {
        Test::More::use_ok($class);
    }
}

sub is_excluded {
    my ( $module, @exceptions ) = @_;
    any { $module eq $_ || $module =~ /$_/ } @exceptions;
}

1;

__END__

=head1 NAME

Test::LoadAllModules - do use_ok for modules in search path

=head1 SYNOPSIS

  # basic
  use Test::LoadAllModules;

  BEGIN {
      all_uses_ok(search_path => 'MyApp');
  }

  # exclude some classes
  use Test::LoadAllModules;

  BEGIN {
      all_uses_ok(
          search_path => 'MyApp',
          except => [
              MyApp::Role,
              qr/MyApp::Exclude::.*/,
          ]
      );
  }

=head1 DESCRIPTION

Test::LoadAllModules do use_ok for modules in search_path.

=head1 EXPORTED FUNCTIONS

=head2 all_uses_ok

Does Test::More's use_ok() for every modules found in search path.

=head1 AUTHOR

Takatoshi Kitano E<lt>kitano.tk@gmail.comE<gt>

=head1 SEE ALSO

L<Test::More>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
