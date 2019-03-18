
% A LaTeX2e class for thesis submissions to
% Okinawa Institute of Science and Technology (OIST):
%
% Tadashi Kozuno (tadashi.kozuno@gmail.com)
%
% last revision: March 2019

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oist_thesis}[2019/3/17 OIST thesis submission class]

\newif\if@final\@finaltrue
\DeclareOption{temporary}{\@finalfalse}
\DeclareOption{final}{\@finaltrue}

\ProcessOptions\relax

%-------------------------------------------------------------------------------
%	HANDRING THE VERISON OF THE THESIS
%-------------------------------------------------------------------------------
\RequirePackage{setspace} % For using double spacing

\if@final
	\LoadClass[12pt, twoside]{book} % 12 pt font, two-sided book style
	
	\RequirePackage[a4paper, includehead, headheight=0.6cm, inner=3cm ,outer=2.5cm, top=2.5 cm, bottom=2.5cm]{geometry}  % Changing size of document
	
	\RequirePackage[bf]{caption} % caption: FIG in bold

	\newcommand{\thesisspacing}{\singlespacing}
	
	\newcommand{\numberedchapter}{ % Preparation for numbered chapters
		\cleardoublepage % To make sure the previous headers are passed
		\fancyhead[RE]{{\bfseries \leftmark}}% Headers for left pages
		\fancyhead[LO]{{\bfseries \rightmark}}
	}% Headers for right pages
	
	\newcommand{\unnumberedchapter}[1]{ % Preparation for unnumbered chapters
		\cleardoublepage % To make sure the previous headers are passed
		\phantomsection % To help hyperref link to the right page
		\addcontentsline{toc}{chapter}{#1} % Also adds the chapter name to the Contents
		\fancyhead[RE]{{\bfseries #1}} % Headers for left pages
		\fancyhead[LO]{}
	}%Headers for right pages

	\newcommand{\startpreamble}{
		\pagestyle{fancy} % Changes the headers
		\fancyhf{}% Clears header and footer
		\renewcommand{\chaptermark}[1]{\markboth{##1}{}} % Getting the chapter name right
		\renewcommand{\sectionmark}[1]{\markright{\thesection\; ##1}} % Getting the section name right
		\fancyhead[RO,LE]{\thepage} % page number on the outside of headers
		\setcounter{page}{2} % Include the title page in page counting
		\thesisspacing % Double spacing
	}

	\newcommand{\includepublications}{}
\else
	\LoadClass[12pt, oneside]{book} % 12 pt font, one-sided book style
	
	\RequirePackage[a4paper, includehead, headheight=0.6cm, inner=2.5cm ,outer=2.5cm, top=2.5 cm, bottom=2.5cm]{geometry}
	
	\RequirePackage[bf, font=onehalfspacing]{caption} % caption: FIG in bold, 1.5 line spacing in figure and table captions

	\newcommand{\thesisspacing}{\doublespacing}

	\newcommand{\numberedchapter}{ % Preparation for numbered chapters
		\cleardoublepage % To make sure the previous headers are passed
		\lhead{\bfseries \leftmark}
	}% Header
	
	\newcommand{\unnumberedchapter}[1]{ % Preparation for unnumbered chapters
		\cleardoublepage % To make sure the previous headers are passed
		\phantomsection % To help hyperref link to the right page
		\addcontentsline{toc}{chapter}{#1} % Also adds the chapter name to the Contents
		\lhead{\bfseries #1}
	}% Header

	\newcommand{\startpreamble}{
		\pagestyle{fancy} % Change the header style
		\fancyhf{}% Clear header and footer
		\renewcommand{\chaptermark}[1]{\markboth{##1}{}} % Getting the chapter name right
		\rhead{\thepage} % Page number at the right of the header
		\frontmatter % Use roman page numbering style (i, ii, iii, iv...) for the preamble pages
		\setcounter{page}{2} % Include the title page in page counting
		\thesisspacing % Double spacing
	}

	\newcommand{\includepublications}{
		\input{./MainText/publications}
	}
\fi

%-------------------------------------------------------------------------------
%	FOR \maketitle
%-------------------------------------------------------------------------------
\RequirePackage{graphicx} % For including images
\RequirePackage{eso-pic} % For the background picture on the title page
\newcommand\BackgroundPic{%
	\put(-250,-160){%
		\parbox[b][\paperheight]{\paperwidth}{%
			\vfill
			\centering
			\includegraphics[width=\paperwidth]{./Images/symbol.jpg}%
			\vfill
}}}

% handling keyword options.
\RequirePackage{xkeyval}

\newif\if@cosupervisorexist\@cosupervisorexistfalse
\define@key[OIST]{title}{title}{\def\thesistitle{#1}}
\define@key[OIST]{title}{name}{\def\name{#1}}
\define@key[OIST]{title}{supervisor}{\def\supervisor{#1}}
\define@key[OIST]{title}{cosupervisor}{\def\cosupervisor{#1}\@cosupervisorexisttrue}
\define@key[OIST]{title}{submissiondate}{\def\submissiondate{#1}}

\providecommand{\puttitle}{}
\renewcommand{\puttitle}[1]{
	\@puttitle{}{#1}
}

\providecommand{\@puttitle}{}
\renewcommand{\@puttitle}[2]{%
	\setkeys[OIST]{title}{#2}

	\begin{titlepage}
		\AddToShipoutPicture*{\BackgroundPic}
		\begin{center}
			\vfill
			{\large \scshape Okinawa Institute of Science and Technology\\Graduate University}\\[0.7cm]
			{\large Thesis submitted for the degree }\\[0.7cm]
			{\Large Doctor of Philosophy}\\[0.5cm]
			\rule{\textwidth}{1.5pt}\\[0cm]
			{\huge \bfseries \thesistitle \par \ }\\[-0.5cm]
			\rule{\textwidth}{1.5pt}\\[2.5cm]
			\hfill  by\\[1cm]
			\hfill  {\large \bfseries\name}\\
			\vfill
			{\hfill \large Supervisor: \textbf{\supervisor}} \\
			\if@cosupervisorexist{\hfill \large Co-Supervisor: \textbf{\cosupervisor} \\}\else\fi
			\vspace{1cm}
			\hfill  \submissiondate
		\end{center}
	\end{titlepage}
}
