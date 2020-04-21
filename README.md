# ShadersDithering

## Autor

Héctor Henríquez Cabrera

Correo: [hector.henriquez101@alu.ulpgc.es](mailto:hector.henriquez101@alu.ulpgc.es)

Asignatura: Creando Interfaces de Usuario (CIU)

## Introducción

En está novena práctica se ha compuesto una aplicación mediante **processing 3**. Se ha creado una ventana que con la ayuda de una cámara web se podrá  observar un filtro, el cual muestra un efecto de dithering creado mediante shaders.

## Demo

![](demo.gif)

En la demo se puede apreciar el efecto dithering en una imagen.

## Implementación

### Librerías

Para la implementación de esta aplicación se ha usado **GifAnimation**. Pero esta no es necesario para su reproducción en otro sistema ya que  solo se uso para  la inclusión del gif, que serviría de demo, pero a  la hora de probar la aplicación no es necesario tenerlo instalado, debido a que no ejecuta nada actualmente (en caso de querer generar un gif nuevo descomentar las líneas de esta librería) .

Además se ha usado las librerías de **video** de processing para la captura de la cámara.

### Diseño

Para el diseño de esta aplicación se opto por añadir la menor  cantidad  de elementos que dificultasen la visualización del sistema,  solo teniendo texto mostrando los filtros y el filtro actual.

### Funcionalidades

Para la creación de esta práctica se ha creado un filtro que se asemejase al efecto de dithering.  Para crear este efecto se ha cambiado la imagen original a blanco y negro, mediante una función creada por nosotros mismo para este propósito, debido a que se iba a limitar a replicar este efecto sin colores.

```glsl
float color2gray(vec3 source){
	return length(source*vec3(0.25,0.75,0.0));
}
```

 Además tendremos que ajustar la textura del ruido para ajustarla a la imagen original, con lo que se usó la siguiente función para tal propósito.

```glsl
vec3 getNoisePixels(){
	return texture2D(noiseTexture, vec2(mod(gl_FragCoord.xy/vec2(res,res),1.0))).xyz;
}
```

Una vez teniendo esto solo hace falta combinarlos de tal manera de que la máscara actúe en los puntos más oscuros.

```glsl
	float ditheredResult=grayscale + ditherGrayscale;
	float bit=ditheredResult>=0.5? 1.0 : 0.0;
```

Esta es una opción para realizar este filtro, otra opción es usar el algoritmo de **Floyd–Steinberg dithering**, con el cual además se podría realizar el filtro con colores. Este algoritmo **No se uso para esta práctica.**

## Controles

No se ha usado ningún evento de teclado. Las teclas y acciones consecuentes que las activan son:

| Tecla        | Uso                         |
| ------------ | --------------------------- |
| Pulsar ratón | Cambiar a cámara sin filtro |

## Bibliografía

[Guion de prácticas](https://cv-aep.ulpgc.es/cv/ulpgctp20/pluginfile.php/126724/mod_resource/content/22/CIU_Pr_cticas.pdf)

[processing.org](https://processing.org/)

[Dithering](https://en.wikipedia.org/wiki/Dither)

[Floyd–Steinberg dithering](https://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering)