#!/usr/bin/env perl
use warnings;
use strict;

use Test::More tests => 1;

use lib '..';
use inc::Module::Install;

#-----------------------------------------------------------------------------------------------------------------------

sub get_bugtracker_value {
  foreach my $extension (@{ $Module::Install::MAIN->{'admin'}->{'extensions'} }) {
    next unless $extension->isa('Module::Install::Metadata');

    my @resources = @{ $extension->{'values'}->{'resources'} };
    while (@resources) {
      my $keyvalue = shift @resources;

      next unless $$keyvalue[0] eq 'bugtracker';

      return $$keyvalue[1];
    }
  }

  return undef;
}

#-----------------------------------------------------------------------------------------------------------------------

perl_version '5.005';

name 'test';

auto_set_bugtracker;

my $bugtracker = get_bugtracker_value();

if (defined($bugtracker) && $bugtracker eq 'http://rt.cpan.org/Public/Dist/Display.html?Name=test') {
  pass;
} else {
  fail;
}

