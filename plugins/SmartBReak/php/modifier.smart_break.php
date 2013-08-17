<?php
function smarty_modifier_smart_break( $text ) {
    require_once( 'smart_break_lib.php' );
    return remove_break( $text );
}
?>