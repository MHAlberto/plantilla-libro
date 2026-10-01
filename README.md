# Plantilla de apuntes

**Autoría:** M.H. Alberto
**Uso previsto:** personal

Plantilla autocontenida para escribir apuntes de cualquier tema con estructura y diseño de libro. Conserva la composición editorial de la referencia —A4, doble cara, preliminares, capítulos, índices y bibliografía— sin incorporar contenido temático de ejemplo.

La clase notas.cls, los ajustes de compilación y los archivos de contenido están incluidos en este repositorio. No se necesita copiar archivos desde otro proyecto. La firma inicial de los apuntes es **M.H. Alberto**.

## Usar esta plantilla para unos apuntes nuevos

Crea primero un repositorio privado vacío en GitHub. Clona esta plantilla, cambia el remoto para que apunte al nuevo repositorio y sube la rama inicial:

    git clone https://github.com/MHAlberto/plantilla-libro.git mis-apuntes
    cd mis-apuntes
    git remote set-url origin https://github.com/MHAlberto/NOMBRE-DEL-REPOSITORIO.git
    git push --set-upstream origin main

Sustituye NOMBRE-DEL-REPOSITORIO por el nombre que elegiste. El destino debe estar vacío para poder subir la rama main con su historial de partida. Si conservas el remoto original, un push enviaría tus cambios a la plantilla.

Tras clonar, edita el título, el prefacio y los capítulos. Conserva M.H. Alberto como firma del documento.

## Requisitos

Se necesita una distribución TeX que incluya:

- XeLaTeX, requerido por fontspec, polyglossia y unicode-math.
- latexmk, para automatizar las pasadas de compilación.
- Biber, para procesar las referencias bibliográficas.
- MakeIndex, para generar el índice de palabras.
- Los paquetes de LaTeX que carga notas.cls.

TeX Live ofrece estos programas y paquetes. En Windows también puede usarse MiKTeX, siempre que XeLaTeX, Biber, MakeIndex y latexmk estén disponibles desde la terminal.

## Compilar y limpiar

Abre una terminal en la raíz del proyecto y ejecuta:

    latexmk -xelatex -interaction=nonstopmode -file-line-error main.tex

El archivo .latexmkrc selecciona XeLaTeX. latexmk vuelve a ejecutar las pasadas necesarias para actualizar referencias cruzadas, la bibliografía y el índice. El resultado es main.pdf.

Para eliminar los archivos auxiliares locales:

    latexmk -C

El comando de limpieza conserva los archivos fuente .tex y .bib, la clase y los recursos gráficos.

## Personalizar los apuntes

### Portada

Cambia estos valores al inicio de main.tex:

- tituloapuntes: título principal.
- subtituloapuntes: subtítulo opcional; puede dejarse vacío.
- autorapuntes: firma que aparece en la portada. El valor inicial es M.H. Alberto.

contenido/portada.tex compone la página a partir de esos valores. La clase mantiene el diseño general, la tipografía y la distribución de páginas.

### Preliminares

- contenido/dedicatoria.tex es opcional y puede dejarse vacío.
- contenido/prefacio.tex contiene un texto genérico que puedes reemplazar o dejar vacío. Si quitas el archivo, elimina también su línea de entrada en main.tex.
- main.tex decide el orden de la portada y las páginas preliminares.

### Capítulos

El primer archivo es contenido/capitulos/capitulo-01.tex. Para crear otro:

1. Duplica el archivo y cambia su nombre, por ejemplo capitulo-02.tex.
2. Cambia el título y la etiqueta del capítulo.
3. Agrega una línea de entrada en main.tex, dentro de mainmatter.

Ejemplo de capítulo:

    \chapter{Título del capítulo}
    \label{cap:capitulo-02}

    \section{Título de la sección}
    Escribe aquí tus notas.

Los archivos se leen en el orden de las líneas input. La clase abre los capítulos en página impar y mantiene la composición a doble cara.

