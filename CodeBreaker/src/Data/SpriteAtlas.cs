using System;
using System.Globalization;
using System.IO;
using System.Xml;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

namespace CodeBreaker.Data
{
    // Carga los sprites que estén en Content/Sprites. Acepta dos formatos:
    //
    // 1) Spritesheet PNG + XML (como los de Kenney). El recorte de cada sprite se toma del XML:
    //      <TextureAtlas imagePath="hoja.png">
    //        <SubTexture name="nombre.png" x="0" y="0" width="64" height="64"/>
    //      </TextureAtlas>
    // 2) PNG suelto, sin XML. Se usa la imagen entera como un sprite, y su nombre es el del
    //    archivo (por ejemplo "rojo.png"). No hace falta ninguna coordenada.
    //
    // En ningún caso hay coordenadas inventadas ni texturas generadas por código.
    public class SpriteAtlas
    {
        public const int NotFound = -1;
        public const int MaxTextures = 32;  // máximo de imágenes PNG (hojas + sueltas)
        public const int MaxSprites = 4096; // máximo de sprites sumando todas las imágenes

        private readonly Texture2D[] textures = new Texture2D[MaxTextures];
        private readonly string[] textureFileNames = new string[MaxTextures]; // nombre del PNG de cada textura
        private int textureCount = 0;

        // Tres arrays paralelos: en la posición i está todo lo del sprite i.
        private readonly string[] names = new string[MaxSprites];
        private readonly Rectangle[] sources = new Rectangle[MaxSprites];
        private readonly int[] textureIndexes = new int[MaxSprites];
        private int spriteCount = 0;

        public string Warning { get; private set; } // "" si no hubo problemas

        public SpriteAtlas()
        {
            Warning = "";
        }

        public int SpriteCount
        {
            get { return spriteCount; }
        }

        // Carga primero los spritesheets (cada XML con su PNG) y después los PNG sueltos.
        // Si la carpeta está vacía no es un error: se dibujan letras sin avisar.
        // Solo se avisa si un archivo que está no se puede leer.
        public void LoadFolder(GraphicsDevice device, string folder)
        {
            string[] xmlFiles;
            string[] pngFiles;
            try
            {
                if (!Directory.Exists(folder))
                {
                    return;
                }
                xmlFiles = Directory.GetFiles(folder, "*.xml");
                pngFiles = Directory.GetFiles(folder, "*.png");
            }
            catch (Exception ex)
            {
                AddWarning("No se pudo leer Content/Sprites (" + ex.Message + ").");
                return;
            }

            // 1) Spritesheets: PNG + XML
            for (int i = 0; i < xmlFiles.Length; i++)
            {
                if (textureCount == MaxTextures)
                {
                    AddWarning("Hay más de " + MaxTextures + " imágenes en Content/Sprites: se ignoran las demás.");
                    return;
                }
                try
                {
                    LoadSheet(device, xmlFiles[i]);
                }
                catch (Exception ex)
                {
                    AddWarning("No se pudo cargar " + Path.GetFileName(xmlFiles[i]) + " (" + ex.Message + ").");
                }
            }

            // 2) PNG sueltos: los que no son la imagen de ningún spritesheet
            for (int i = 0; i < pngFiles.Length; i++)
            {
                string fileName = Path.GetFileName(pngFiles[i]);
                if (IsLoadedImage(fileName))
                {
                    continue; // ya se cargó como hoja de un XML
                }
                if (textureCount == MaxTextures)
                {
                    AddWarning("Hay más de " + MaxTextures + " imágenes en Content/Sprites: se ignoran las demás.");
                    return;
                }
                try
                {
                    LoadSingleImage(device, pngFiles[i]);
                }
                catch (Exception ex)
                {
                    AddWarning("No se pudo cargar " + fileName + " (" + ex.Message + ").");
                }
            }
        }

        // Busca si un PNG ya se cargó (búsqueda lineal en el array de nombres).
        private bool IsLoadedImage(string fileName)
        {
            for (int i = 0; i < textureCount; i++)
            {
                if (string.Equals(textureFileNames[i], fileName, StringComparison.OrdinalIgnoreCase))
                {
                    return true;
                }
            }
            return false;
        }

        // Carga una hoja: primero lee el XML y después el PNG. Si algo falla, descarta esa hoja.
        private void LoadSheet(GraphicsDevice device, string xmlPath)
        {
            int firstSprite = spriteCount;
            try
            {
                string imageName = ReadXml(xmlPath);
                if (spriteCount == firstSprite)
                {
                    throw new InvalidDataException("el XML no tiene etiquetas SubTexture");
                }

                string imagePath = Path.Combine(Path.GetDirectoryName(xmlPath), imageName);
                // FromFile carga el PNG descargado tal cual (no se dibuja ni se edita nada).
                // PremultiplyAlpha deja la transparencia como la espera SpriteBatch.
                textures[textureCount] = Texture2D.FromFile(device, imagePath, DefaultColorProcessors.PremultiplyAlpha);
                textureFileNames[textureCount] = Path.GetFileName(imageName);
                textureCount++;
            }
            catch (Exception)
            {
                spriteCount = firstSprite; // se descartan los sprites de esta hoja
                throw;                     // el aviso lo arma LoadFolder
            }
        }

