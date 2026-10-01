\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notas}[2026/10/01 v1.0.0 Clase para apuntes en formato libro]

\LoadClass[11pt,twoside,openright]{book}

% Geometría y tipografía editorial.
\RequirePackage[
  paperwidth=21cm,paperheight=29.7cm,
  inner=3cm,outer=2.5cm,top=2.8cm,bottom=3cm,
  headsep=18pt,footskip=32pt
]{geometry}
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setdefaultlanguage{spanish}
\RequirePackage{microtype}
\frenchspacing
\RequirePackage{amsmath}
\RequirePackage{mathtools}
\RequirePackage{unicode-math}
\setmainfont{Latin Modern Roman}
\setsansfont{Latin Modern Sans}
\setmonofont{Latin Modern Mono}[Scale=0.92]
\setmathfont{Latin Modern Math}
\setlength{\abovedisplayskip}{12pt plus 3pt minus 6pt}
\setlength{\belowdisplayskip}{12pt plus 3pt minus 6pt}
\setlength{\abovedisplayshortskip}{6pt plus 3pt}
\setlength{\belowdisplayshortskip}{6pt plus 3pt}
\allowdisplaybreaks

% Diseño editorial.
\RequirePackage{xcolor}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\titleformat{\chapter}[display]
  {\centering\normalfont}
  {\large\MakeUppercase{\chaptertitlename}\\[6pt]\fontsize{28}{34}\selectfont\thechapter}
  {20pt}{\LARGE\itshape\centering}
\titlespacing*{\chapter}{0pt}{1.5in}{0.8in}
% Jerarquía tipográfica minimalista para los títulos interiores.
\titleformat{\section}[hang]
  {\normalfont\fontsize{17}{21}\selectfont\bfseries\raggedright\color{black}}
  {\fontsize{13}{16}\selectfont\bfseries\thesection}
  {0.85em}{}
\titlespacing*{\section}{0pt}{25pt plus 5pt minus 3pt}{11pt plus 2pt}

\titleformat{name=\section,numberless}[hang]
  {\normalfont\fontsize{17}{21}\selectfont\bfseries\raggedright\color{black}}
  {}{0pt}{}

\titleformat{\subsection}[hang]
  {\normalfont\fontsize{12.5}{15.5}\selectfont\bfseries\raggedright\color{black}}
  {\normalfont\bfseries\color{black}\thesubsection}
  {0.75em}{}
\titlespacing*{\subsection}{0pt}{18pt plus 4pt minus 2pt}{7pt plus 2pt}

\titleformat{name=\subsection,numberless}[hang]
  {\normalfont\fontsize{12.5}{15.5}\selectfont\bfseries\raggedright\color{black}}
  {}{0pt}{}

\titleformat{\subsubsection}[hang]
  {\normalfont\normalsize\bfseries\itshape\raggedright\color{black}}
  {\normalfont\color{black}\thesubsubsection}
  {0.65em}{}
\titlespacing*{\subsubsection}{0pt}{14pt plus 3pt minus 2pt}{6pt plus 1pt}
\setlength{\parindent}{1.4em}
\setlength{\parskip}{0pt}

% Encabezados y páginas en blanco.
\RequirePackage{fancyhdr}
\setlength{\headheight}{13pt}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyhead[LE]{\small\itshape\nouppercase{\leftmark}}
\fancyhead[RO]{\small\itshape\nouppercase{\rightmark}}
\fancyfoot[C]{\small\thepage}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\fancypagestyle{plain}{\fancyhf{}\fancyfoot[C]{\small\thepage}\renewcommand{\headrulewidth}{0pt}}
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside\ifodd\c@page\else
  \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother

% Índices, tablas, figuras y diagramas.
\RequirePackage{tocloft}
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftsecfont}{\normalfont}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftbeforechapskip}{10pt}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{caption}
\captionsetup{font=small,labelfont=it,labelsep=period,skip=8pt}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,calc,positioning,decorations.pathmorphing,decorations.pathreplacing,patterns,shapes.geometric}

