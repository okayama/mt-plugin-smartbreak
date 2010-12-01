<?php
function remove_break( $text ) {
    $search_br = preg_quote( '<br />', '/' );
    $search_p_end = preg_quote( '</p>', '/' );
    $search_div_end = preg_quote( '</div>', '/' );
    $search_li_end = preg_quote( '</li>', '/' );
    $search_dd_end = preg_quote( '</dd>', '/' );
    $searches = array( $search_br, $search_p_end, $search_div_end, $search_li_end, $search_dd_end );
    foreach ( $searches as $search ) {
        while ( preg_match( "/{$search_br}[\s\t\n]*{$search}/", $text ) ) {
            $text = preg_replace( "/{$search_br}[\s\t\n]*({$search})/", "$1", $text );
        }
    }
    return $text;
}
?>