        // Carga un PNG suelto como un solo sprite: la imagen entera, con el nombre del archivo.
        private void LoadSingleImage(GraphicsDevice device, string pngPath)
        {
            if (spriteCount == MaxSprites)
            {
                AddWarning("Se llegó al máximo de " + MaxSprites + " sprites: se ignoran los demás.");
                return;
            }

            Texture2D texture = Texture2D.FromFile(device, pngPath, DefaultColorProcessors.PremultiplyAlpha);
            textures[textureCount] = texture;
            textureFileNames[textureCount] = Path.GetFileName(pngPath);

            names[spriteCount] = Path.GetFileName(pngPath);
            sources[spriteCount] = new Rectangle(0, 0, texture.Width, texture.Height); // la imagen entera
            textureIndexes[spriteCount] = textureCount;
            spriteCount++;
            textureCount++;
        }

        // Lee el XML con XmlReader. Guarda cada SubTexture y devuelve el nombre del PNG (imagePath).
        private string ReadXml(string xmlPath)
        {
            string imageName = "";
            XmlReaderSettings settings = new XmlReaderSettings();
            settings.DtdProcessing = DtdProcessing.Ignore;

            using (XmlReader reader = XmlReader.Create(xmlPath, settings))
            {
                while (reader.Read())
                {
                    if (reader.NodeType != XmlNodeType.Element)
                    {
                        continue;
                    }

                    if (reader.Name == "TextureAtlas")
                    {
                        imageName = reader.GetAttribute("imagePath");
                    }
                    else if (reader.Name == "SubTexture")
                    {
                        AddSprite(reader);
                    }
                }
            }

            if (string.IsNullOrEmpty(imageName))
            {
                throw new InvalidDataException("falta imagePath en <TextureAtlas>");
            }
            return imageName;
        }

        // Guarda un <SubTexture> en los arrays paralelos.
        private void AddSprite(XmlReader reader)
        {
            if (spriteCount == MaxSprites)
            {
                AddWarning("Se llegó al máximo de " + MaxSprites + " sprites: se ignoran los demás.");
                return;
            }

            string name = reader.GetAttribute("name");
            int x = ReadInt(reader, "x");
            int y = ReadInt(reader, "y");
            int width = ReadInt(reader, "width");
            int height = ReadInt(reader, "height");
            if (name == null || width <= 0 || height <= 0)
            {
                return; // SubTexture incompleta: se saltea
            }

            names[spriteCount] = name;
            sources[spriteCount] = new Rectangle(x, y, width, height);
            textureIndexes[spriteCount] = textureCount; // la hoja que se está cargando
            spriteCount++;
        }

        // Lee un atributo numérico. Si falta o no es número, tira una excepción (la hoja se descarta).
        private static int ReadInt(XmlReader reader, string attribute)
        {
            string text = reader.GetAttribute(attribute);
            if (text == null)
            {
                throw new InvalidDataException("a una SubTexture le falta '" + attribute + "'");
            }
            return int.Parse(text, CultureInfo.InvariantCulture);
        }

        // Busca un sprite por nombre. 1) nombre exacto; 2) primer nombre que contenga el texto.
        // No distingue mayúsculas de minúsculas. Devuelve NotFound (-1) si no hay ninguno.
        public int Find(string text)
        {
            if (string.IsNullOrEmpty(text))
            {
                return NotFound;
            }
            for (int i = 0; i < spriteCount; i++)
            {
                if (string.Equals(names[i], text, StringComparison.OrdinalIgnoreCase))
                {
                    return i;
                }
            }
            for (int i = 0; i < spriteCount; i++)
            {
                if (names[i].IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    return i;
                }
            }
            return NotFound;
        }

        // Dibuja el sprite centrado dentro de "area", sin deformarlo (mantiene la proporción)
        // y con sus colores originales.
        public void Draw(SpriteBatch spriteBatch, int spriteIndex, Rectangle area)
        {
            if (spriteIndex < 0 || spriteIndex >= spriteCount)
            {
                return;
            }

            Rectangle source = sources[spriteIndex];
            float scaleX = (float)area.Width / source.Width;
            float scaleY = (float)area.Height / source.Height;
            float scale = scaleX < scaleY ? scaleX : scaleY;

            int width = (int)(source.Width * scale);
            int height = (int)(source.Height * scale);
            Rectangle destination = new Rectangle(
                area.X + (area.Width - width) / 2,
                area.Y + (area.Height - height) / 2,
                width,
                height);

            spriteBatch.Draw(textures[textureIndexes[spriteIndex]], destination, source, Color.White);
        }

        private void AddWarning(string text)
        {
            Warning = Warning.Length == 0 ? text : Warning + " " + text;
        }
    }
}
