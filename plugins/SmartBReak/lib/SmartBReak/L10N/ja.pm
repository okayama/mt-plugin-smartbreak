package SmartBReak::L10N::ja;
use strict;
use base 'SmartBReak::L10N';
use vars qw( %Lexicon );

our %Lexicon = (
    '_PLUGIN_DESCRIPTION' => &_plugin_description,
    'Smart BReak' => '余分な改行タグの除去',
);

sub _plugin_description {
    return<<'TEXT';
<p>
1. エントリー保存時にタイトル、本文、続き、キーワード、概要欄から余分な &lt;br /&gt; を除去します。<br />
2. モディファイア smart_break により、出力結果から余分な &lt;br /&gt; を除去します。<br />
3. ブロックタグ SmartBreak により、囲んだ内容の出力結果から余分な &lt;br /&gt; を除去します。<br />
4. プラグインアクションにより、すでにデータが保存されてしまっているブログ記事/ウェブページ一覧からまとめて余分な &lt;br /&gt; を除去します。
</p>
<p>以下の場合を余分とみなします。<br />
・&lt;br /&gt; のあとにタブインデント/改行/スペースののちに &lt;br /&gt; がある場合<br />
・&lt;br /&gt; のあとにタブインデント/改行/スペースののちに &lt;/p&gt; がある場合<br />
・&lt;br /&gt; のあとにタブインデント/改行/スペースののちに &lt;/div&gt; がある場合<br />
・&lt;br /&gt; のあとにタブインデント/改行/スペースののちに &lt;/li&gt; がある場合<br />
・&lt;br /&gt; のあとにタブインデント/改行/スペースののちに &lt;/dd&gt; がある場合
</p>
TEXT
}

1;
