%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% uvathesis.cls - Version 2.0 - March 2019
%                 Trey Wenger (tvw2pu@virginia.edu)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is a modified version of various iterations of a similar
% class file.
%   easychithesis.cls (Version 1.5) - April 1999
%     Bryan Clair and Nathan Dunfield
%   easyuvathesis.cls - March 2000
%     Brad Holden
%   easyuvathesis.cls - January 2001
%     Chris Palma
%   easyuvathesis.cls - June 2014
%     George Privon and Lisa May Walker
%   uvathesis.cls - March 2019
%     Trey Wenger
%
% INSTRUCTIONS:
%
% This file provides the LaTeX style uvathesis for formating
% graduate theses at the University of Virginia. UVA no longer
% requires strict formatting, other than the following order:
%   Title Page (no signatures)
%   Copyright Page
%   Abstract
%   Dedication/Acknowledgements (optional)
%   Body of Text
%
% The easiest way to use this class file is to modify the included
% thesis.tex file.
%
% To invoke this class file, put this at the begnning of your
% document (default is two-sided, doublespace, 12pt):
%
%   \documentclass{uvathesis}
%
% Options include:
%  10pt,11pt,12pt (default 12pt)
%  oneside,twoside (default twoside)
%  onehalfspace,singlespace,doublespace (default doublespace)
%
% This class merely extends the LaTeX default ``report'' class,
% so many of the ``report'' features are available in addition
% to the uvathesis.cls-specific features listed below.
%
% TVW Addition March 2019
%
% Environment: thesistable and longthesistable
% This environment provides a tabular environment similar to AASTeX's
% deluxetable, which allows for user-friendly tables that may be
% rotated and/or span multiple pages. Many (but certainly not all)
% of the deluxetable features are included. Here is an example of use:
%
% \afterpage{\clearpage} % start this table after the page ends
% \begin{thesistable}{ccc} % or \begin{longthesistable}
%   \rotatetable
%   \tablespacing{\singlespacing}
%   \tabletypesize{\normalsize}
%   \tablecaption[Short caption for list of tables]{Long caption for table}
%   \tablelabel{\label{tab:my_table}}
%   \tablehead{
%     \colhead{Col1} & \colhead{Col2} & \colhead{Col3} \\
%     \colhead(Units1} & \colhead{Units2} & \colhead{Units3} \\
%   }
%   \tabledata{
%      Data1 & \nodata\tablenotemark{a} & Ref \\
%   }
%   \tablecomments{Here's a note}
%   \tablenotetext{a}{Here's a footnote}
%   \tablerefs{Here are some references}
% \end{thesistable} % or \end{longthesistable}
% \clearpage % nothing else on this page
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLASS DEFINITION
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{uvathesis}[2018/12/15 UVA Thesis Class]

% Load the setspace package
\RequirePackage{setspace}

% Define the one/two-sided option
\newcommand{\mypageside}{oneside}
\newcommand{\mylefthdr}{L}
\newcommand{\myrighthdr}{R}
\DeclareOption{oneside}{
  \renewcommand{\mypageside}{oneside}
  \renewcommand{\mylefthdr}{L}
  \renewcommand{\myrighthdr}{R}
}
\DeclareOption{twoside}{
  \renewcommand{\mypageside}{twoside}
  \renewcommand{\mylefthdr}{RE,LO}
  \renewcommand{\myrighthdr}{RO,LE}
}

% Define the font size options
\newcommand{\myfontsize}{12pt}
\DeclareOption{10pt}{\renewcommand{\myfontsize}{10pt}}
\DeclareOption{11pt}{\renewcommand{\myfontsize}{11pt}}
\DeclareOption{12pt}{\renewcommand{\myfontsize}{12pt}}

% Define the line spacing options
\newcommand{\mylinespacing}{\doublespacing}
\DeclareOption{doublespace}{\renewcommand{\mylinespacing}{\doublespacing}}
\DeclareOption{onehalfspace}{\renewcommand{\mylinespacing}{\onehalfspacing}}
\DeclareOption{singlespace}{\renewcommand{\mylinespacing}{\singlespacing}}

% Pass all other options to report.cls
\DeclareOption*{
 \PassOptionsToClass{\CurrentOption}{report}
}
\ProcessOptions\relax

% Load the report class
\LoadClass[\myfontsize,\mypageside,letterpaper]{report}

% Set line spacing
\mylinespacing

% Set page margins
\RequirePackage[paperheight=\paperheight, paperwidth=\paperwidth,
  top=1.0in, bottom=1.0in, inner=1.5in, outer=1.0in,
  footskip=0.1in, headsep=0.2in, headheight=0.25in,
  includehead, includefoot, heightrounded]{geometry}

% Load other packages
\RequirePackage[titletoc]{appendix}
\RequirePackage{graphicx}
\RequirePackage[T1]{fontenc}
\RequirePackage[colorlinks,linkcolor=black,citecolor=black,
  filecolor=black,urlcolor=black,bookmarks=false,
  breaklinks=true]{hyperref}
\RequirePackage{rotating}

% Support for footer graphics
\newcounter{countfooter}
\newcommand{\footerimage}[2]{
  \gdef\footer@image{#1}
}
\let\footer@image\@empty
\let\footer@start\@empty

% Define pagestyles
% empty - no header/footer
% plain - just page number in header (i.e. for first page of chapter)
% uvathesis - header w/ chapter name
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[\myrighthdr]{\thepage}
  \renewcommand{\headrulewidth}{0.0pt}
  \renewcommand{\footrulewidth}{0.0pt}
  \ifx\footer@start\@empty\else
  \ifx\footer@image\@empty\else
  \fancyfoot[\myrighthdr]{\setlength{\unitlength}{1mm}
    \stepcounter{countfooter}
    \begin{picture}(0,0)
      \put(0,-15){\includegraphics[width=0.1\textwidth]{\footer@image\thecountfooter}}
    \end{picture}
  }
  \fi\fi
}
\fancypagestyle{uvathesis}{
  \fancyhf{}
  \fancyhead[\mylefthdr]{\scshape{\nouppercase{\leftmark}}}
  \fancyhead[\myrighthdr]{\thepage}
  \renewcommand{\headrulewidth}{0.0pt}
  \renewcommand{\footrulewidth}{0.0pt}
  \ifx\footer@start\@empty\else
  \ifx\footer@image\@empty\else
  \fancyfoot[\myrighthdr]{\setlength{\unitlength}{1mm}
    \stepcounter{countfooter}
    \begin{picture}(0,0)
      \put(0,-15){\includegraphics[width=0.1\textwidth]{\footer@image\thecountfooter}}
    \end{picture}
  }
  \fi\fi
}
\pagestyle{uvathesis}

% Remove spacing between paragraphs
\setlength{\parskip}{0pt}

% Load the titlesec package and make chapters/sections fancy
\RequirePackage{titlesec}
\titlespacing{\section}{0pt}{2pt}{4pt}
\titlespacing{\subsection}{0pt}{2pt}{4pt}
\titlespacing{\subsubsection}{0pt}{2pt}{4pt}

% Make the chapter and sections fancier
\titleformat{\chapter}[display]
  {\normalfont\Large\scshape\centering}{\chaptertitlename\ \thechapter}{20pt}{\bfseries\Huge}
\titleformat{\section}[block]
  {\normalfont\Large\bfseries\scshape\centering}{\thesection}{10pt}{\Large}
\titleformat{\subsection}
  {\normalfont\large\bfseries}{\thesubsection}{10pt}{\large}
\titleformat{\subsubsection}
            {\normalfont\large\bfseries}{\thesubsubsection}{10pt}{\large}

% New command for marker-less footnotes
\newcommand\blfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\footnote{#1}%
  \addtocounter{footnote}{-1}%
  \endgroup
}            

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLASS FEATURES
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set the page numbering to roman numerals for the beginning
\newcommand{\frontmatter}{%
  \pagenumbering{roman}
}

% Define commands for title page
\renewcommand{\title}[1]{\gdef\@title{#1}}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\bachelors}[1]{\gdef\@bach{#1}}
\newcommand{\masters}[1]{\gdef\@mast{#1}}
\newcommand{\masterstwo}[1]{\gdef\@masttwo{#1}}
\newcommand{\hometown}[1]{\gdef\@hometown{#1}}
\newcommand{\commencementdate}[1]{\gdef\@degreedate{#1}}
\newcommand{\commencementmonthyear}[1]{\gdef\@degreemonthyear{#1}}
\newcommand{\degreename}[1]{\gdef\@degreename{#1}}
\newcommand{\committeeone}[1]{\gdef\@commone{#1}}
\newcommand{\committeetwo}[1]{\gdef\@commtwo{#1}}
\newcommand{\committeethree}[1]{\gdef\@commthree{#1}}
\newcommand{\committeefour}[1]{\gdef\@commfour{#1}}
\newcommand{\committeefive}[1]{\gdef\@commfive{#1}}

% Define the title page
\renewcommand{\maketitle}{%
  % title page (single space)
  \begin{titlepage}
    \thispagestyle{empty}
    \singlespace
    \begin{center}
      {\huge\textbf{\textsc{\@title}}}
      
      \vspace{1.25in}
      {\Large\textbf{\@author}}
             
      \vspace{0.05in}
      \@hometown
      
      \vspace{0.5in}
      \@bach
      
      %\vspace{0.15in}
      \@mast
      
      %\vspace{0.15in}
      \@masttwo
      
      \vspace{1.0in}
      A Dissertation Presented to the \\
      Graduate Faculty of the \\
      \vspace{0.10in}
      {\large\textit{University of Virginia}} \\
      \vspace{0.10in}   
      in Candidacy for the Degree of \\
      \vspace{0.10in}
      {\large\textit{\@degreename}}
      
      \vspace{0.4in}
      \@department
      
      \vspace{0.4in}
      University of Virginia \\
      \@degreemonthyear
      
      \vfill
      \hspace{3.75in} Committee Members: \\
      \hspace{3.75in}\@commone \\
      \hspace{3.75in}\@commtwo \\
      \hspace{3.75in}\@commthree \\
      \hspace{3.75in}\@commfour \\
      \hspace{3.75in}\@commfive
    \end{center}
  \end{titlepage}
}

% Define the copyright page
\newcommand{\makecopyright}{%
  \clearpage
  \thispagestyle{empty}
  \begin{center}
    \mbox{}
    \vfill
    \copyright\ Copyright by \\
    \@author \\
    All rights reserved \\
    \@degreedate
  \end{center}
}

% Define abstract page
\newcommand{\makeabstract}[1]{%
  \cleardoublepage
  \begingroup
  \renewcommand{\cleardoublepage}{}
  \renewcommand{\clearpage}{}
  \chapter*{Abstract}
  \addcontentsline{toc}{chapter}{Abstract}
  \include{#1}
  \endgroup
}

% Define acknowledgements page
\newcommand{\makeacknowledgements}[1]{%
  \cleardoublepage
  \begingroup
  \renewcommand{\cleardoublepage}{}
  \renewcommand{\clearpage}{}
  \chapter*{Acknowledgements}
  \addcontentsline{toc}{chapter}{Acknowledgements}
  \include{#1}
  \endgroup
}

% Define dedication page (no chapter title)
\newcommand{\makededication}[1]{%
  \cleardoublepage
  \thispagestyle{empty}
  \vspace*{\fill}
  \begin{center}
    #1
  \end{center}
  \vspace*{\fill}
}

% Set name of Table of Contents
\renewcommand{\contentsname}{Table of Contents}

% Set name of References
\renewcommand{\bibname}{References}

% Make the table of contents single spaced
\let\oldtableofcontents = \tableofcontents
\renewcommand{\tableofcontents}{%
  \begin{singlespace} 
    \oldtableofcontents 
  \end{singlespace}
}

% Make the list of figures single spaced and add to
% table of contents
\let\oldlistoffigures = \listoffigures
\renewcommand{\listoffigures}{%
  \begin{singlespace} 
    \oldlistoffigures
    \addcontentsline{toc}{chapter}{List of Figures}
  \end{singlespace}
}

% Make the list of tables single spaced and add to
% table of contents
\let\oldlistoftables = \listoftables
\renewcommand{\listoftables}{%
  \begin{singlespace} 
    \oldlistoftables
    \addcontentsline{toc}{chapter}{List of Tables}
  \end{singlespace}
}

% Switch to numbers
\newcommand{\mainmatter}{%
  \cleardoublepage
  \pagenumbering{arabic}
  \let\footer@start = 1
  \pagestyle{uvathesis}
}

% Add bibliography to table of contents, switch to single spacing
\newcommand{\makereferences}[1]{%
  \cleardoublepage
  \begin{onehalfspacing}
    \addcontentsline{toc}{chapter}{References}
    \bibliography{thesis}
  \end{onehalfspacing}
}

% Define biographical sketch
\newcommand{\makebiosketch}[1]{%
  \cleardoublepage
  \let\footer@start\@empty
  \pagestyle{uvathesis}
  \begingroup
  \renewcommand{\cleardoublepage}{}
  \renewcommand{\clearpage}{}
  \chapter*{Biographical Sketch}
  \markboth{Biographical Sketch}{Biographical Sketch}
  \addcontentsline{toc}{chapter}{Biographical Sketch}
  \include{#1}
  \endgroup
}

% Define biographical sketch
\newcommand{\makecv}[1]{%
  \cleardoublepage
  \begingroup
  \renewcommand{\cleardoublepage}{}
  \renewcommand{\clearpage}{}
  \singlespacing
  \chapter*{Curriculum Vitae}
  \markboth{Curriculum Vitae}{Curriculum Vitae}
  \addcontentsline{toc}{chapter}{Curriculum Vitae}
  \include{#1}
  \endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% THESISTABLE ENVIRONMENTS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add the thesistable environments for creating properly-formatted
% tables.

% Load the packages required for thesistable(s)
\RequirePackage{lscape}
\RequirePackage{longtable}
\RequirePackage{threeparttablex}
\RequirePackage{caption}

% Define \nodata
\newcommand{\nodata}{~$\cdots$~}

% Define macro for font size
\newcommand{\tabletypesize}[1]{%
  \gdef\table@typesize{#1}
}
\let\table@typesize\normalsize

% Define macro for line spacing
\newcommand{\tablespacing}[1]{%
  \gdef\table@spacing{#1}
}
\let\table@spacing\singlespacing

% Define macro for table width
\newcommand{\tablewidth}[1]{%
  \gdef\table@width{#1}
}
\let\table@width\@empty

% Define macro for landscape
\newcommand{\rotatetable}{%
  \gdef\table@rotatetable{rotatetable}
}
\let\table@rotatetable\@empty

% Define macro for captions
\newcommand{\tablecaption}[2][\@empty]{%
  \gdef\table@maincaption{#2}
  \gdef\table@sidecaption{#1}
}
\let\table@maincaption\@empty
\let\table@sidecaption\@empty

% Define macro for table label
\newcommand{\tablelabel}[1]{%
  \gdef\table@label{#1}
}
\let\table@label\@empty

% Define macros for table header(s)
\newcommand{\colhead}[1]{\multicolumn{1}{c}{#1}}
\newcommand{\tablehead}[1]{%
  \gdef\table@head{#1}
}
\let\table@head\@empty

% Define macro for data
\newcommand{\tabledata}[1]{%
  \gdef\table@data{#1}
}
\let\table@data\@empty

% Define macro for tablenotemark
\newcommand{\tablenotemark}[1]{\(^{#1}\)}

% Define macros formating table notes, comments, and references
\newcommand{\@tablenotetext}[2]{%
  \item[\(#1\)]#2\par
}
\newcommand{\@tablecomments}[1]{%
  \item[] \hspace{-1em} {\sc Note} --- #1\par
}
\newcommand{\@tablerefs}[1]{%
  \item[] \hspace{-1em} \textbf{References} --- #1\par
}

% Macros for token lists (lifted from deluxetable.sty)
\def\appgdef#1#2{% 
 \@ifxundefined#1{\toks@{}}{\toks@\expandafter{#1}}% 
 \toks@ii{#2}% 
 \xdef#1{\the\toks@\the\toks@ii}% 
}% 
\toksdef\toks@ii=\tw@ 
\long\def\@ifxundefined#1{\@ifx{\undefined#1}}%
\let\table@notes\@empty

% Define macro for table notes, comments, and references
\newcommand{\tablenotetext}[2]{%
  \appgdef\table@notes{\@tablenotetext{#1}{#2}}
}
\newcommand{\tablecomments}[1]{%
  \appgdef\table@notes{\@tablecomments{#1}}
}
\newcommand{\tablerefs}[1]{%
  \appgdef\table@notes{\@tablerefs{#1}}
}

% Define macros for printing table notes
\newcommand{\spew@tablenotes}{
  \ifx\table@notes\@empty\else\@tablenotes{\table@notes}\fi
}
\newcommand{\@tablenotes}[1]{%
  #1%
}

% Define single-page, un-rotated thesistable
% Argument is tabular column definitions
\newenvironment{thesistable}[1]{%
  % store format string
  \def\table@format{#1}
}{
  % Set landscape mode
  \ifx\table@rotatetable\@empty\else
  \begin{landscape}
  \fi
  \begin{table}
    \centering
    % Set table font size
    \ifx\table@typesize\@empty\else\table@typesize\fi
    % Set table spacing
    \ifx\table@spacing\@empty\else\table@spacing\fi
    \begin{threeparttable}
      % Set table caption
      \ifx\table@maincaption\@empty\else
      \caption[\table@sidecaption]{\table@maincaption\table@label}
      \fi
      % Use tabular* if we're setting the table width
      \ifx\table@width\@empty
      \begin{tabular}{\table@format}
      \else
      \begin{tabular*}{\table@width}{@{\extracolsep{\fill}}\table@format}
      \fi
        % Set table header
        \hline\hline\noalign{\vskip 0.5em}
        \ifx\table@head\empty\else\table@head\fi \\
        \noalign{\vskip 0.5em}\hline\noalign{\vskip 0.5em}
        % Set table data
        \ifx\table@data\@empty\else\table@data\fi
        \noalign{\vskip 0.5em}\hline
      % end tabular or tabular*
      \ifx\table@width\@empty
      \end{tabular}
      \else
      \end{tabular*}
      \fi
      % Set table footnotes if any
      \ifx\table@notes\@empty\else
      \begin{tablenotes}
        \footnotesize
        \spew@tablenotes
      \end{tablenotes}
      \fi
    \end{threeparttable}
  \end{table}
  % End landscape mode
  \ifx\table@rotatetable\@empty\else
  \end{landscape}
  \fi
  % Reset parameters
  \global\let\table@typesize\normalsize
  \global\let\table@spacing\singlespacing
  \global\let\table@width\@empty
  \global\let\table@rotatetable\@empty
  \global\let\table@label\@empty
  \global\let\table@maincaption\@empty
  \global\let\table@sidecaption\@empty
  \global\let\table@head\@empty
  \global\let\table@data\@empty
  \global\let\table@notes\@empty
}

% Define multi-page, un-rotated thesistable
% Argument is tabular column definitions
\newenvironment{longthesistable}[1]{%
  % store format string
  \def\table@format{#1}
}{
  % Set landscape mode
  \ifx\table@rotatetable\@empty\else
  \begin{landscape}
  \fi
  \begin{ThreePartTable}
    \centering
    % Set table font size
    \ifx\table@typesize\@empty\else\table@typesize\fi
    % Set table spacing
    \ifx\table@spacing\@empty\else\table@spacing\fi
    % Set table footnotes if any
    \ifx\table@notes\@empty\else
    \begin{TableNotes}
      \footnotesize
      \spew@tablenotes
    \end{TableNotes}
    \fi
    \begin{longtable}{\table@format}
      % Set table caption (first page)
      \ifx\table@maincaption\@empty\else
      \caption[\table@sidecaption]{\table@maincaption\table@label} \\
      \fi
      % Set table header (first page)
      \hline\hline\noalign{\vskip 0.5em}
      \ifx\table@head\empty\else\table@head\fi \\
      \noalign{\vskip 0.5em}\hline\noalign{\vskip 0.5em}
      \endfirsthead
      % Set table caption (other pages)
      \ifx\table@maincaption\@empty\else
      \caption[]{\table@maincaption\enskip (continued)} \\
      \fi
      % Set table header (other pages)
      \hline\hline\noalign{\vskip 0.5em}
      \ifx\table@head\empty\else\table@head\fi \\
      \noalign{\vskip 0.5em}\hline\noalign{\vskip 0.5em}
      \endhead
      % Set footer (all but last page)
      \noalign{\vskip 0.5em}\hline\noalign{\vskip 0.5em}
      \multicolumn{\LT@cols}{c}{Table~\thetable\enskip continued} \\
      \endfoot
      % Set footer (last page)
      \noalign{\vskip 0.5em}\hline
      \ifx\table@notes\@empty\else\insertTableNotes\fi
      \endlastfoot
      % Set table data
      \ifx\table@data\@empty\else\table@data\fi
    \end{longtable}
  \end{ThreePartTable}
  % End landscape mode
  \ifx\table@rotatetable\@empty\else
  \end{landscape}
  \fi
  % Reset parameters
  \global\let\table@typesize\normalsize
  \global\let\table@spacing\singlespacing
  \global\let\table@width\@empty
  \global\let\table@rotatetable\@empty
  \global\let\table@label\@empty
  \global\let\table@maincaption\@empty
  \global\let\table@sidecaption\@empty
  \global\let\table@head\@empty
  \global\let\table@data\@empty
  \global\let\table@notes\@empty
}