### Organización del documento

- frontmatter: portada y preliminares, con numeración romana.
- mainmatter: capítulos principales, con numeración arábiga.
- backmatter: índice y bibliografía.

Puedes retirar los componentes que no uses. Por ejemplo, para eliminar el índice, quita makeindex y printindex de main.tex; para eliminar la bibliografía, quita addbibresource y printbibliography.

## Herramientas editoriales incluidas

### Figuras, imágenes y tablas

Guarda las imágenes propias en assets/ y utiliza rutas relativas a la raíz del proyecto. Ejemplo:

    \begin{figure}[htbp]
      \centering
      \includegraphics[width=0.8\textwidth]{assets/mi-imagen.png}
      \caption{Descripción de la imagen.}
      \label{fig:mi-imagen}
    \end{figure}

La clase carga graphicx, TikZ, booktabs, array y caption. Incluye el comando imagenfigura y el entorno figuranotas para reutilizar formatos de figura. Usa etiquetas distintas para cada figura y tabla.

### Bloques y referencias cruzadas

notas.cls incluye entornos opcionales como definition, theorem, lemma, proposition, corollary, example, exercise, problem, remark y notation. Se pueden emplear cuando sean pertinentes o quitar de los capítulos si no se necesitan. Los contadores de estos bloques se organizan por sección.

Etiqueta las secciones, figuras, tablas, ecuaciones y bloques que vayas a citar. Para referencias legibles, la plantilla carga cleveref:

    \section{Sección de referencia}
    \label{sec:referencia}

    Como se explica en la \cref{sec:referencia}, ...

### Bibliografía

Añade las fuentes en bibliografia.bib y cítalas desde el texto mediante \cite{clave}. Al final aparecen las fuentes citadas. La clase configura Biber y un estilo numérico.

### Índice de palabras

Marca una palabra para el índice mediante \index{palabra}. El índice se genera durante la compilación de latexmk. Si no usas índice, elimina makeindex y printindex de main.tex.

## GitHub Actions

El workflow en .github/workflows/latex.yml compila el documento en cada push y pull request; también se puede iniciar manualmente desde la pestaña Actions. Si la compilación termina bien, genera el artefacto apuntes-pdf con main.pdf. GitHub conserva ese artefacto durante 14 días; el PDF no se versiona en el repositorio.

El workflow instala XeLaTeX, Biber, MakeIndex y los paquetes necesarios en un runner de Ubuntu. Si una compilación falla, consulta el paso Compilar PDF en los logs de Actions.

## Archivos que Git no versiona

.gitignore excluye los auxiliares de LaTeX, los productos temporales de MakeIndex, el PDF local main.pdf y las carpetas build y out. Sí se guardan los fuentes, las imágenes de assets/, la clase, la bibliografía y la configuración de GitHub.

.gitattributes mantiene finales de línea LF para los fuentes, lo que facilita alternar entre Windows y los runners Linux de GitHub.

## Solución de problemas

- **No se encuentra xelatex, latexmk, biber o makeindex:** instala el programa en tu distribución TeX y reinicia la terminal para actualizar PATH.
- **La bibliografía no aparece:** revisa que la clave de \cite coincida con una entrada de bibliografia.bib; compila con latexmk para ejecutar Biber.
- **Las referencias muestran ?? o el índice está vacío:** vuelve a compilar; latexmk debe completar las pasadas auxiliares.
- **No aparece una imagen:** revisa la ruta desde la raíz del proyecto, el nombre y la extensión del archivo.
- **Git quiere añadir auxiliares:** confirma que .gitignore está en la raíz y revisa el nombre exacto del archivo.
- **La portada muestra datos anteriores:** modifica las macros de portada en main.tex y vuelve a compilar.

## Autoría y uso

© M.H. Alberto. Plantilla de uso personal; este repositorio no concede una licencia de redistribución.
