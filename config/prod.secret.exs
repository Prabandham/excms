use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :ex_cms, ExCmsWeb.Endpoint,
  secret_key_base: "Vw81SdITYSAAWGgGUbDxqZCxbcyoxftmm00j5sipBHDEG1Lc659m23CeNvxuauIZ"

# Configure your database
config :ex_cms, ExCms.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ex_cms_prod",
  pool_size: 15
