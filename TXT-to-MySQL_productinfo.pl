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

open(MYINPUTFILE, "<LIU-UIC-SMDM-Working/productinfo.txt");

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


	if ($line =~ m/BREAK(-REVIEWED){0,1}/) {		
		# Do nothing
		
		if ($count > 0) {
    	# Create MySQL Query
    	# ==================================================
    	$query = "INSERT INTO productinfo (";
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
      

  		### print $query."\n";
      ### if (($count % 1000) == 0) {
      ###   print $count."  \t";
      ### }


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
		}
		
		# Clean up for new item
  	# ==================================================
		for (keys %item)
    {
        delete $item{$_};
    }
    # --------------------------------------------------
    
    $item{'break'} = $line;
		
		$count++;
		$next = 1;
	} elsif ($next == 1) {
	  $line =~ m/^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t\t([^\t]*)[\t]*$/;
		$item{'ProductID'} = $1;
		$item{'ProductName'} = $2;
		$item{'ProductType'} = $3;
		$item{'Brand'} = $4;
		$item{'SalesPrice'} = $5;
		$item{'ListPrice'} = $6;
		$item{'ShortProductDescription'} = $7;
		
		$next = 2;
	} elsif ($next == 2) {
		$item{'CatPaths'} .= $line."\n";
	} else {
	  print "\nERROR! <".$line.">\n";
	}
}



# Closing statements
# ==================================================
print "\nCount: ".$count."\n";
# clean up
$dbh->disconnect();
# --------------------------------------------------



