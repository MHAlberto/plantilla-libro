# Plantilla personal de apuntes en LaTeX

**Autoría y firma de las notas:** M.H. Alberto
**Uso previsto:** personal
**Ejemplo incluido:** geometría hiperbólica

Este repositorio contiene un proyecto LaTeX autocontenido que conserva la composición editorial de libro de la referencia y la adapta a apuntes personales. Incluye la clase, portada, preliminares, diez capítulos de muestra, dos apéndices, figuras TikZ editables, referencias cruzadas, bibliografía, índice y compilación automática en GitHub Actions.

La geometría hiperbólica es un ejemplo para aprender comparando archivos completos. Al clonar el proyecto para otro tema, puedes sustituir el contenido y conservar la estructura editorial y las herramientas. La firma configurada es M.H. Alberto.

## Empezar tus propios apuntes

Crea primero un repositorio privado vacío en GitHub. Clona este proyecto, cambia el remoto y publica la rama inicial:

    git clone https://github.com/MHAlberto/plantilla-libro.git mis-apuntes
    cd mis-apuntes
    git remote set-url origin https://github.com/MHAlberto/NOMBRE-DEL-REPOSITORIO.git
    git push --set-upstream origin main

Reemplaza NOMBRE-DEL-REPOSITORIO por el nombre de tu repositorio privado. Debe estar vacío para que puedas subir la rama main. El cambio de remoto evita publicar tus notas en el repositorio de la plantilla.

Después, edita el título en main.tex y reemplaza los archivos de contenido según tus apuntes. Conserva M.H. Alberto como firma.

## Estructura del proyecto

    main.tex                              Configuración y orden del documento
    notas.cls                             Diseño editorial y herramientas LaTeX
    bibliografia.bib                      Fuentes bibliográficas en formato BibLaTeX
    .latexmkrc                            Configuración de compilación con XeLaTeX
    .gitignore                            Exclusión de archivos auxiliares y salidas
    .gitattributes                        Finales de línea para Windows y Linux
    .github/workflows/latex.yml           Compilación automática y artefacto PDF
    contenido/
      portada.tex                         Portada editable desde las macros de main.tex
      dedicatoria.tex                     Página opcional
      prefacio.tex                        Prefacio del ejemplo
      capitulos/
        capitulo-01.tex                   Comandos básicos y ejemplo TikZ
        capitulo-02.tex                   Disco de Poincaré
        capitulo-03.tex                   Semiplano superior
        capitulo-04.tex                   Triángulos y área
        capitulo-05.tex                   Longitud y distancia
        capitulo-06.tex                   Isometrías
        capitulo-07.tex                   Polígonos y teselaciones
        capitulo-08.tex                   Curvatura y Gauss--Bonnet
        capitulo-09.tex                   Comparación de modelos
        capitulo-10.tex                   Problemas de repaso
      apendices/
        apendice-01-guia-de-uso.tex        Manual de los componentes de la plantilla
        apendice-02-soluciones.tex         Soluciones seleccionadas
    assets/
      tikz/                               Dibujos editables e incluidos con input

El orden de lectura está escrito explícitamente en main.tex mediante líneas input. El archivo principal selecciona los preliminares, capítulos, apéndices, índice y bibliografía.

## Requisitos

La compilación local necesita:

- XeLaTeX, porque la clase utiliza fontspec, polyglossia y unicode-math.
- latexmk, para ejecutar las pasadas necesarias en orden.
- Biber, para construir la bibliografía.
- MakeIndex, para generar el índice.
- Una distribución TeX con los paquetes cargados por notas.cls.

TeX Live o MiKTeX pueden proporcionar estos programas. Verifica que estén disponibles desde la terminal.

## Compilar y limpiar

Desde la raíz del proyecto, genera el PDF con:

    latexmk -xelatex -interaction=nonstopmode -file-line-error main.tex

