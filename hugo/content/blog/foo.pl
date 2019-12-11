use strict;
use warnings;

while( <> ) {
    my $name = $_;
    $name =~ s!^\s+!!;
    $name =~ s!\s+$!!;

    if( $name =~ m!^(\d\d\d\d)-(\d\d)-(\d\d)-(.*)$! ) {
        # print "Match $name\n";
        my $newDir = "$1/$2/$3";
        my $newName = "$1/$2/$3/$4";
        print( `mkdir -p $newDir` );
        print( `mv $name $newName` );
    # } else {
        # print "No $name\n";
    }
}

1;
