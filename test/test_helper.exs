ExUnit.start()

Mox.defmock(MockGumHub, for: GumHub)
Mox.defmock(MockGumroad, for: GumHub.Gumroad)
Mox.defmock(MockGitHub, for: GumHub.GitHub)
