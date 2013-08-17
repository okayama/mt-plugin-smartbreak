package SmartBReak::Plugin;
use strict;

use SmartBReak::Util;

sub _list_actions_smart_break_action {
    my $app = MT->instance;
    my $class = $app->param( '_type' );
    my $can_copy_entries = $class eq 'entry'
                                ? $app->can_do( 'access_to_entry_list' )
                                : $app->can_do( 'access_to_page_list' );
    unless ( $can_copy_entries ) {
        return $app->trans_error( 'Permission denied.' );
    }
    my @ids = $app->param( 'id' ) or return $app->trans_error( 'Invalid request.' );
    my $saved = 0;
    for my $id ( @ids ) {
        my $entry = MT::Entry->load( { id => $id }, );
        next unless $app->permissions->can_edit_entry( $entry, $app->user );
        $saved += SmartBReak::Util::remove_break_from_entry( $entry );
    }
    my $return_url = $app->base . $app->uri( mode => 'list',
                                             args => { ( $app->blog ? ( blog_id => $app->blog->id ) : () ),
                                                       ( $saved ? ( saved => 1 ) : () ),
                                                       _type => $class,
                                                     },
                                           );
    $app->redirect( $return_url );
}

1;
