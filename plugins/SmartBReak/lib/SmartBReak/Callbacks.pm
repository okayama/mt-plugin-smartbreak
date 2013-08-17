package SmartBReak::Callbacks;
use strict;

use SmartBReak::Util;

sub _cb_cms_post_save_entry {
	my ( $eh, $app, $obj, $original ) = @_;
	SmartBReak::Util::remove_break_from_entry( $obj );
    return 1;
}

1;
