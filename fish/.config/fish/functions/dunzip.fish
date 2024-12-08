function dunzip -d "Unzip a file to a new folder with its name"
    command unzip "$argv[1]" -d (path change-extension '' "$argv[1]")
end