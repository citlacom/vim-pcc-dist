use Data::Dumper qw(Dumper);
use strict;
use warnings;

# The command is very but this is called async so show quickly
# a wait message.
print "Waiting response.\techo('Please wait.')\n";
# Execute Drupal Console debug:container command.
my @lines = qx(./vendor/bin/drupal debug:container);

# Parse the response and format Unite source input.
foreach my $line (@lines) {
  # Trim leading and trailing spaces.
  $line =~ s/^\s+|\s+$//g;
  # Split ouput columns.
  my @line_cols = split /\s+/, $line;

  if (@line_cols) {
    #print Dumper \@line_cols;
    # Tab separated: service key - open class tag command.
    print "$line_cols[0] - $line_cols[1]\tUnite tag -input=$line_cols[1]\n"
  }
}
