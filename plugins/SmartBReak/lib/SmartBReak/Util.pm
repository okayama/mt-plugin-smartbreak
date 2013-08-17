package SmartBReak::Util;
use strict;

sub remove_break_from_entry {
    my ( $entry ) = @_;
    return unless $entry;
    my @columns = ( 'title', 'text', 'text_more', 'keywords', 'excerpt' );
    my ( $saved, $updated ) = ( 0, 0 );
    for my $column ( @columns ) {
        if ( my $text = $entry->$column ) {
            $entry->$column( remove_break( $text ) );
            $updated++;
        }
    }
    if ( $updated ) {
        $entry->save or die $entry->errstr;
        $saved++;
    }
    return $saved;
}

sub remove_break {
    my ( $text ) = @_;
    if ( $text ) {
        my $search_br = quotemeta( '<br />' );
        my $search_p_end = quotemeta( '</p>' );
        my $search_div_end = quotemeta( '</div>' );
        my $search_li_end = quotemeta( '</li>' );
        my $search_dd_end = quotemeta( '</dd>' );
        my @searches = ( $search_br, $search_p_end, $search_div_end, $search_li_end, $search_dd_end );
        for my $search ( @searches ) {
            while ( $text =~ /$search_br[\s\t\n]*$search/s ) {
                $text =~ s/$search_br[\s\t\n]*($search)/$1/s;
            }
        }
        return $text;
    }
}

1;
