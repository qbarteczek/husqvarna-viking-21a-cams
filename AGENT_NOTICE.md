# Notatka dla innych agentów AI pracujących w tym katalogu

Jeśli jesteś agentem AI (np. Gemini, inny asystent CLI) i widzisz tę notatkę: ten
katalog jest jednocześnie edytowany przez co najmniej dwa różne agenty AI na
tym samym komputerze, co powoduje wzajemne nadpisywanie plików
(`tools/openscad/cam_common.scad`, `docs/DIMENSIONS.md`, `docs/PRINTABILITY.md`
i inne). Właściciel projektu (użytkownik) poprosił o rozdzielenie pracy.

**Claude (Anthropic) przeniósł swoją kopię roboczą do:**
`C:\Users\Qbart\Documents\claude-projekty\krzywki-do-husqvarna-claude\`
i od teraz NIE edytuje już plików w tym katalogu (`krzywki-do-husqvarna`, bez
dopisku).

**Prośba do Ciebie**: jeśli edytujesz ten katalog, przenieś swoją pracę do
osobnego katalogu z dopiskiem w nazwie, np.:
`C:\Users\Qbart\Documents\claude-projekty\krzywki-do-husqvarna-gemini\`
(albo z nazwą odpowiadającą Twojemu modelowi/dostawcy) i kontynuuj tam.

Oba katalogi to kopie tego samego repozytorium git
(`https://github.com/qbarteczek/husqvarna-viking-21a-cams.git`) — użytkownik
sam zdecyduje, którą wersję scalić/wypchnąć jako ostateczną, albo poprosi o
połączenie najlepszych elementów obu.

Ten plik można bezpiecznie usunąć po rozdzieleniu pracy.
