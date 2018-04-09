#!/usr/bin/perl
use DBI;
use DBD::Oracle;


my $ORACLE_HOME = "C:\\Oracle\\product\\10.2.0\\client_1";
$ENV{ORACLE_HOME}=$ORACLE_HOME;

print "$ORACLE_HOME";

my $host="hostname.test.com";
my $sid="DBSID";
my $port="1523";
my $user="xxxxx";
my $passwd="xxxxxx";

my $dbh = DBI->connect("DBI:Oracle:host=$host;sid=$sid;port=$port", $user, $passwd)
or die "Unable to Connect to database";

$dbh->disconnect;