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


open(MYINPUTFILE, "<amazon-memberinfo-locations.txt");
%item = ();
### $count = 0;

while(<MYINPUTFILE>)
{
  # Clean up line for processing
	# ==================================================
	# Good practice to store $_ value because
	# subsequent operations may change it.
	my($line) = $_;

	# Good practice to always strip the trailing
	# newline from the line.
	chomp($line);
	# --------------------------------------------------



	# Extract Data
	# ==================================================
  $line =~ m/^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)[\t]*$/;
	$item{'Username'} = $1;
	$item{'MemberRank'} = $2;
	$item{'Birthday'} = $3;
	$item{'Location'} = $4;
	$item{'Name'} = $5;
	$item{'MemberID'} = $6;
	$item{'State'} = $7;
	
	### print "Line: ".$line."\n";
	### while (($key, $value) = each(%item)) {
	###     print $key.":".$value.", ";
	### }
	### print "\n";
	# --------------------------------------------------



	# Create MySQL Query
	# ==================================================
	$query = "INSERT INTO Locations (";
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



	# Clean up for new item
	# ==================================================
	for (keys %item)
  {
    delete $item{$_};
  }
  # --------------------------------------------------
  
} # End of while(<MYINPUTFILE>)



# Closing statements
# ==================================================
### print "Count: ".$count."\n";
$dbh->disconnect();
# --------------------------------------------------



