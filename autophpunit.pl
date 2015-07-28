#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: autophpunit.pl
#
#        USAGE: ./autophpunit.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 27.07.2015 20:09:23
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

use Data::Dumper;


sub parseMethod
{
		
	my($name, $param, $body) =@_;
	
	print "methodName",$name,"\n";

	#параметры разбить по одному
	#а также определить их типо изходя из тела
	#если не определено то задавать false
	#еще определить если встречаюитья внутрение пераметры определить их тип и прочее
	#определить переменные походу выполнения метода
	print "param: $param \n";
	
	#разбить на подблоки и затем проходить 
	#каждый длок по отдельности
	#также оределить блоки которые в которых есть ретурн
	#затем подсчитать количество ретурнов 
	#и составить варианты прохода по все ретурнам 
	#а также определить участки кода вне блоков 
	#и также ух учитывать (назовем их внеблочные участки)
	
	print $body;
}	

sub searchClass
{
	my($text) =@_;
	
	my $nextstr = '[\n\r\t\a]';
	my $block = '(.*)?' . "$nextstr?" . '(.*)?' . "$nextstr?". '(.*)?';
	my $strsearch = '\{('
	. "($block)*"
	.')\}';

	#print $strsearch;

	$text=~s/$strsearch/serchMethod($1)/ge;
}

sub serchMethod
{
	my($text) =@_;
	
	
	my $parseName	= '(\w+)';
	my $parseParams = '(\(.*\))';
	my $block = '(.*)?' . '\s*' . '(.*)?' . '\s*' . '(.*)?';

	my $strsearch = $parseName
	. '\s*'
	. $parseParams
	. '\s*'
	. '(\{('
	. "($block)*"
	. ')\})';

	#print $strsearch;

	$text=~s/$strsearch/parseMethod($1,$2,$3)/ge;
}

sub main
{
	my ($file) = 'test.php';

	local $/=undef;
	open my $fh , "<$file" or return 0;
	my $text = <$fh>;
	close $fh;

	#$text=~s/\n/''/ge;
	
	searchClass($text);
	
	#print $text;
	#print Dumper $text , "good";
}

main();
