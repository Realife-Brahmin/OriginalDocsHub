%% Identification
%% The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{coverletter}[2018/01/03 WSU Cover Letter by Adam Erickson]

%% Preliminary definitions needed by options

%% Load parent class with options
\LoadClass{article}

% For defining official university colors
\RequirePackage[dvinames]{xcolor}

%% Declare options
\DeclareOption{draft}{\OptionNotUsed}
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{titlepage}{\OptionNotUsed}

\newcommand{\logofile}{}

\DeclareOption{color}{%
    \definecolor{crimson}{RGB}{152,30,50}
    \definecolor{gray}{RGB}{94,106,113} % {HTML}{5e6a71}
    \renewcommand{\logofile}{WSU-Logo-Primary-RGB.eps}
}

\DeclareOption{bw}{%
    \definecolor{crimson}{RGB}{0,0,0}
    \definecolor{gray}{RGB}{94,106,113} % {HTML}{5e6a71}
    \renewcommand{\logofile}{WSU-Logo-Primary-Blk.eps}
}

\DeclareOption*{%
    \ClassWarning{coverletter}{Unknown option '\CurrentOption'}
}

\ExecuteOptions{color}

\ProcessOptions{\relax}

%% Load packages

% UTF-8 input encoding
\RequirePackage[utf8]{inputenc}

% Measurements from university guide
\RequirePackage[top=2in, left=1.5in, bottom=0.5in, right=0.625in]{geometry}
\RequirePackage{graphicx}
\RequirePackage[colorlinks=false, pdfborder={0 0 0},]{hyperref}
\RequirePackage[absolute]{textpos}
\RequirePackage{ifthen}
\RequirePackage{soul}

% For placement of the horizontal line
\RequirePackage{tikz}

% A nice serif font (palatino), but not the prescribed nonfree ITC stone
\RequirePackage[sc,osf]{mathpazo}

% Header and footer formatting
\RequirePackage{fancyhdr}

% Enable LaTeX3 interface for key-value pairs
\RequirePackage{xparse}

% For substring operations
\usepackage{xstring}

