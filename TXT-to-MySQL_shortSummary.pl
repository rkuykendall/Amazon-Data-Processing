#!/usr/bin/perl -w
use DBI;

# MySQL
# ==================================================

# Run export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/
my $dbh = DBI->connect("DBI:mysql:database=UIC-Dataset;host=127.0.0.1", "root", "", {'RaiseError' => 1});

### # execute INSERT query
### my $rows = $dbh->do("INSERT INTO users (id, username, country) VALUES (4, 'jay', 'CZ')");
### print "$rows row(s) affected\n";

### # execute SELECT query
### my $sth = $dbh->prepare("SELECT username, country FROM users");
### $sth->execute();

### # iterate through resultset
### # print values
### while(my $ref = $sth->fetchrow_hashref()) {
###     print "User: $ref->{'username'}\n";
###     print "Country: $ref->{'country'}\n";
###     print "----------\n";
### }
# --------------------------------------------------

open(MYINPUTFILE, "<amazon-member-shortSummary.txt");

%item = ();
$next = 0;
$count = 0;
while(<MYINPUTFILE>)
{
	# Good practice to store $_ value because
	# subsequent operations may change it.
	my($line) = $_;

	# Good practice to always strip the trailing
	# newline from the line.
	chomp($line);


	if ($line eq "MEMBER INFO") {		
		# Do nothing
		
		if ($count > 0) {
    	# Create MySQL Query
    	# ==================================================
    	$query = "INSERT INTO shortSummary (";
    	while (($key, $value) = each(%item)) {
    	    $query .= $key.", ";
    	}
    	$query =~ s/, $//;
    	$query .= ") VALUES (";
    	while (($key, $value) = each(%item)) {
    	  $query .= $dbh->quote($value).", ";
    	}
    	$query =~ s/, $//;
    	$query .= ");";
    	# --------------------------------------------------


  		print $query."\n";



    	# Execute MySQL Query
    	# ==================================================
    	### print $query."\n";
    	my $rows = $dbh->do($query);
    	if ($rows != 1) {
    		print $query . "\n\n";
    	} else {
    	  ### count++;
      }
      # --------------------------------------------------
  		
  		
  		
  		# Clean up for new item
    	# ==================================================
  		for (keys %item)
      {
          delete $item{$_};
      }
      # --------------------------------------------------
		}
		
		$count++;
		$next = 1;
	} elsif ($next == 1) {
	  $line =~ m/^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)[\t]*$/;
		$item{'MemberID'} = $1;
		$item{'MemberName'} = $2;
		$item{'NumReviews'} = $3;
		$item{'Location'} = $4;
		
		$next = 2;
	} elsif ($next == 2) {
		$item{'MyWords'} .= $line."\n";
	} else {
	  print "ERROR! $line \n\n";
	}
}



# Create MySQL Query
# ==================================================
$query = "INSERT INTO shortSummary (";
while (($key, $value) = each(%item)) {
    $query .= $key.", ";
}
$query =~ s/, $//;
$query .= ") VALUES (";
while (($key, $value) = each(%item)) {
  $query .= $dbh->quote($value).", ";
}
$query =~ s/, $//;
$query .= ");";
# --------------------------------------------------



# Execute MySQL Query
# ==================================================
### print $query."\n";
my $rows = $dbh->do($query);
if ($rows != 1) {
	print $query . "\n\n";
} else {
  ### count++;
}
# --------------------------------------------------




# Closing statements
# ==================================================
print "Count: ".$count."\n";
# clean up
$dbh->disconnect();
# --------------------------------------------------



