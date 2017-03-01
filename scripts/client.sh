for f in ./web/static/css/*; do
  base=$(basename "$f")
  filename="${base%.*}"
  extension="${base##*.}"

  if [[ "$extension" == "scss" ]]; then
    new="./priv/static/css/${filename}.css"
    scss "$f" > $new
    echo "Compiled $f -> $new"
  elif [[ "$extension" == "css" ]]; then
    new="./priv/static/css/$base"
    cp "$f" $new
    echo "Copied   $f -> $new"
  fi
done
