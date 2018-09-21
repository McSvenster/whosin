secrets_file = "/home/kosven/.whosinVars.yml"
SECRET = File.exists?(secrets_file) ? YAML.load_file(secrets_file) : {}
