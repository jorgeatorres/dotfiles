
au FileType php setl cindent omnifunc=phpcomplete#CompletePHP
au FileType python setl omnifunc=pythoncomplete#Complete

"au Filetype python setl makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
au Filetype python setl makeprg=python\ %

au FileType ruby setl ts=2 sts=0 sw=2 makeprg=ruby\ %