%% Command definitions
\newcommand{\lastword}[1]{%
    \StrCount{#1}{\space}[\dotnum]%
    \StrBehind[\dotnum]{#1}{\space}
}

% Key-value store
\ExplSyntaxOn 

\prop_new:N \list_prop

\keys_define:nn {coverletter} {%
    fromname    .code:n={ \prop_put:Nnn \list_prop {fromname}    {#1} },
    fromdegree  .code:n={ \prop_put:Nnn \list_prop {fromdegree}  {#1} },
    fromrole    .code:n={ \prop_put:Nnn \list_prop {fromrole}    {#1} },
    fromdept    .code:n={ \prop_put:Nnn \list_prop {fromdept}    {#1} },
    fromuni     .code:n={ \prop_put:Nnn \list_prop {fromuni}     {#1} },
    fromcity    .code:n={ \prop_put:Nnn \list_prop {fromcity}    {#1} },
    fromstreet  .code:n={ \prop_put:Nnn \list_prop {fromstreet}  {#1} },
    fromtel     .code:n={ \prop_put:Nnn \list_prop {fromtel}     {#1} },
    fromcountry .code:n={ \prop_put:Nnn \list_prop {fromcountry} {#1} },
    fromfax     .code:n={ \prop_put:Nnn \list_prop {fromfax}     {#1} },
    fromemail   .code:n={ \prop_put:Nnn \list_prop {fromemail}   {#1} },
    fromweb     .code:n={ \prop_put:Nnn \list_prop {fromweb}     {#1} },
    %
    toname      .code:n={ \prop_put:Nnn \list_prop {toname}      {#1} },
    totitle     .code:n={ \prop_put:Nnn \list_prop {totitle}     {#1} },
    torole      .code:n={ \prop_put:Nnn \list_prop {torole}      {#1} },
    todept      .code:n={ \prop_put:Nnn \list_prop {todept}      {#1} },
    touni       .code:n={ \prop_put:Nnn \list_prop {touni}       {#1} },
    tocity      .code:n={ \prop_put:Nnn \list_prop {tocity}      {#1} },
    tostreet    .code:n={ \prop_put:Nnn \list_prop {tostreet}    {#1} },
    tocountry   .code:n={ \prop_put:Nnn \list_prop {tocountry}   {#1} },
    %
    date        .code:n={ \prop_put:Nnn \list_prop {date}        {#1} },
    signature   .code:n={ \prop_put:Nnn \list_prop {signature}   {#1} }
}

% Setter and getter; top function was formerly SetLetterData
\NewDocumentCommand{\update}{+m}{%
    \keys_set:nn {coverletter} {#1}%
}

\cs_new:Npn \getvalue#1{%
    \prop_item:Nn \list_prop {#1}
}

\ExplSyntaxOff

% Default values
%%%%%%%%%%%%%%%%%%%%%%%% FOR MODIFICATION %%%%%%%%%%%%%%%%%%%%%%%%
\update{%
    fromname=Aryan Ritwajeet Jha, 
    fromdegree={Pursuing Ph.D. in ECE},
    fromrole={Graduate Research Assistant}, 
    fromdept={School of Electrical Engineering and Computer Sciences},
    fromuni={Washington State University},
    fromcity={Pullman, WA 99163},
    fromstreet={355 Northeast Spokane St.},
    fromcountry={USA},
    fromtel={(509) 338-8770},
    fromfax={(509) 338-8770},
    fromemail={\url{aryan.jha@wsu.edu}},
    fromweb={\url{aryan.r.jha@gmail.com}},
    %
    toname={},
    totitle={},
    torole={},
    todept={},
    touni={},
    tostreet={},
    tocity={},
    tocountry={},
    %
    % date={\today},
    date = {16 July 2023},
    signature={}
}
%%%%%%%%%%%%%%%%%%%%%%%% FOR MODIFICATION %%%%%%%%%%%%%%%%%%%%%%%%

% Opening and closing phrases
% \newcommand{\opening}[1][Dear]{#1 \getvalue{totitle} \lastword{\getvalue{toname}},}
\newcommand{\opening}[1][]{Respected International Student Advisor,}
\newcommand{\closing}[1][Sincerely]{#1,}

% Linked files
%\newcommand{\signature}{} % your signature
%\newcommand{\logofile}{WSU-Logo-Primary-RGB.eps} % university logo
\newcommand{\enclosure}{} % any enclosures

%% Body of the class, most of the declarations appear here

% Horizontal line, font, and header/footer style
\usetikzlibrary{calc}
\linespread{1.05}

% Remove paragraph indentation
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.8\baselineskip}
\raggedright

% Set the URL style
\urlstyle{sf}

% Define custom header and footer
\fancypagestyle{main}{%
    \fancyhf{} % clear the existing header and footer
    % define the header
    \fancyhead[L]{%
        \begin{textblock*}{2in}[0.3066,0.39](1.5in,1.33in)
            \includegraphics[width=2in]{\logofile}
        \end{textblock*}
        \begin{textblock*}{6.375in}(1.5in,1.4in) % 6.375 = 8.5-1.5-0.625
            \sffamily
            \hfill \color{gray} \getvalue{fromdept}
            \\  \hfill \getvalue{fromname}, \getvalue{fromdegree}
        \end{textblock*}
        \begin{tikzpicture}[remember picture,overlay]
            \draw[color=crimson,line width=0.7pt] (current page.north west)+(1.5in,-1.33in) -- ($(-0.625in,-1.33in)+(current page.north east)$);
        \end{tikzpicture}
    }
    % define the footer
    \fancyfoot[L]{%
      {\footnotesize \color{gray} \sffamily
           \getvalue{fromstreet}, \getvalue{fromcity} \\[-0.1\baselineskip]
           \getvalue{fromtel}\ \textbullet\ Fax: \getvalue{fromfax}\ \textbullet\ \getvalue{fromemail}\ \textbullet\ \getvalue{fromweb}} \color{black}
    }
    % define the line thickness
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

\AtBeginDocument{% Text lines should be less than 6in long
    \pagestyle{main} % fancy page style
    \newgeometry{top=2in,left=1.5in,bottom=1.2in,right=1in}
    \getvalue{date}
    
    \medskip
    \getvalue{totitle} \getvalue{toname} \ifthenelse{\equal{\getvalue{toname}}{}}{}{\\}
    \getvalue{torole} \ifthenelse{\equal{\getvalue{torole}}{}}{}{\\}
    \getvalue{todept} \ifthenelse{\equal{\getvalue{todept}}{}}{}{\\}
    \getvalue{touni} \ifthenelse{\equal{\getvalue{touni}}{}}{}{\\}
    \getvalue{tostreet} \ifthenelse{\equal{\getvalue{tostreet}}{}}{}{\\}
    \getvalue{tocity} \ifthenelse{\equal{\getvalue{tocity}}{}}{}{\\}
    \getvalue{tocountry} \ifthenelse{\equal{\getvalue{tocountry}}{}}{}{\\}
    
    \bigskip
    \opening\par
}

\AtEndDocument{%
    \par\vspace{2ex}
    \closing
    
    \ifthenelse{\equal{\getvalue{signature}}{}}{\bigskip\bigskip}{\includegraphics[width=1.2in]{\getvalue{signature}}\\[-0.2\baselineskip]}
    \ifthenelse{\equal{\getvalue{fromdegree}}{Ph.D.}}{Dr.~\getvalue{fromname}}{\getvalue{fromname}} \\
    \getvalue{fromrole}\ifthenelse{\equal{\getvalue{fromrole}}{}}{}{\\}
    \enclosure
}

\endinput
