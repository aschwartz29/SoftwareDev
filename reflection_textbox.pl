#!/usr/local/bin/perl
# adapted from code by the cgi guru Lincoln Stein
use CGI;
$query = new CGI;
print $query->header;
print $query->start_html('Text Reflection');

unless ($query->param) {
    &print_prompt($query);
} else {
    &do_work($query);
}

####
sub print_prompt {
    my($query) = @_;
    print <<END;
<H1>Text Entry Reflection</H1>
Type or paste test into the text-box for upload.
When you press the submit button, this script
will reflect the text back to your browser view.  (The idea
is that more involved file manipulations, than the identity,
can be done in further efforts.)
END
    ;
    print
	$query->start_form,
	"Enter the text to process:<BR>",
	$query->textarea(-name=>'textentry',
			  -rows=>10,-cols=>84),"<P>",
	$query->submit(-label=>'Process File'),
	$query->end_form;
}

sub do_work {
    my($query) = @_;
    my($message);

    $query->import_names('Q');
    $message = <<END;
<HR>\n
<H2>The following text was entered:</H2>\n
<PRE>
$Q::textentry
</PRE>
END
    ;
    print "$message";
    print "<HR>\n";
}

sub print_tail {
    print <<END;
<HR>
END
    ;
    print $query->end_html;
}
