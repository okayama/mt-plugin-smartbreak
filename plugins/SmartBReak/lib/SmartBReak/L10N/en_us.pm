package SmartBReak::L10N::en_us;
use strict;
use base 'SmartBReak::L10N';
use vars qw( %Lexicon );

our %Lexicon = (
    '_PLUGIN_DESCRIPTION' => &_plugin_description,
);

sub _plugin_description {
    return<<'TEXT';
<p>
1. Remove duplidate &lt;br /&gt; tags at saving entry/page, from entry title, text, more, excerpt, keywords.<br />
2. Remove duplidate &lt;br /&gt; tags by 'smart_break' modifier.<br />
3. Remove duplidate &lt;br /&gt; tags in 'SmartBreak' block tag.<br />
4. Remove duplidate &lt;br /&gt; tags selected entry/page from plugin action.
</p>
<p>Following is example of case of judging &lt;br /&gt; is duplidate.<br /> 
・&lt;br /&gt; exists after Tabs/CR or LF/space after &lt;br /&gt; <br />
・&lt;br /&gt; exists after Tabs/CR or LF/space after &lt;p /&gt; <br />
・&lt;br /&gt; exists after Tabs/CR or LF/space after &lt;div /&gt; <br />
・&lt;br /&gt; exists after Tabs/CR or LF/space after &lt;li /&gt;<br />
・&lt;br /&gt; exists after Tabs/CR or LF/space after &lt;dd /&gt;
</p>
TEXT
}

1;
