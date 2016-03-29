#!/usr/bin/perl
# Inline::Python;
open (my $py, "|-", "python Schwartz_final_clusteringMethod.py") or die "Python script returned error $!";
while (<$py>) {
  print clusters;
}
close ($py);


#system("python", "Schwartz_final_clusteringMethod.py") == 0 or die "Python script returned error $?";