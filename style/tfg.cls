\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{style/tfg}[2017/04/25 Plantilla de TFG, basada en la del PFC de Gorka]
\RequirePackage[l2tabu, orthodox]{nag}

\PassOptionsToClass{a4paper,12pt,titlepage=firstiscover,openright}{scrreprt}
\PassOptionsToClass{abstract,parskip=full,headings=twolinechapter,numbers=autoendperiod}{scrreprt}
\PassOptionsToClass{twoside,BCOR=10mm}{scrreprt}

\DeclareOption*{%
   \PassOptionsToClass{\CurrentOption}{scrreprt}%
}

\ProcessOptions\relax

\LoadClass{scrreprt}

% Paquetes personales
\RequirePackage{style/general}
\RequirePackage{style/tfgmaths}
\RequirePackage{style/tfglistings}

% % Paquete para la escritura de algoritmos.
% % http://www.rosapolis.net/2008/04/21/escribir-algoritmos-en-latex/
% \RequierePackage{algorithm}
% \RequierePackage{algorithmic}
% \RequierePackage{style/spanishAlgorithmic}

%Estas clases me serán útiles algún día:
%\RequirePackage{tabu} % Un paquete de tablas para todo, pero que no se va a actualizar, buscar alternativas: https://tex.stackexchange.com/questions/12672/which-tabular-packages-do-which-tasks-and-which-packages-conflict
\def\Hnewline{{?nl}}
%\tcbset{shield externalize}
\RequirePackage{tikz}
%\RequirePackage{tikz-uml}
%\RequirePackage{pgf-umlcd}
\usetikzlibrary{positioning,decorations.pathreplacing,shapes}
\usetikzlibrary{positioning,fit,babel,shapes.multipart,calc}
\usetikzlibrary{arrows.meta,bending}
\usetikzlibrary{external}
\tikzset{external/up to date check=md5}
\tikzexternalize[prefix=figures/]
\tikzset{external/system call={xelatex -shell-escape
    -halt-on-error -interaction=batchmode -jobname "\image" "\texsource"}}

% After tikz
%\RequirePackage{todonotes}


\floatplacement{figure}{htbp}
\floatplacement{listing}{htbp}
\floatplacement{table}{htbp}

\RequirePackage{scrhack}
