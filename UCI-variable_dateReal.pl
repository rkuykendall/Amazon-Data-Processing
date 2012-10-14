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

$reviews = $dbh->prepare("SELECT id, date FROM DONEReviews WHERE (date IS NOT NULL)");
$reviews->execute();

while(my $review = $reviews->fetchrow_hashref())
{
  if ($review->{'date'} =~ m/([A-Za-z]+) (\d{1,2}), (\d{4})/) {
    $month = $1;
    %mon2num = qw(
      jan 01  feb 02  mar 03  apr 04  may 05  jun 06
      jul 07  aug 08  sep 09  oct 10  nov 11  dec 12
    );
    $month = $mon2num{lc substr($month, 0, 3) };

    $day = $2;
    $day = sprintf("%2d", $day);
    $day =~ tr/ /0/;

    $year = $3;

    $dateReal = $year."-".$month."-".$day;

    $statement = "UPDATE DONEReviews SET dateReal = ? WHERE id = ?";
    $dbh->do($statement, undef, $dateReal, $review->{'id'}); 
  } else {
    print "ERROR! Danger, Will Robinson! [".$review->{'date'}."]\n";
  }
}

# Closing statements
# ==================================================
### print "Count: ".$count."\n";
$dbh->disconnect();
# --------------------------------------------------



