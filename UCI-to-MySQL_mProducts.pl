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
# ==================================================

open(MYINPUTFILE, "<productInfoXML-reviewed-mProducts.txt");

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
	
	if ($line eq "BREAK-REVIEWED") {		
		# Do nothing
		$next = 1;
	} elsif ($next == 1) {
	  $line =~ m/^([^\t]+)\t([^\t]+)\t([^\t]+)\t([^\t]+)\t([^\t]+)[\t]*$/;
		$item{'OneProductID'} = $1;
		$item{'OneSalesRank'} = $2;
		$item{'OneBrand'} = $3;
		$item{'OneSalesPrice'} = $4;
		$item{'OneTitle'} = $5;
		
		$next = 2;
	} elsif ($next == 2) {
		@catValPairs = split(/\t/, $line);
		foreach (@catValPairs) {
			if ($_ =~ m/->/) {
				my @catVal = split(/->/, $_);
				$item{$catVal[0]} = $catVal[1];
				
				### # === Determining Categories ===
				### # Add to beginning: my @categories;
				### # Add to end: print "Categories: @categories \n";
				### my %params = map { $_ => 1 } @categories;
				### if(!exists($params{$catVal[0]})) {
				### 	push(@categories, $catVal[0]);
				### }
			}			
		}
		
		# Insert into MySQL
		# ==================================================
		$query = "INSERT INTO productInfoXMLReviewedMProducts (";
		while (($key, $value) = each(%item)){
		    $query .= $key.", ";
		}
		$query =~ s/, $//;
		$query .= ") VALUES (";
		while (($key, $value) = each(%item)) {
			$value =~ s/\"/\\\"/g;
		    $query .= "\"".$value."\", ";
		}
		$query =~ s/, $//;
		$query .= ");";
		
		### print $query;
		
		# execute INSERT query
		my $rows = $dbh->do($query);
		if ($rows != 1) {
			print $query . "\n\n";
		} else {
  		$count++;		  
		}
		
		# Clean up for new item
		for (keys %item)
    {
        delete $item{$_};
    }
		# ==================================================
	} else {
	  print "ERROR! $line \n\n";
	}
}

print "Count: ".$count."\n";
# clean up
$dbh->disconnect();
