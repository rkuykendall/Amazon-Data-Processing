#!/usr/bin/perl -w
use DBI;
use DateTime::Format::Strptime qw();

# Run the following line if you get the error 'Can't load * for module DBD::mysql'
# export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/
$dbh = DBI->connect("DBI:mysql:database=UIC-Dataset;host=127.0.0.1", "root", "", {'RaiseError' => 1});
my $parser = DateTime::Format::Strptime->new(pattern => '%F');

sub get_products {
  # && ProductID = ' 0002171856'
  my $products = $dbh->prepare("SELECT id, ProductID FROM productinfo WHERE (ProductID IS NOT NULL && break LIKE 'BREAK-REVIEWED%')"); 
  
  $products->execute();
  
  my @products;
  while(my $product = $products->fetchrow_hashref())
  {
     push @products, $product;
  }

  return @products;
}

sub SQLupdate {
  # Params: Table, ID, Values
  my %fields = %{$_[2]};
  
  $statement = "UPDATE ".$_[0]." SET ";
  
	while (($key, $value) = each(%fields)) {
	  $statement .= $dbh->quote($key)." = ".$dbh->quote($value).", ";
	}
	$statement =~ s/, $//;
	$statement .= " WHERE id = ".$dbh->quote($_[1]).";";
  
  # print $statement . "\n\n"
  $dbh->do($statement);
}

@products = get_products();

foreach(@products)
{
  my $product = $_;
  my %fields = ();
  
  $cleanID = $product->{'ProductID'};
  $cleanID =~ s/^\s+//;
  $cleanID =~ s/\s+$//;
  
  $reviews = $dbh->prepare("SELECT Rating, dateReal FROM Reviews WHERE ProductID = ? ORDER BY dateReal ASC");
  $reviews->execute($cleanID);
  my $average = 0.0;
  $fields{'NumReviews'} = 0;
  
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
    $fields{'NumReviews'} = $fields{'NumReviews'} + 1;
    push (@stack, $average / $fields{'NumReviews'});
    # print $average / $fields{'NumReviews'} . "\n";
    $fields{'Rlatest'} = $review->{'dateReal'};
  }
  if ($fields{'NumReviews'} > 0) {
    $fields{'Rrange'} = $newest->delta_days($oldest)->in_units('days');

    $fields{'Rperday'} = 1;
    if ($fields{'Rrange'} > 0) {
      $fields{'Rperday'} = ($fields{'NumReviews'} * 1.0) / $fields{'Rrange'};
    }
    
    foreach my $i (0..9) {
      $fields{"Raverage".$i."t"} = pop @stack;
    }
    
    $statement = SQLupdate('productinfo', $product->{'id'}, \%fields);
  }  
}

# Closing statements
# ==================================================
### print "Count: ".$count."\n";
$dbh->disconnect();
# --------------------------------------------------









