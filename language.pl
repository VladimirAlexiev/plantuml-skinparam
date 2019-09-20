#!perl -wn
# java -jar plantuml.jar -language > language.txt
# perl skinparam.pl language.txt |sort|uniq -c|sort -rn > skinparam.txt

$skip = m{;skinparameter}..m{;color};
$skip && $skip>2 && $skip!~m{E0} && m{.} or next;
chomp;
my $orig = $_;
for my $re (@re) {
  s{$re->[0]}{$re->[1]}i;
}
print "$_\n";  # to debug: "$orig\t$_\n";

BEGIN {
  $re = << 'EOF';
| FONT               | Font(Color|Name|Size|Style) |
| COLOR              | (|Background|Border)Color |
| ARROW              | Arrow(|Lollipop)(COLOR|FONT|Thickness) |
| ENTITY             | (Agent|Archimate|Artifact|Boundary|Card|Cloud|Control|Database|DesignedDomain|Domain|Entity|File|Folder|Frame|Interface|Machine|Node(?!sep)|Queue|Rectangle|Requirement|Stack|Storage|Usecase) |
| layout-params      | Dpi|MinClassWidth|SameClassWidth|Nodesep|Ranksep|(Box|Participant|)Padding|Linetype|SwimlaneWidth |
| link-params        | HyperlinkCOLOR|HyperlinkUnderline|SvglinkTarget |
| text-params        | DefaultMonospacedFONT|Guillemet|Handwritten|MaxAsciiMessageLength|MaxMessageSize|TabSize |
| alignment          | ResponseMessageBelowArrow|(Default|Note|(Sequence|State)Message)TextAlignment|(Arrow|Package|Sequence|State)(Message|Reference|Title)Alignment |
| other-params       | ^BackgroundColor|COLORArrowSeparationSpace|GenericDisplay|FixCircleLabelOverlapping|LifelineStrategy|PageMargin|(TitleBorder|)RoundCorner|SwimlaneWrapTitleWidth|(|Note)Shadowing|WrapWidth |
| attribute-params   | (Class|Object|State)AttributeFONT |
| border-thickness   | (ENTITY|Archimate|Activity|Class|Component|Diagram|Legend|Note|Object|Package|Partition|Sequence(Actor|Divider|Group|LifeLine|Participant|Reference)|Swimlane|Title|Usecase)BorderThickness |
| icon-params        | Icon(IEMandatory|Package|Private|Protected|Public)COLOR|ClassAttributeIconSize|CircledCharacter(FONT|Radius) |
| color-params       | (ENTITY|Actor|Designed|Biddable|Lexical|Activity(|Start|End|Bar|Diamond)|Class(|Header)|Collections|Component|Diagram|Enum|Generic|Interface|Note|Object|Package|Page|PageExternal|Participant|Partition|PathHover|Swimlane(|Title)|State(|Start|End|Bar)|Timing|Usecase(|Actor))COLOR |
| font-params        | (ENTITY|Actor|Activity(|Diamond)|Class(|Header)|Collections|Component|Diagram|Enum|Generic|Interface|Note|Object|Package|PathHover|Participant|Partition|SwimlaneTitle|State|Timing|Usecase(|Actor))FONT |
| arrow-params       | (ENTITY|Activity(|Diamond)|Class(|Header)|Collections|Diagram|Enum|Generic|Interface|Note|PathHover|Partition|Swimlane|State|Timing|Usecase(|Actor))ARROW |
| sequence-params    | Sequence(|Actor|Box|Delay|Divider|Group(|Body|Header)|LifeLine|NewpageSeparator|Participant|Reference(|Header)|Title)(ARROW|COLOR|FONT)|SequenceParticipant |
| stereotype-font    | (ENTITY|Actor|Class|Component|Interface|Object|Package|Participant|Sequence|Usecase(|Actor))StereotypeFONT |
| stereotype-params  | Stereotype(Position|[ACEIN]COLOR) |
| style              | (Component|Condition(|End)|Package|)Style |
| global-font/color  | Monochrome|(Caption|Default|Footer|Header|Legend|Title)(FONT|COLOR) |
EOF
  @re = map {
    my ($x,$y) = m{\| (.*?) +\| (.*?) \|$} or die "BAD: $_";
    [qr{$y}, $x]
  } split /\n/, $re;
}
