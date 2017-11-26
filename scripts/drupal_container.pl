#!/usr/bin/perl

# VIM Unite script source that interacts with Drupal Console to gather the list
# of container services. You will require to install Cache::File dependency with
# the command: cpan install Cache::File The cache file will be generated based
# on executed path considering that Drupal projects will depend on different
# modules providing a variation on the services. The results are cached after
# the first Drupal Console command execution to bring faster results on Unite
# results so you are required to pass extra argument to force rebuild.
###############################################################################

# TODO: Refactor to more generic Drupal Console script and itegrate other
# sources:
# debug:plugin
# debug:roles
# debug:config
# debug:database:table
# debug:entity
# debug:image:styles
# debug:roles
# debug:state
# debug:theme:keys
# debug:views
# field:info --detailed

use Digest::MD5 qw(md5);
use Cache::File;
use Cwd;
use Data::Dumper qw(Dumper);
use strict;
use warnings;

# Path to the drupal console executable.
# TODO: Improve drupal bin location within a Drupal project due with composer
# the bin directory could be customized by bin-dir.
my $drupal = './vendor/bin/drupal';
my $current_dir = getcwd();
my $output = '';

# Check that Drupal Console is executable from current directory
# so this script is expected to run located at Drupal project repository
# root directory.
if (not -x $drupal) {
  print sprintf("The %s executable not available on %s\techo('Use a correct directory.')\n",
      $drupal, $current_dir);
  exit 1;
}

# Cache expiration is set to 1 day.
my $cache = Cache::File->new(
  cache_root => '/tmp/unite_drupal_cache',
  default_expires => '86400 sec',
);

my $cache_id = md5($current_dir);
my $result = $cache->get($cache_id);

if (defined $result) {
  print $result;
  exit 0;
}

# The command is very but this is called async so show quickly
# a wait message.
print "Building the Drupal Console response, type after 15 seconds.\techo('Building cache, please wait...')\n";
# Execute Drupal Console debug:container command.
my @lines = qx($drupal debug:container);

# Parse the response and format Unite source input.
foreach my $line (@lines) {
  # Trim leading and trailing spaces.
  $line =~ s/^\s+|\s+$//g;
  # Split ouput columns.
  my @line_cols = split /\s+/, $line;

  if (@line_cols) {
    # We expect exactly 2 columns: service ID and class path so ignore edge
    # cases if happens.
    if (scalar @line_cols != 2) {
      next;
    }

    #print Dumper \@line_cols;
    # Tab separated: service key - open class tag command.
    $output = $output . sprintf("%s - %s\tcall vim_pcc_dist#LocateNamespaceClass('%s')\n",
    $line_cols[0], $line_cols[1], $line_cols[1])
  }
}

# Cache the tab separated results.
$cache->set($cache_id, $output);

print $output;
