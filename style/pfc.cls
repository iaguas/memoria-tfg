\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{style/pfc}[2014/04/06 Plantilla de PFC]
\RequirePackage[l2tabu, orthodox]{nag}

\PassOptionsToClass{a4paper,12pt,titlepage=firstiscover,openright}{scrreprt}
\PassOptionsToClass{abstract,parskip=full,headings=twolinechapter,numbers=autoendperiod}{scrreprt}
\PassOptionsToClass{twoside,BCOR=10mm}{scrreprt}

\DeclareOption*{%
   \PassOptionsToClass{\CurrentOption}{scrreprt}%
}


\ProcessOptions\relax

\LoadClass{scrreprt}

\RequirePackage{style/general}
%\RequirePackage{style/portada}

\RequirePackage{style/pfclistings}

%Estas clases me serán útiles algún día:
%\RequirePackage{tabu} % Un paquete de tablas para todo, pero que no se va a actualizar, buscar alternativas: https://tex.stackexchange.com/questions/12672/which-tabular-packages-do-which-tasks-and-which-packages-conflict
\def\Hnewline{{?nl}}
\RequirePackage{tikz}
%\RequirePackage{tikz-uml}
%\RequirePackage{pgf-umlcd}
\usetikzlibrary{positioning,decorations.pathreplacing,shapes}
\usetikzlibrary{positioning,fit,babel,shapes.multipart,calc}
\usetikzlibrary{arrows.meta,bending}
\usetikzlibrary{external}
\tikzexternalize[prefix=figures/]
\tikzset{external/system call={xelatex -shell-escape
    -halt-on-error -interaction=batchmode -jobname "\image" "\texsource"}}

\floatplacement{figure}{htbp}
\floatplacement{listing}{htbp}
\floatplacement{table}{htbp}

\RequirePackage{scrhack}
