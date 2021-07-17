% FIXME this is an utter mess

\ProvidesClass{structure}[12/07/2021 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}


%%%%%%%%%%
% Colors %
%%%%%%%%%%



\RequirePackage[dvipsnames]{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{brown}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[math-style=TeX]{unicode-math}

\newfontfamily\bodyfont[]{HelveticaNeueLTCom-Roman}
\newfontfamily\thinfont[]{HelveticaNeueLTCom-UltLt}
\newfontfamily\headingfont[]{HelveticaNeueLTCom-BdCn}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor]{HelveticaNeueLTCom-Lt}

%\setmathfont{XITS Math}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}
\usepackage{titlesec}

\newcommand{\rolefont}{%
  \fontsize{14pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=4cm] (box) at (current page.north){};
    \node [anchor=center] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{2.5cm}
  \vspace{-2\parskip}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        blue\or%
        red\or%
        orange\or%
        green\or%
        purple\or%
        brown\else%
        headercolor\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{\parskip}
}

\renewcommand{\subsection}[1]{
  \par\vspace{.5\parskip}%
  {\Large\headingfont\color{headercolor} #1}
  \par\vspace{.25\parskip}%
}

\renewcommand{\subsubsection}[2]{
  \par\vspace{.5\parskip}%
  {\Large\headingfont\color{headercolor} #2}
  \par\vspace{.25\parskip}%
}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  #1&\parbox[t]{11.8cm}{%
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{\parsep}%
  }\\}


%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage{wrapfig}
% %\RequirePackage{afterpage}
% \RequirePackage[absolute,overlay]{textpos}
% \setlength{\TPHorizModule}{1cm}
% \setlength{\TPVertModule}{1cm}
% \newenvironment{aside}{%
%   \let\oldsection\section
%   \renewcommand{\section}[1]{
%     \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
%   }
%   \begin{textblock}{6.0}(0.5, 4.33)
%   \begin{flushleft}
%   \obeycr
% }{%
%   \restorecr
%   \end{flushleft}
%   \end{textblock}
%   \let\section\oldsection
% }

\RequirePackage{tabularx}

%%%%%%%%%%%%%%%
%Bibliography %
%%%%%%%%%%%%%%%

\RequirePackage[style=verbose, maxnames=99, sorting=ydnt, backend=biber]{biblatex}

\DeclareFieldFormat[article]{title}{#1\par}
\DeclareFieldFormat[book]{title}{#1\par}
\DeclareFieldFormat[inproceedings]{title}{#1\par}
\DeclareFieldFormat[misc]{title}{#1\par}
\DeclareFieldFormat[report]{title}{#1\par}

\DeclareBibliographyDriver{article}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \usebibmacro{journal+issuetitle}%
    \setunit{\space}%
    \printfield{pages}%
    \newunit%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{book}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \printfield{note}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}


\DeclareBibliographyDriver{inproceedings}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}%
    \printfield{booktitle}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{misc}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{booktitle}%
    \setunit*{\addcomma\space}%
    \printfield{note}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

% \DeclareNameFormat{author}{%
%   \small\addfontfeature{Color=lightgray}%
%   \ifblank{#2}{}{#2\space}#1%
%   \ifthenelse{\value{listcount}<\value{liststop}}
%     {\addcomma\space}
%     {}%
% }

\defbibheading{bibheading}[\bibname]{%
   \subsubsection*{#1}
   \markboth{#1}{#1}
}

\newcommand{\printbibsection}[2]{
  \begin{refsection}
    \nocite{*}
    \printbibliography[type={#1}, title={#2}, heading=bibheading]
  \end{refsection}
}



%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=1.5cm,top=2cm,right=1.5cm,bottom=2.5cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=false,
    linkcolor=red,
    citecolor=red,
    filecolor=red,
    urlcolor = red}

% A fix for \href{}{} colors not working with fontspec
\makeatletter
\def\HyColor@@@@UseColor#1\@nil{\addfontfeatures{Color=#1}}
\makeatother

\def\AxisN{6}   %define how much axes you want
\def\MaxValue{10}   %define the number of node on each axis

\newcommand{\SetAxisLabels}[\AxisN]{
  \newcommand{\axisone}{#1}
  \newcommand{\axistwo}{#2}
  \newcommand{\axisthree}{#3}
  \newcommand{\axisfour}{#4}
  \newcommand{\axisfive}{#5}
  \newcommand{\axissix}{#6}
}

\newcommand{\DrawAxisLabels}{
  \draw(360/\AxisN:\MaxValue+0.5)node[above]{\axisone};     %adjust the labels (also add or delete exces axes)
  \draw(2*360/\AxisN:\MaxValue+0.5)node[above]{\axistwo};   %eg. if you have 4 axes, delete the last 2
  \draw(3*360/\AxisN:\MaxValue+0.5)node[left]{\axisthree};        %or if you have 7 axes add one
  \draw(4*360/\AxisN:\MaxValue+0.5)node[below]{\axisfour};
  \draw(5*360/\AxisN:\MaxValue+0.5)node[below]{\axisfive};
  \draw(6*360/\AxisN:\MaxValue+0.5)node[right]{\axissix};
}
\newcommand{\DrawBackground}{
  \foreach \x in{1,2,...,\AxisN}{
            \draw[draw=none,fill=gray,opacity=0.15](0,0)--(360/\AxisN*\x:\MaxValue)--(360/\AxisN*\x+360/\AxisN:\MaxValue);
            }
}
\newcommand{\DrawAxis}{
  \foreach \x in{0,1,...,\AxisN}{%
            \draw[thin,black,opacity=0.2] (0,0)--(360/\AxisN*\x:\MaxValue);
            \foreach \y in{0,1,...,\MaxValue}{
                \draw[thin,black,opacity=0.2](360/\AxisN*\x:\y)--(360/\AxisN*\x+360/\AxisN:\y);
                %\draw[fill] (360/\AxisN*\x:\y) circle(0.75pt);
                }

        }
}

\newcommand{\KiviatDiagram}[\AxisN]{
    \begin{tikzpicture}[scale=0.15]
        \DrawAxis
        \DrawAxisLabels
        \DrawBackground
        % % Draw polygon
        \draw[fill=RoyalPurple,opacity=0.7,thick,draw=gray](360/\AxisN:#1)--(360/\AxisN*2:#2)--(360/\AxisN*3:#3)--(360/\AxisN*4:#4)--(360/\AxisN*5:#5)--(360/\AxisN*6:#6)--cycle;
        \draw[thick,draw=red](360/\AxisN:#1)--(360/\AxisN*2:#2)--(360/\AxisN*3:#3)--(360/\AxisN*4:#4)--(360/\AxisN*5:#5)--(360/\AxisN*6:#6)--cycle;
    \end{tikzpicture}
}

\RequirePackage{tkz-kiviat}