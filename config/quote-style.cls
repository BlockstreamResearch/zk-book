% --- Book-style quotations ---------------------------------------------------
% Usage:
%   \begin{bookquote}[Alan Turing, 1950]
%     We can only see a short distance ahead, but we can see plenty there
%     that needs to be done.
%   \end{bookquote}
% The optional argument is the attribution; omit it for an anonymous quote.
% The standard quote/quotation environments are redirected to bookquote.
%
% The quotation marks are drawn with TikZ (teardrop shape), so they look the
% same regardless of the text font and never inherit a thin italic glyph.
 
\colorlet{quotemark}{oc-gray-4}   % quotation marks
\colorlet{quoterule}{oc-gray-3}   % thin rule before the attribution
\colorlet{quotetext}{oc-gray-7}   % quoted text
\colorlet{quoteattr}{oc-gray-6}   % attribution line
 
% One teardrop "6"-shaped comma: ball of radius 1 at the origin, tail rising
% to the upper right. Drawn in a unit box; scaled by the caller.
\newcommand{\quoteglyphpath}{%
  (-1,0) .. controls (-1,1.55) and (-0.05,2.45) .. (1.05,2.75)
  -- (1.12,2.5) .. controls (0.35,2.1) and (-0.15,1.55) .. (0.21,0.98)
  arc[start angle=78, end angle=-180, radius=1] -- cycle}
 
% \quotemarks{<scale>}{<rotation>}: a pair of teardrops ( “ or ” )
\newcommand{\quotemarks}[2]{%
  \begin{tikzpicture}[x=#1, y=#1, rotate=#2, baseline=0pt]
    \fill[quotemark] \quoteglyphpath;
    \fill[quotemark, shift={(2.9,0)}] \quoteglyphpath;
  \end{tikzpicture}}
 
\newcommand{\quoteopen}{\quotemarks{2pt}{0}}
\newcommand{\quoteclose}{\quotemarks{2pt}{180}}
 
\newcommand{\quoteopennode}{%
  \node[anchor=north west, inner sep=0pt]
    at ([xshift=0.2em, yshift=-1.5pt]frame.north west) {\quoteopen};}
\newcommand{\quoteclosenode}{%
  \node[anchor=south east, inner sep=0pt]
    at ([xshift=-0.2em, yshift=\quoteshift]frame.south east) {\quoteclose};}
 
\newcommand{\quotetextfont}{\itshape}   % e.g. \sffamily for Biolinum instead
 
\newtcolorbox{bookquotebox}[1][]{%
  enhanced, breakable, blanker,
  left=2em, right=2em, top=3pt, bottom=3pt,
  before skip=14pt plus 2pt, after skip=14pt plus 2pt,
  fontupper=\quotetextfont\color{quotetext},
  % opening marks hang in the left padding, level with the first line;
  % closing marks sit in the right padding, level with the last line
  overlay unbroken={\quoteopennode\quoteclosenode},
  overlay first={\quoteopennode},
  overlay last={\quoteclosenode},
  after upper={%
    \if\relax\detokenize{#1}\relax\else
      \par\vspace{5pt}%
      {\raggedleft\normalfont\small\color{quoteattr}%
       \textcolor{quoterule}{\rule[0.5ex]{1.6em}{0.4pt}}\enspace\textsc{#1}\par}%
    \fi},
}
 
% the closing marks go above the attribution line when there is one
\newenvironment{bookquote}[1][]{%
  \if\relax\detokenize{#1}\relax\def\quoteshift{2pt}\else\def\quoteshift{16pt}\fi
  \begin{bookquotebox}[#1]}{\end{bookquotebox}}
 
\renewenvironment{quote}[1][]{\begin{bookquote}[#1]}{\end{bookquote}}
\renewenvironment{quotation}[1][]{\begin{bookquote}[#1]}{\end{bookquote}}
 