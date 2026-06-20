local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

ls.add_snippets('tex', {

  -- ========== Math ==========
  -- mk -> $$...$$ (auto)
  s({ trig = 'mk', snippetType = 'autosnippet', wordTrig = true }, { t '$', i(1), t '$' }),

  -- dm -> \[ ... \] (auto)
  s(
    { trig = 'dm', snippetType = 'autosnippet', wordTrig = true },
    fmta(
      [[
\[
  <>
\]
  ]],
      { i(1) }
    )
  ),

  -- \frac{...}{...}  (brug fmta for at slippe for klamme-escaping)
  s({ trig = 'frac', wordTrig = true }, fmta([[\frac{<>}{<>}]], { i(1, 'numerator'), i(2, 'denominator') })),

  -- ========== Figure ==========
  s(
    { trig = 'fig', wordTrig = true },
    fmta(
      [[
\begin{figure}[h]
  \centering
  \includegraphics[width=<>]{<>}
  \caption{<>}
  \label{fig:<>}
\end{figure}
  ]],
      { i(1, '\\linewidth'), i(2, 'filename'), i(3, 'caption'), i(4, 'label') }
    )
  ),

  -- ========== Template ==========
  s(
    { trig = 'template', wordTrig = true },
    fmta(
      [[
\documentclass{article}

\usepackage{listings}
\usepackage{xcolor}
\usepackage{graphicx}           %% i preamble
\newcommand{\rneg}{\mathord{\reflectbox{$\neg$}}}

\usepackage{amsmath,amssymb}
\usepackage{xcolor}
\usepackage{booktabs}

\newcommand{\T}{\textcolor{green!50!black}{\textbf{T}}}
\newcommand{\F}{\textcolor{red!60!black}{\textbf{F}}}
\renewcommand{\arraystretch}{1.2} %% lidt mere luft i rækkerne

\lstset{
  basicstyle=\ttfamily\footnotesize, %% skrifttype
  backgroundcolor=\color{gray!10},   %% baggrund
  frame=single,                      %% ramme om koden
  breaklines=true,                   %% linjeskift
  keywordstyle=\color{blue},         %% farve på keywords
  commentstyle=\color{green!50!black},
  stringstyle=\color{red}
}

\usepackage[most]{tcolorbox}
\tcbset{
  mybox/.style={
    enhanced, breakable, colback=white, colframe=black,
    boxrule=0.6pt, arc=2mm, left=6pt, right=6pt, top=6pt, bottom=6pt
  }
}

\tcbuselibrary{theorems}
\newtcbtheorem[number within=section]{theorem}{Theorem}%
{mybox, fonttitle=\bfseries, coltitle=black}{thm}

\begin{document}

<>

\end{document}
  ]],
      { i(0) }
    )
  ),

  -- ========== Code blocks ==========
  s(
    { trig = 'codep', wordTrig = true },
    fmta(
      [[
\begin{lstlisting}[language=Python]
	<>
\end{lstlisting}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = 'codec', wordTrig = true },
    fmta(
      [[
\begin{lstlisting}[language=C]
	<>
\end{lstlisting}
  ]],
      { i(0) }
    )
  ),

  s(
    { trig = 'codejs', wordTrig = true },
    fmta(
      [[
\begin{lstlisting}[language=JavaScript]
	<>
\end{lstlisting}
  ]],
      { i(0) }
    )
  ),
  -- ========== Truth tables ==========
  s(
    { trig = 'tt2', wordTrig = true },
    fmta(
      [[
\begin{center}
\begin{tabular}{cc|ccc}
\toprule
$P$ & $Q$ & <> & <> \\
\midrule
\T & \T &  &  \\
\T & \F &  &  \\
\F & \T &  &  \\
\F & \F &  &  \\
\bottomrule
\end{tabular}
\end{center}
  ]],
      { i(1, '\\neg P'), i(2, 'P \\to Q') }
    )
  ),

  s(
    { trig = 'tt3', wordTrig = true },
    fmta(
      [[
\begin{center}
\begin{tabular}{ccc|cc}
\toprule
$P$ & $Q$ & $R$ & <> & <> \\
\midrule
\T & \T & \T &  &  \\
\T & \T & \F &  &  \\
\T & \F & \T &  &  \\
\T & \F & \F &  &  \\
\F & \T & \T &  &  \\
\F & \T & \F &  &  \\
\F & \F & \T &  &  \\
\F & \F & \F &  &  \\
\bottomrule
\end{tabular}
\end{center}
  ]],
      { i(1, 'P \\land Q'), i(2, '(P \\lor R)\\to Q') }
    )
  ),

  -- ========== Small helpers ==========
  s({ trig = 'q', wordTrig = true }, { t '{' }),
  s({ trig = 'e', wordTrig = true }, { t '}' }),
  s({ trig = 'r', wordTrig = true }, { t '\\' }),
  s({ trig = 'qq', wordTrig = true }, { t '{', i(0), t '}' }),

  -- ========== Boxes ==========
  s(
    { trig = 'box', wordTrig = true },
    fmta(
      [[
\begin{tcolorbox}[mybox]
\textbf{<>.} <>
\end{tcolorbox}
  ]],
      { i(1, 'Titel/etiket'), i(0, 'Indhold her.') }
    )
  ),

  s(
    { trig = 'thm', wordTrig = true },
    fmta(
      [[
\begin{theorem}{<>}{<>}
  <>
\end{theorem}
  ]],
      { i(1, 'Evt. undertitel'), i(2, 'label'), i(0, 'Indhold') }
    )
  ),

  -- ========== Blue info box ==========
  s(
    { trig = 'bluebox', wordTrig = true, desc = 'Blå informationsboks med titel' },
    fmta(
      [[
\begin{tcolorbox}[colback=blue!5!white,colframe=blue!75!black,title={\textit{<>}}]
<>
\end{tcolorbox}
    ]],
      { i(1, 'Titel her'), i(0, 'Indhold her...') }
    )
  ),
})
