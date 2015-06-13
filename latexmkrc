add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
$clean_ext .= ' %R.ist %R.xdy';

$pdflatex = 'xelatex -interaction=nonstopmode -synctex=1 -shell-escape %O %S';
$bibtex_use = 1;
$biber = 'biber --debug %O %S';
$pdf_previewer = 'open %O %S';
$clean_ext = '%R.run.xml %R.syntex.gz';
