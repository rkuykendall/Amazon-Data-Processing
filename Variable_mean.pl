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

$products = $dbh->prepare("SELECT id, ProductID FROM productinfo WHERE (ProductID IS NOT NULL && break LIKE 'BREAK-REVIEWED%')"); # && ProductID = ' 0002171856'
$products->execute();

while(my $product = $products->fetchrow_hashref())
{
  $cleanID = $product->{'ProductID'};
  $cleanID =~ s/^\s+//;
  $cleanID =~ s/\s+$//;
  
  $reviews = $dbh->prepare("SELECT Rating, dateReal FROM Reviews WHERE ProductID = ?");
  $reviews->execute($cleanID);
  my $average = 0.0;
  my $numReviews = 0;
  
  $latest = "";
  @stack = qw( NULL NULL NULL NULL NULL NULL NULL NULL NULL NULL );
  while(my $review = $reviews->fetchrow_hashref())
  {
    # print $review->{'dateReal'}."\n";
    $average = $average + $review->{'Rating'};
    $numReviews++;
    push (@stack, $average / $numReviews);
    # print $average / $numReviews . "\n";
    $latest = $review->{'dateReal'};
  }
  if ($numReviews > 0) {    
    $statement = "UPDATE productinfo SET NumReviews = ?, Raverage0t = ?, Raverage1t = ?, Raverage2t = ?, Raverage3t = ?, Raverage4t = ?, Raverage5t = ?, Raverage6t = ?, Raverage7t = ?, Raverage8t = ?, Raverage9t = ?, Rlatest = ? WHERE id = ?;";
    $dbh->do($statement, undef, $numReviews, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, pop @stack, $latest, $product->{'id'}); 
    ### print "ID: $product->{'ProductID'}, $average\n";
  }  
}

# Closing statements
# ==================================================
### print "Count: ".$count."\n";
$dbh->disconnect();
# --------------------------------------------------