El resultado local es main.pdf. latexmk vuelve a ejecutar XeLaTeX, Biber y MakeIndex cuando hacen falta y actualiza las referencias cruzadas.

No compiles solo con xelatex main.tex para la versión final: esa orden ejecuta una pasada de XeLaTeX, pero no procesa por sí sola la bibliografía con Biber ni el índice con MakeIndex. Usa latexmk como en el comando anterior. En un editor que solo haga una pasada, ejecuta latexmk desde una terminal o descarga el artefacto apuntes-pdf generado en GitHub Actions.

Para quitar los archivos auxiliares sin borrar los fuentes:

    latexmk -C

Los archivos temporales también están cubiertos por .gitignore.

## Personalizar la portada y preliminares

En main.tex cambia las macros tituloapuntes y subtituloapuntes. La macro autorapuntes contiene la firma M.H. Alberto. La portada se compone en contenido/portada.tex y mantiene el diseño de libro.

Puedes dejar contenido/dedicatoria.tex vacío o quitar su línea input de main.tex. El prefacio está en contenido/prefacio.tex. Si eliminas o renombras un archivo, actualiza la ruta correspondiente en main.tex.

## Añadir capítulos

Crea un archivo dentro de contenido/capitulos, por ejemplo capitulo-11.tex:

    \chapter{Título del capítulo}
    \label{cap:tema}

    \section{Primera sección}
    Escribe aquí tus apuntes.

Luego añade en main.tex, dentro de mainmatter:

    \input{contenido/capitulos/capitulo-11}

Separa párrafos con una línea en blanco. Para crear subsecciones, usa subsection y subsubsection. Usa etiquetas únicas. La clase abre los capítulos en página impar, como en un libro a doble cara.

## Texto, comandos y matemáticas

El capítulo 1 es una hoja de referencia comentada. Algunos comandos usuales son:

- Porcentaje inicia un comentario en el fuente.
- chapter, section y subsection crean encabezados.
- textbf y emph aplican énfasis.
- itemize crea una lista con viñetas; enumerate crea una lista numerada.
- verbatim muestra código LaTeX tal cual.
- verb presenta un comando breve dentro de una frase.

Escribe las fórmulas en línea entre \(...\), sin numerar entre \[...\], o con el entorno equation para numerarlas. Por ejemplo:

    \begin{equation}
      E=mc^2.
      \label{eq:energia}
    \end{equation}

La clase incluye entornos como definition, theorem, lemma, proposition, corollary, example, exercise, problem, remark y notation. Cada bloque comparte numeración por sección y puede recibir una etiqueta para citarlo.

## Etiquetas, referencias y enlaces

Coloca label después del elemento que quieres referir y usa ref, eqref o cleveref:

    \section{Definiciones}
    \label{sec:definiciones}

    Consulta la \cref{sec:definiciones} y la \eqref{eq:energia}.

Convención sugerida para las etiquetas:

- cap: capítulos
- sec: secciones
- eq: ecuaciones
- fig: figuras
- tab: tablas
- prob: problemas
- ap: apéndices

cleveref añade automáticamente el tipo de objeto. No repitas una misma etiqueta. Si una referencia aparece como ??, vuelve a compilar con latexmk.

## Figuras, imágenes y TikZ

Guarda los recursos en assets/. Puedes insertar imágenes con includegraphics o mantener un dibujo TikZ como fuente editable en assets/tikz/. Los dibujos de ejemplo son archivos completos de tikzpicture, incluidos desde el capítulo con input:

    \begin{figure}[htbp]
      \centering
      \input{assets/tikz/mi-dibujo}
      \caption{Descripción del dibujo.}
      \label{fig:mi-dibujo}
    \end{figure}

input solo inserta el código: el entorno figure, el pie, la numeración y la etiqueta pertenecen al capítulo. Las rutas se resuelven desde la raíz del repositorio.

