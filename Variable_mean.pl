#!/usr/bin/perl -w
use DBI;
use DateTime::Format::Strptime qw();

my $parser = DateTime::Format::Strptime->new(pattern => '%F');

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

$products = $dbh->prepare("SELECT id, ProductID FROM productinfo WHERE (ProductID IS NOT NULL && break LIKE 'BREAK-REVIEWED%')"); # && ProductID = ' 0002171856'
$products->execute();

while(my $product = $products->fetchrow_hashref())
{
  $cleanID = $product->{'ProductID'};
  $cleanID =~ s/^\s+//;
  $cleanID =~ s/\s+$//;
  
  $reviews = $dbh->prepare("SELECT Rating, dateReal FROM Reviews WHERE ProductID = ? ORDER BY dateReal ASC");
  $reviews->execute($cleanID);
  my $average = 0.0;
  my $numReviews = 0;
  
  $latest = "";
  @stack = qw( NULL NULL NULL NULL NULL NULL NULL NULL NULL NULL );
  $oldest = $parser->parse_datetime('1111-11-11');
  $newest = $parser->parse_datetime('1111-11-11');
  
  while(my $review = $reviews->fetchrow_hashref())
  {
    if (defined($review->{'dateReal'}) && $review->{'dateReal'} =~ m/\d{4}-\d{2}-\d{2}/) {
      if ($oldest->year() == 1111) {
        $oldest = $parser->parse_datetime($review->{'dateReal'});
      }
      $newest = $parser->parse_datetime($review->{'dateReal'});
    } else {
      print $review;
    }
    
    # print $review->{'dateReal'}."\n";
    $average = $average + $review->{'Rating'};
    $numReviews++;
    push (@stack, $average / $numReviews);
    # print $average / $numReviews . "\n";
    $latest = $review->{'dateReal'};
  }
  if ($numReviews > 0) {
    $days = $newest->delta_days($oldest)->in_units('days');

    $perday = 1;
    if ($days > 0) {
      $perday = ($numReviews * 1.0) / $days;
    }
    
    $statement = "UPDATE productinfo SET Rrange = ?, Rperday = ?, NumReviews = ?, Raverage0t = ?, Raverage1t = ?, Raverage2t = ?, Raverage3t = ?, Raverage4t = ?, Raverage5t = ?, Raverage6t = ?, Raverage7t = ?, Raverage8t = ?, Raverage9t = ?, Rlatest = ? WHERE id = ?;";
    $dbh->do($statement, undef, $days, $perday, $numReviews, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, $latest, $product->{'id'}); 
    ### print "ID: $product->{'ProductID'}, $average\n";
  }  
}

# Closing statements
# ==================================================
### print "Count: ".$count."\n";
$dbh->disconnect();
# --------------------------------------------------



