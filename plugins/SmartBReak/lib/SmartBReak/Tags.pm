package SmartBReak::Tags;
use strict;

use SmartBReak::Util;

sub _hdlr_smart_break {
    my ( $ctx, $args, $cond ) = @_;
    my $tokens = $ctx->stash( 'tokens' );
    my $builder = $ctx->stash( 'builder' );
    my $res = $builder->build( $ctx, $tokens, $cond );
    if ( $res ) {
        SmartBReak::Util::remove_break( $res );
    }
    return $res;
}

sub _fltr_smart_break {
    my ( $text, $arg, $ctx ) = @_;
    if ( $text ) {
        $text = SmartBReak::Util::remove_break( $text );
    }
    return $text;
}

1;
