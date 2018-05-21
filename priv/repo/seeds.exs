# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ExCms.Repo.insert!(%ExCms.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

admin_user_params = %{ email: "srinidhi@larks.in", password: "R1d1cu!0u$", full_name: "Srinidhi Prabandham", is_active: true, attributes: %{}}
ExCms.Accounts.create_admin(admin_user_params)
