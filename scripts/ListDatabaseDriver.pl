
use DBI;

#Fetch All Driver Name
my @driverCollection = DBI->available_drivers();

foreach my $driverName(@driverCollection) {
	print "$driverName\n";
}