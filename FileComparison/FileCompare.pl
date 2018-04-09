# Vijayaraaghavan Manoharan (AM.Vijay@gmail.com)
use strict;
use File::Find;
use File::Compare;
use POSIX 'strftime';


my $EMPTY_STRING = "";

my $directory1 = "D:/Feb11";
my $directory2 = "D:/Feb12";

my @directory1FileList;
my @directory2FileList;
my @matchingFileList;

my $now = strftime "%Y%m%d", localtime;
open HTML, ">comparisonReport".$now.".html";
print HTML "<html>\n";
print HTML "<title> Folder Comparison Report </title>\n";

# Fetch all files and directory names from Directory1
File::Find::find(sub {push(@directory1FileList,$File::Find::name)},$directory1);

# Fetch all files and directory names from Directory2
File::Find::find(sub {push(@directory2FileList,$File::Find::name)},$directory2);

# Remove the directory name in filelist 1  
my @trimFilelist1;
foreach my $temp1(sort @directory1FileList){	
	$temp1 =~ s/$directory1/$EMPTY_STRING/;
	push @trimFilelist1, $temp1;	
}

#Remove the directory name in filelist 2
my @trimFilelist2;
foreach my $temp2(sort @directory2FileList){	
	$temp2 =~ s/$directory2/$EMPTY_STRING/;
	push @trimFilelist2, $temp2;	 
}


print HTML "<H2> Files & Directory Exist only in $directory2, but not in $directory1</H2>\n";
print HTML "<table border='1'>\n";
print HTML "<tr><th>File/FolderName</th></tr>\n";
# Find the file list which are present in Directory 2 , but not in Directory 1
foreach my $temp2(sort @trimFilelist2){
	#print "Temp 2 :: $temp2 \n";
	my $matchFlag = 0;
	#print "matchFlag:: $matchFlag\n";
	foreach my $temp1(sort @trimFilelist1){
	#	print "Temp 1 :: $temp1 \n";
		if($temp1 eq $temp2){
	#		print "Match Found\n";
			push @matchingFileList, $temp2;
			$matchFlag = 1;
			last;
		}
	}
	
	#print "$matchFlag\n";
	if($matchFlag lt 1){
		print HTML "<tr><td>$directory2$temp2</td></tr>\n";		
		#print "$temp2 is not available in $directory1, but available $directory2\n";
	}
}
print HTML "</table>\n";


print HTML "<H2> Files & Directory Exist only in $directory1,  but not in $directory2</H2>\n";
print HTML "<table border='1'>\n";
print HTML "<tr><th>File/FolderName</th></tr>\n";
# Find the file list which are present in directory 1, but not in directory 2
foreach my $temp1(sort @trimFilelist1){
	#print "Temp 1 :: $temp1 \n";
	my $matchFlag = 0;
	#print "matchFlag:: $matchFlag\n";
	foreach my $temp2(sort @trimFilelist2){
	#	print "Temp 2 :: $temp2 \n";
		if($temp1 eq $temp2){
	#		print "Match Found\n";
			$matchFlag = 1;
			last;
		}
	}
	
	#print "$matchFlag\n";
	if($matchFlag lt 1){
		print HTML "<tr><td>$directory1$temp1</td></tr>\n";
		#print "$temp1 is not available in $directory2, but available $directory1\n";
	}
}

print HTML "</table>\n";


print HTML "<H2> Below Listed File Contents are different $directory1 and $directory2</H2>\n";
print HTML "<table border='1'>\n";
print HTML "<tr><th>Folder1 $directory1</th><th>Folder2 $directory2</th></tr>\n";
# Compare Matching File Content 
foreach my $file(sort @matchingFileList){	
	if(-f $directory1.$file && -f $directory2.$file){
		#print "File Name :: $file\n";
		if(compare($directory1.$file,$directory2.$file) ==0){
			#print "Mathcing File\n";
		}	
		else {
			print HTML "<tr><td>$directory1$file</td><td>$directory2$file</td></tr>\n";
			#print "Not Mathcing File\n";
		}
	}	 
}

print HTML "</table>\n";
print HTML "</html>\n";

close HTML;