Para una imagen externa:

    \begin{figure}[htbp]
      \centering
      \includegraphics[width=0.8\textwidth]{assets/mi-imagen.png}
      \caption{Descripción de la imagen.}
      \label{fig:mi-imagen}
    \end{figure}

Las bibliotecas TikZ usadas por la clase están declaradas en notas.cls. Añade allí otra biblioteca si un dibujo la requiere.

## Tablas e índice de palabras

Para tablas simples, usa tabular y booktabs; consulta la tabla comparativa del capítulo 9. Marca un término para el índice con index:

    La \index{geodésica}geodésica minimiza localmente la longitud.

La clase y main.tex activan imakeidx. latexmk llama a MakeIndex y printindex coloca el resultado al final. Si no necesitas un índice, elimina makeindex y printindex de main.tex.

La clase también ofrece figuranotas para envolver contenido en una figura con pie y etiqueta, semblanza para un retrato con texto, y bloqueimagenizquierda y bloqueimagenderecha para componer imagen y texto en columnas. El apéndice A documenta los argumentos de cada macro. Son opcionales: las figuras y minipáginas estándar de LaTeX siguen disponibles.

## Bibliografía

Añade las fuentes en bibliografia.bib. Cada entrada necesita una clave única:

    @book{clave,
      author    = {Apellido, Nombre},
      title     = {Título},
      publisher = {Editorial},
      year      = {2026}
    }

Cita en el texto con cite:

    El resultado se estudia en \cite{clave}.

La bibliografía numérica se genera con Biber y solo imprime obras citadas. La plantilla trae lecturas básicas de geometría no euclidiana, geometría hiperbólica, grupos discretos y superficies. Comprueba los datos editoriales al añadir nuevas referencias.

## Apéndices

Después de los capítulos principales, main.tex activa appendix y carga los archivos dentro de contenido/apendices. A partir de ese punto, cada chapter se numera con letras. Para añadir uno, crea un archivo y añade su input después de appendix.

El apéndice A es una guía práctica. El B contiene soluciones seleccionadas y muestra cómo enlazar problemas del cuerpo con material posterior.

## GitHub Actions y PDF

El workflow .github/workflows/latex.yml compila en cada push y pull request, y también se puede ejecutar manualmente desde la pestaña Actions. El archivo main.pdf se publica como artefacto descargable llamado apuntes-pdf, que GitHub conserva durante 14 días.

Si la compilación falla, abre Actions, selecciona la ejecución y revisa el paso Compilar PDF. Allí aparecerá el primer error de LaTeX con archivo y número de línea. Los warnings suelen indicar una referencia pendiente, un carácter o una caja de texto que conviene revisar.

## Qué se versiona

Git conserva los fuentes .tex y .bib, la clase, los dibujos y la configuración. .gitignore excluye auxiliares como aux, log, toc, bbl e idx, además de los PDF locales y las carpetas build y out. .gitattributes conserva finales de línea LF para alternar entre Windows y Linux.

## Diagnóstico rápido

- No se encuentra xelatex, latexmk, biber o makeindex: instala los ejecutables de la distribución TeX y actualiza PATH.
- No aparece la bibliografía o una cita: confirma que la clave de cite coincide exactamente con bibliografia.bib y recompila con latexmk; una sola pasada de XeLaTeX no ejecuta Biber.
- Una referencia muestra ?? o un capítulo no entra al índice general: revisa label, ref y el orden de compilación.
- Falta una figura: confirma el nombre, extensión y ruta desde la raíz del proyecto.
- Una figura TikZ falla: comprueba llaves y puntos y coma; cada comando draw o node termina con punto y coma.
- Git detecta archivos auxiliares: confirma que .gitignore está en la raíz y que se ejecuta Git desde el proyecto.

## Autoría y uso personal

Las notas y la plantilla llevan la firma M.H. Alberto. Este repositorio se ha preparado para uso personal y no concede una licencia de redistribución.
