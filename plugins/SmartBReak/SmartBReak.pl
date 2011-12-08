package MT::Plugin::SmartBReak;
use strict;
use MT;
use MT::Plugin;
@MT::Plugin::SmartBReak::ISA = qw( MT::Plugin );

our $VERSION = "1.0";

my $plugin = new MT::Plugin::SmartBReak( {
    id => 'SmartBReak',
    key => 'smartbreak',
    name => 'SmartBReak',
    author_name => 'okayama',
    author_link => 'http://weeeblog.net/',
    description => '<MT_TRANS phrase=\'_PLUGIN_DESCRIPTION\'>',
	version => $VERSION,
    l10n_class => 'SmartBReak::L10N',
} );

MT->add_plugin( $plugin );

sub init_registry {
    my $plugin = shift;
    $plugin->registry( {
        applications => {
            cms => {
                list_actions => {
                    entry => {
                        smartbreak => {
                            label => 'Smart Break',
                            code => \&_smart_break_action,
                            permit_action => {
                                permit_action => 'publish_post',
                                include_all => 1,
                            },
                        },
                    },
                    page => {
                        smartbreak => {
                            label => 'Smart Break',
                            code => \&_smart_break_action,
                            permit_action => {
                                permit_action => 'manage_pages',
                                include_all => 1,
                            },
                        },
                    },
                },
            },
        },
        callbacks => {
            'cms_post_save.entry',
                => \&_post_save_entry,
            'cms_post_save.page',
                => \&_post_save_entry,
            'api_post_save.entry',
                => \&_post_save_entry,
            'api_post_save.page',
                => \&_post_save_entry,
        },
        tags => {
            block => {
                'SmartBReak' => \&_hdlr_smart_break,
            },
            modifier => {
                'smart_break' => \&_fltr_smart_break,
            },
        },
   } );
}

sub _smart_break_action {
    my $app = MT->instance;
    my $class = $app->param( '_type' );
    my $can_copy_entries = $class eq 'entry' ? $app->can_do( 'create_new_entry' ) : $app->can_do( 'create_new_page' ) ;
    unless ( $can_copy_entries ) {
        return $app->trans_error( 'Permission denied.' );
    }
    my @ids = $app->param( 'id' ) or return $app->trans_error( 'Invalid request.' );
    my $saved = 0;
    for my $id ( @ids ) {
        my $entry = MT::Entry->load( { id => $id },
                                     { no_class => 1 },
                                   );
        $saved += _remove_break_from_entry( $entry );
    }
    my $class = $app->param( '_type' );
    my $return_url = $app->base . $app->uri( mode => 'list_' . $class,
                                             args => { ( $app->blog ? ( blog_id => $app->blog->id ) : () ),
                                                       ( $saved ? ( saved => 1 ) : () ),
                                                     },
                                           );
    $app->redirect( $return_url );
}

sub _hdlr_smart_break {
    my ( $ctx, $args, $cond ) = @_;
    my $tokens = $ctx->stash( 'tokens' );
    my $builder = $ctx->stash( 'builder' );
    my $res = $builder->build( $ctx, $tokens, $cond );
    if ( $res ) {
        _remove_break( $res );
    }
    return $res;
}

sub _fltr_smart_break {
    my ( $text, $arg, $ctx ) = @_;
    if ( $text ) {
        $text = _remove_break( $text );
    }
    return $text;
}

sub _post_save_entry {
	my ( $eh, $app, $obj, $original ) = @_;
	_remove_break_from_entry( $obj );
    return 1;
}

sub _remove_break_from_entry {
    my ( $entry ) = @_;
    return unless $entry;
    my @columns = ( 'title', 'text', 'text_more', 'keywords', 'excerpt' );
    my ( $saved, $updated ) = ( 0, 0 );
    for my $column ( @columns ) {
        if ( my $text = $entry->$column ) {
            $entry->$column( _remove_break( $text ) );
            $updated++;
        }
    }
    if ( $updated ) {
        $entry->save or die $entry->errstr;
        $saved++;
    }
    return $saved;
}

sub _remove_break {
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



