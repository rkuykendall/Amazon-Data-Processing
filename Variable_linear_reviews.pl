#!/usr/bin/perl -w
use DBI;
use DateTime::Format::Strptime qw();

# Run the following line if you get the error 'Can't load * for module DBD::mysql'
# export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/
$dbh = DBI->connect("DBI:mysql:database=UIC-Dataset;host=127.0.0.1", "root", "", {'RaiseError' => 1});
my $parser = DateTime::Format::Strptime->new(pattern => '%F');
$range = 200;

sub get_products {
  # && ProductID = ' 0002171856'
  my $products = $dbh->prepare("SELECT id, ProductID, Raverage0t FROM productinfo WHERE (ProductID IS NOT NULL && break LIKE 'BREAK-REVIEWED%' && NumReviews > 200 && Rperday > 2 && Rrange > 200 && Rlatest > '2006-05-20')"); 
  
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
  
  print $statement . "\n\n"
  # $dbh->do($statement);
}

sub getReviews {
  $id = $_[0];
  $id =~ s/^\s+//;
  $id =~ s/\s+$//;
  $date = $_[1];
  $perPage = 10;
  
  $reviews = $dbh->prepare("SELECT Rating, dateReal FROM Reviews WHERE ( ProductID = ? ) ORDER BY dateReal ASC LIMIT ?, ?");
  $reviews->execute($id, $date*2, $perPage);

  # $reviews = $dbh->prepare("SELECT Rating, dateReal FROM Reviews WHERE ( ProductID = ? && dateReal = ? ) ORDER BY dateReal ASC");
  # $reviews->execute($id, $date);

  
  # Convert to array
  my @reviews;
  while(my $review = $reviews->fetchrow_hashref())
  {
     push @reviews, $review;
  }

  return @reviews;
}

@products = get_products();

$productN = 1;
foreach(@products)
{
  my $product = $_;
  my %fields = ();
    
  $date = -1;

  @averages = ();
  foreach my $i (0..$range-1) {
    $date = $date + 1;
    
    @reviews = getReviews($product->{'ProductID'}, $date);
    
  
    $average = 0.0;
    if (scalar @reviews) {
      foreach(@reviews)
      {
        $average += $_->{'Rating'};
      }
      push(@averages, $average / scalar @reviews );
    } else {
      push(@averages, -1);      
    }
  } 
  # print "@averages\n\n";
  
  foreach my $i (0..$range-1) {
    if ($averages[$i] == -1) {
      if ( $i == 0 ) {
        # If this is the first one, set it to 0
        $averages[$i] = $product->{'Raverage0t'};
      } else{
        # Set J to the next value, or 100 if there is none
        my $j = $i;
        while ($j < $range && $averages[$j] == -1) {
          $j++;
        }
        
        if ($j == $range) {
          $averages[$i] = $averages[$i-1];
        } else {
          my $increment = ($averages[$j]-$averages[$i-1]) / ($j-($i-1));
          foreach my $k ($i..$j-1) {
            $averages[$k] = $averages[$k-1] + $increment;
          }
        }
      }
    }
  }
  print "\nx(".$productN.",:) = [@averages];\n";
  $productN = $productN + 1;
  

  # $statement = SQLupdate('productinfo', $product->{'id'}, \%fields);
}

$dbh->disconnect();








