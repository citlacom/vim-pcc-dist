#!/usr/bin/perl

use Data::Dumper qw(Dumper);
use strict;
use warnings;

# The command is very but this is called async so show quickly
# a wait message.
print "Waiting response.\techo('Please wait.')\n";
# Path to the drupal console executable.
# TODO: Improve drupal bin location within a Drupal project due with composer
# the bin directory could be customized by bin-dir.
my $drupal = './vendor/bin/drupal';

# Check that Drupal Console is executable from current directory
# so this script is expected to run located at Drupal project repository
# root directory.
if (not -x $drupal) {
  print "The $drupal executable not available on $drupal.\techo('Use a correct directory.')\n";
  exit;
}

# Execute Drupal Console debug:container command.
my @lines = qx($drupal debug:container);

# Parse the response and format Unite source input.
foreach my $line (@lines) {
  # Trim leading and trailing spaces.
  $line =~ s/^\s+|\s+$//g;
  # Split ouput columns.
  my @line_cols = split /\s+/, $line;

  if (@line_cols) {
    #print Dumper \@line_cols;
    # Tab separated: service key - open class tag command.
    print "$line_cols[0] - $line_cols[1]\tvim_pcc_dist#LocateNamespaceClass($line_cols[1])\n"
  }
}
