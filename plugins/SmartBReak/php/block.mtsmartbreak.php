<?php
function smarty_block_mtsmartbreak( $args, $content, &$ctx, &$repeat ) {
    require_once( 'smart_break_lib.php' );
    return remove_break( $content );
}
?>