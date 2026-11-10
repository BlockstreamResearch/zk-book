\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zkdl-presentation-template}[2026/10/28 ZKDL Template]

% =====================================================================
%  ZKDL lecture slides.
%
%  Every lecture has ONE source file, e.g. 01-preliminaries.tex, written
%  with overlays (\pause, \only<...>, \item<...>, ...).
%    * Compiling 01-preliminaries.tex gives the STATIC version
%      (beamer handout mode: one page per frame).
%    * Compiling 01-preliminaries-animated.tex, which only contains
%        \PassOptionsToClass{animated}{zkdl-presentation-template}
%        \input{01-preliminaries}
%      gives the ANIMATED version (one page per overlay step).
%
%  In the static version every overlay is shown at once. When a frame
%  REPLACES content (\only<1>{A}\only<2>{B}), hide the intermediate
%  steps in the static version with `| handout:0`, e.g.
%      \only<1| handout:0>{A}\only<2>{B}
% =====================================================================

% --- Options ---
\newif\ifzkdl@animated
\zkdl@animatedfalse
\DeclareOption{animated}{\zkdl@animatedtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

\ifzkdl@animated\else
  \PassOptionsToClass{handout}{beamer}
\fi

% --- Beamer settings ---
\LoadClass[compress, final, xcolor={dvipsnames}, mathserif]{beamer}

\usepackage[utf8]{inputenc}
\usepackage[english]{babel}

% --- Listing settings ---
\RequirePackage{listings}

% --- Algorithm packages ---
\RequirePackage[
    titlenumbered,
    linesnumbered,
    ruled
]{algorithm2e}
\SetKwInOut{Input}{Input}
\SetKwInOut{Output}{Output}
\SetKwInOut{Return}{Return}

\SetKwComment{Comment}{/* }{ */}
\newcommand\mycommentstyle[1]{\footnotesize\ttfamily\textcolor{red!70!black}{#1}}
\SetCommentSty{mycommentstyle}

% --- Setting the theme ---
\usetheme{altarguelles}
\setbeamertemplate{sections/subsections in toc}[square]

% --- Set the font ---
\RequirePackage{kerkis}
\RequirePackage{kmath}
% kmath takes Greek letters from Kerkis; use the standard (txfonts, Times-style)
% math letters instead, and the standard AMS blackboard bold for \mathbb.
% Both replace existing symbol fonts, so no math alphabet slot is used.
\DeclareSymbolFont{letters}{OML}{txmi}{m}{it}
\SetSymbolFont{letters}{bold}{OML}{txmi}{bx}{it}
\DeclareSymbolFont{AMSb}{U}{msb}{m}{n}
\SetSymbolFont{AMSb}{bold}{U}{msb}{m}{n}

% --- Bold captions ---
\usepackage[labelfont=bf]{caption}

% --- Including some standard packages ---
\RequirePackage{graphicx}
\RequirePackage{soul}
\RequirePackage{hyperref}
\RequirePackage{colortbl}
\RequirePackage{dsfont}
\RequirePackage{stmaryrd}
\RequirePackage{extarrows}
\RequirePackage{cancel}
\RequirePackage{centernot}

% Images are referenced relative to this folder; the extra entry lets
% lectures in subfolders (e.g. deprecated/) still find images/.
\graphicspath{{./}{../}}

% --- Tikz ---
\RequirePackage{tikz}
\usepackage{tikz,tikz-3dplot,tikz-cd,tkz-tab,tkz-euclide,pgf,pgfplots}
\pgfplotsset{compat=1.18}
\usetikzlibrary{matrix,positioning,fit,backgrounds,intersections,arrows.meta,calc,decorations.pathreplacing,shapes}

% --- Cross signs ---
\RequirePackage{pifont} % http://ctan.org/pkg/pifont
\newcommand{\cmark}{\textcolor{oc-green-8}{\ding{51}}}%
\newcommand{\xmark}{\textcolor{oc-red-8}{\ding{55}}}%
\newcommand{\xopt}{\ding{48}}%

% =====================================================================
%  Notation shared with the book (config/zkdl-template.cls)
% =====================================================================
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}

% Uniform sampling: x \leftarrowS X  (x <-$ X)
\providecommand\leftarrowS{\leftarrow\joinrel\smalldollar}
\providecommand\rightarrowS{\smalldollar\joinrel\rightarrow}
\makeatletter
\providecommand{\smalldollar}{\mathrel{\mathpalette\small@dollar\relax}}
\providecommand{\small@dollar}[2]{%
  \vcenter{\hbox{%
    $#1\textnormal{\fontsize{0.7\dimexpr\f@size pt}{0}\selectfont\$}$%
  }}%
}
\makeatother

\providecommand{\F}{\mathbb{F}}
\providecommand{\ip}[1]{\ensuremath{\left\langle#1\right\rangle}}
\providecommand{\floor}[1]{\ensuremath{\left\lfloor#1\right\rfloor}}
\providecommand{\ceil}[1]{\ensuremath{\left\lceil#1\right\rceil}}
\providecommand{\lcm}{\text{lcm}}
\providecommand{\negl}{\mathsf{negl}}
% The book typesets these with \mathscr (mathrsfs). Slides fall back to \mathcal
% to stay within the math alphabet limit; a lecture may load mathrsfs locally.
\providecommand{\dgaussian}{\mathcal{D}}
\providecommand{\code}{\mathcal{C}}
% Statement and witness: \mathbbm{x}, \mathbbm{w} (as in the book). The bbm font is used
% inside \text so that no extra math alphabet is allocated.
\providecommand{\mathbbm}[1]{\text{\usefont{U}{bbm}{m}{n}#1}}

% Gray `// comment` and small sans keywords, as in the book
\providecommand{\commentgray}[1]{%
  \hspace{3px}%
  {\textcolor{gray!70!black}{\small\textit{// #1}}}%
}
\providecommand{\keyword}[1]{\textnormal{\small\sffamily\bfseries\textcolor{gray!70!black}{#1}}}

% Algorithm steps with gray numbers, as `algoen` in the book
\newlist{algoen}{enumerate}{1}
\setlist[algoen]{
    label=\textcolor{gray!90!black}{\arabic*:},
    align=right,
    widest=0,
    labelsep=0.75em,
    leftmargin=2.0em,
    labelindent=0.5em,
    itemsep=0.2em
}

% =====================================================================
%  Block colours: the same opencolor roles as the book
% =====================================================================
%   definition, theorem  -> indigo     lemma        -> blue
%   proposition          -> orange     corollary    -> violet
%   example(s), exampleblock -> gray   remark, remarkblock -> green
%   questionblock        -> pink       alertblock   -> yellow
%   block (generic)      -> indigo
\makeatletter
\newcommand{\zkdl@blockcolors}[2]{% #1 = title shade, #2 = body shade
  \setbeamercolor{block title}{bg=#1,fg=white}%
  \setbeamercolor{block body}{bg=#2,fg=oc-gray-9}%
  \setbeamercolor{block title example}{bg=#1,fg=white}%
  \setbeamercolor{block body example}{bg=#2,fg=oc-gray-9}%
}
\newcommand{\zkdl@hue}[1]{\zkdl@blockcolors{oc-#1-8}{oc-#1-1}}

% Base colours (generic block = indigo, exampleblock = gray, alertblock = yellow)
\setbeamercolor{block title}{bg=oc-indigo-8,fg=white}
\setbeamercolor{block body}{bg=oc-indigo-1,fg=oc-gray-9}
\setbeamercolor{block title example}{bg=oc-gray-7,fg=white}
\setbeamercolor{block body example}{bg=oc-gray-1,fg=oc-gray-9}
\setbeamercolor{block title alerted}{bg=oc-yellow-8,fg=white}
\setbeamercolor{block body alerted}{bg=oc-yellow-1,fg=oc-gray-9}

% Theorem-like environments: upright body text, as in the book
\def\th@plain{\normalfont}
\theoremstyle{definition}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{remark}[theorem]{\faCommentDots~Remark}
\AtBeginEnvironment{definition}{\zkdl@hue{indigo}}
\AtBeginEnvironment{definitions}{\zkdl@hue{indigo}}
\AtBeginEnvironment{theorem}{\zkdl@hue{indigo}}
\AtBeginEnvironment{lemma}{\zkdl@hue{blue}}
\AtBeginEnvironment{proposition}{\zkdl@hue{orange}}
\AtBeginEnvironment{corollary}{\zkdl@hue{violet}}
\AtBeginEnvironment{fact}{\zkdl@hue{blue}}
\AtBeginEnvironment{example}{\zkdl@blockcolors{oc-gray-7}{oc-gray-1}}
\AtBeginEnvironment{examples}{\zkdl@blockcolors{oc-gray-7}{oc-gray-1}}
\AtBeginEnvironment{remark}{\zkdl@hue{green}}
\makeatother

% Titled blocks with the book's icons
%   \begin{remarkblock}{Note} ... \end{remarkblock}
%   \begin{questionblock}{Question \#1} ... \end{questionblock}
\makeatletter
\newenvironment{remarkblock}[1]%
  {\zkdl@hue{green}\begin{block}{\faCommentDots~#1}}%
  {\end{block}}
\newenvironment{questionblock}[1]%
  {\zkdl@hue{pink}\begin{block}{\faPencil*~#1}}%
  {\end{block}}
\makeatother

% --- Intermediate Section Slides ---
\expandafter\def\expandafter\insertshorttitle\expandafter{%
  \insertshorttitle\hfill%
  \insertframenumber\,/\,\inserttotalframenumber}

\AtBeginSection[]{
  \begin{frame}[standout]
    \begin{tcolorbox}[
      boxrule=0pt,
      boxsep=0pt,
      blanker,
      borderline north={2.0pt}{-10pt}{white},
      borderline south={2.0pt}{-10pt}{white},
      left=8pt,
      right=8pt,
      before skip=10pt,
      after skip=10pt,
      colframe=black!95!gray,
      colback=white,
      center,
      arc=1em]
      \centering\LARGE
      \textcolor{white}{
        \textbf{\insertsectionhead}
      }
    \end{tcolorbox}
  \end{frame}
}

% =====================================================================
%  Title and closing frames (same in every lecture)
% =====================================================================
\author{Blockstream Research}
\date{\today}
\homepage{research.blockstream.com}
\github{BlockstreamResearch/zk-book}

\newcommand{\maketitleframe}{%
  \frame{%
    \tikz [remember picture,overlay]
      \node at
          ([yshift=1.5cm,xshift=-2.5cm]current page.south east)
          {\includegraphics[width=100pt]{images/logo.png}};
    \titlepage
  }%
}

\newcommand{\makeclosingframe}[1][Thank you for your attention]{%
  \begin{frame}[plain, standout]
    \centering
    \LARGE
    \textbf{#1} \\

    \vspace{0.2cm} \Huge \ding{170} \large \\

    \vspace{1cm}

    \href{https://research.blockstream.com}{\raisebox{-.1em}{\hspace{.025em}\faIcon{globe}}\hspace{.325em}research.blockstream.com} \\

    \href{https://github.com/BlockstreamResearch/zk-book}{\raisebox{-.1em}{\hspace{.025em}\faIcon{github}}\hspace{.325em}github.com/BlockstreamResearch/zk-book}

    \vspace{10px}

    \begin{center}
        \includegraphics[width=0.45\textwidth]{images/logo.png}
    \end{center}
  \end{frame}
}

% --- Code Block Settings ---
\RequirePackage{listings,lstautogobble}
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstdefinestyle{mystyle}{
    language=Python,
    commentstyle=\color{codegreen},
    keywordstyle=\bfseries\color{oc-pink-7},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{oc-teal-7},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2
}

\lstset{style=mystyle}