% Figuras reutilizables. Conserva los archivos del proyecto en assets/.
\NewDocumentEnvironment{figuranotas}{O{htbp} m m}
  {\begin{figure}[#1]\centering}
  {\caption{#2}\label{#3}\end{figure}}

\NewDocumentCommand{\imagenfigura}{O{0.82\textwidth} m m m}{%
  \begin{figure}[htbp]
    \centering
    \includegraphics[width=#1]{#2}
    \caption{#3}
    \label{#4}
  \end{figure}%
}

\NewDocumentCommand{\semblanza}{O{0.24\textwidth} m m m +m}{%
  \begin{figure}[htbp]
    \centering
    \begin{minipage}{0.92\textwidth}
      \centering
      \includegraphics[width=#1]{#2}\par\medskip
      {\large\bfseries #3}\par
      \if\relax\detokenize{#4}\relax\else{\small\itshape #4}\par\fi
      \medskip
      \begin{minipage}{0.88\textwidth}
        \small #5
      \end{minipage}
    \end{minipage}
  \end{figure}%
}

% Bloques editoriales no flotantes con imagen y texto en columnas.
\NewDocumentCommand{\bloqueimagenizquierda}{O{0.28\linewidth} m m +m}{%
  \par\medskip
  \noindent\begin{minipage}{\linewidth}
    \begin{minipage}[t]{#1}
      \vspace{0pt}\centering
      \includegraphics[width=\linewidth]{#2}
    \end{minipage}\hfill
    \begin{minipage}[t]{\dimexpr\linewidth-#1-1.5em\relax}
      \vspace{0pt}\raggedright
      {\large\bfseries #3\par}\smallskip
      #4
    \end{minipage}
  \end{minipage}
  \par\medskip
}

\NewDocumentCommand{\bloqueimagenderecha}{O{0.28\linewidth} m m +m}{%
  \par\medskip
  \noindent\begin{minipage}{\linewidth}
    \begin{minipage}[t]{\dimexpr\linewidth-#1-1.5em\relax}
      \vspace{0pt}\raggedright
      {\large\bfseries #3\par}\smallskip
      #4
    \end{minipage}\hfill
    \begin{minipage}[t]{#1}
      \vspace{0pt}\centering
      \includegraphics[width=\linewidth]{#2}
    \end{minipage}
  \end{minipage}
  \par\medskip
}

% Entornos matemáticos: numeración por sección.
\RequirePackage{bm}
\RequirePackage{amsthm}
\RequirePackage{aliascnt}
\newtheoremstyle{plainbook}{12pt plus 2pt minus 2pt}{12pt plus 2pt minus 2pt}{\normalfont}{}{\bfseries}{.}{0.6em}{}
\newtheoremstyle{defbook}{12pt plus 2pt minus 2pt}{12pt plus 2pt minus 2pt}{\normalfont}{}{\bfseries}{.}{0.6em}{}
\newtheoremstyle{notebook}{10pt plus 2pt minus 2pt}{10pt plus 2pt minus 2pt}{\normalfont}{}{\itshape}{.}{0.6em}{}
\theoremstyle{plainbook}
\newtheorem{theorem}{Teorema}[section]
\newaliascnt{lemma}{theorem}
\newtheorem{lemma}[lemma]{Lema}
\aliascntresetthe{lemma}
\newaliascnt{proposition}{theorem}
\newtheorem{proposition}[proposition]{Proposición}
\aliascntresetthe{proposition}
\newaliascnt{corollary}{theorem}
\newtheorem{corollary}[corollary]{Corolario}
\aliascntresetthe{corollary}
\newaliascnt{conjecture}{theorem}
\newtheorem{conjecture}[conjecture]{Conjetura}
\aliascntresetthe{conjecture}
\theoremstyle{defbook}
\newaliascnt{axiom}{theorem}
\newtheorem{axiom}[axiom]{Axioma}
\aliascntresetthe{axiom}
\newaliascnt{definition}{theorem}
\newtheorem{definition}[definition]{Definición}
\aliascntresetthe{definition}
\newaliascnt{example}{theorem}
\newtheorem{example}[example]{Ejemplo}
\aliascntresetthe{example}
\newaliascnt{exercise}{theorem}
\newtheorem{exercise}[exercise]{Ejercicio}
\aliascntresetthe{exercise}
\newaliascnt{problem}{theorem}
\newtheorem{problem}[problem]{Problema}
\aliascntresetthe{problem}
\newtheorem{objetivos}{Objetivos del capítulo}[chapter]
\theoremstyle{notebook}
\newaliascnt{remark}{theorem}
\newtheorem{remark}[remark]{Observación}
\aliascntresetthe{remark}
\newaliascnt{notation}{theorem}
\newtheorem{notation}[notation]{Notación}
\aliascntresetthe{notation}
\renewcommand{\qedsymbol}{$\mdlgblksquare$}
\renewcommand{\proofname}{Demostración}

% Hipervínculos, referencias cruzadas y bibliografía.
\RequirePackage[
  colorlinks=true,linkcolor=blue,citecolor=blue,urlcolor=blue,
  pdfusetitle,bookmarksnumbered=true,bookmarksopen=true
]{hyperref}
\RequirePackage{bookmark}
\RequirePackage[capitalise,spanish]{cleveref}
\crefname{theorem}{teorema}{teoremas}
\Crefname{theorem}{Teorema}{Teoremas}
\crefname{lemma}{lema}{lemas}
\Crefname{lemma}{Lema}{Lemas}
\crefname{proposition}{proposición}{proposiciones}
\Crefname{proposition}{Proposición}{Proposiciones}
\crefname{corollary}{corolario}{corolarios}
\Crefname{corollary}{Corolario}{Corolarios}
\crefname{conjecture}{conjetura}{conjeturas}
\Crefname{conjecture}{Conjetura}{Conjeturas}
\crefname{axiom}{axioma}{axiomas}
\Crefname{axiom}{Axioma}{Axiomas}
\crefname{definition}{definición}{definiciones}
\Crefname{definition}{Definición}{Definiciones}
\crefname{example}{ejemplo}{ejemplos}
\Crefname{example}{Ejemplo}{Ejemplos}
\crefname{exercise}{ejercicio}{ejercicios}
\Crefname{exercise}{Ejercicio}{Ejercicios}
\crefname{problem}{problema}{problemas}
\Crefname{problem}{Problema}{Problemas}
\crefname{remark}{observación}{observaciones}
\Crefname{remark}{Observación}{Observaciones}
\crefname{notation}{notación}{notaciones}
\Crefname{notation}{Notación}{Notaciones}
\crefname{equation}{ecuación}{ecuaciones}
\Crefname{equation}{Ecuación}{Ecuaciones}
\crefname{chapter}{capítulo}{capítulos}
\Crefname{chapter}{Capítulo}{Capítulos}
\crefname{section}{sección}{secciones}
\Crefname{section}{Sección}{Secciones}
\RequirePackage[backend=biber,style=numeric,sorting=ynt,hyperref=true]{biblatex}

\endinput
