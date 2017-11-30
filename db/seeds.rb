user = {
  vname: "Sven",
  nname: "Koesling",
  email: "sven.koesling@library.ethz.ch",
  password_digest: "$2a$10$pnuaNKMiuB9smJtHvt4cs.AU3ZzoV9VVj2PlwnvwiyyguwzPE08/y",
  admin: true,
  geloescht: false
}

if User.create(user)
  puts "initial user (#{user.email}) created"
end