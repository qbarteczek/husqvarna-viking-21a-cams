// ==============================================================================
// GENERATOR BĘBNÓW ŚCIEGOWYCH HUSQVARNA 21E (OpenSCAD Customizer GUI)
// ==============================================================================
// Otwórz ten plik w programie OpenSCAD. Włącz menu: Window -> Customizer.
// Wybierz literę bębna oraz 5 ściegów z list rozwijanych, naciśnij F6 (Render)
// i wyeksportuj gotowy plik STL do druku 3D (F7 lub File -> Export as STL).
// ==============================================================================

include <stitch_catalog.scad>

/* [Tryb pracy i Presety / Mode & Presets] */
// Wybierz jeden ze wzorców z projektu lub skomponuj własny zestaw
Preset = "Custom"; // [Custom:Własny zestaw ściegów / Custom mix, A1:Wzorzec A1 (Fabryczny standard S 41-10950), B1:Wzorzec B1 (Ozdobne fale i romby S 41-10951), C1:Wzorzec C1 (Geometryczne meandry S 41-10952), D:Wzorzec D (Specjalne użytkowe i wzmocnione)]

/* [Oznaczenie bębna / Drum Identification] */
// Litera wytłaczana na czole bębna (dla trybu Custom)
Custom_Letter = "E"; 

/* [Wybór ściegów dla trybu Custom / Custom Stitch Selection] */
// Aktywne tylko gdy Preset = Custom

// Pozycja 1 (najbliżej kołnierza czołowego)
Position_1 = 1; // [0:0. Prosty / Straight, 1:1. Ścieg kryty standard / Blind hem std, 2:2. Ścieg kryty gęsty / Blind hem dense, 3:3. Ścieg kryty szeroki / Blind hem wide, 4:4. Zygzak standardowy / Zigzag ref (A1/B1/C1), 5:5. Zygzak szeroki / Wide zigzag, 6:6. Zygzak wąski / Narrow zigzag, 7:7. Zygzak gęsty satynowy / Dense satin, 8:8. Trójskok elastyczny / 3-step elastic (A1), 9:9. Zygzak 4-stopniowy / 4-step elastic, 10:10. Owerlok otwarty / Open overlock, 11:11. Owerlok zamknięty / Closed overlock, 12:12. Potrójny elastyczny / Triple stretch, 13:13. Drabinka cerująca / Ladder stitch, 14:14. Serpentyna szeroka / Wide serpentine (B1), 15:15. Serpentyna średnia / Med serpentine, 16:16. Serpentyna gęsta / Dense serpentine, 17:17. Muszelka łuskowa / Scallop wave, 18:18. Podwójna pętla / Double lobe, 19:19. Piórko gałązkowe / Feather stitch, 20:20. Jodełka schodkowa / Stepped chevron (B1), 21:21. Ząbki skośne piła / Angled saw (B1), 22:22. Grzebyk drobny / Fine comb, 23:23. Satynowy romb liść / Diamond satin (B1), 24:24. Satynowy romb gęsty / Diamond satin 4c, 25:25. Perełki satynowe / Pearl beads, 26:26. Klepsydra satynowa / Hourglass (C1), 27:27. Płomienie satynowe / Flame satin (C1), 28:28. Stożek satynowy / Taper satin, 29:29. Grecki klucz meander / Greek key 4c (C1), 30:30. Grecki klucz gęsty / Greek key 5c, 31:31. Bloki satynowe / Satin blocks (C1), 32:32. Szachownica / Checker step, 33:33. Krzyżyki / Cross stitch, 34:34. Strzałka ostra / Arrowhead, 35:35. Plaster miodu / Honeycomb]

// Pozycja 2
Position_2 = 14; // [0:0. Prosty / Straight, 1:1. Ścieg kryty standard / Blind hem std, 2:2. Ścieg kryty gęsty / Blind hem dense, 3:3. Ścieg kryty szeroki / Blind hem wide, 4:4. Zygzak standardowy / Zigzag ref (A1/B1/C1), 5:5. Zygzak szeroki / Wide zigzag, 6:6. Zygzak wąski / Narrow zigzag, 7:7. Zygzak gęsty satynowy / Dense satin, 8:8. Trójskok elastyczny / 3-step elastic (A1), 9:9. Zygzak 4-stopniowy / 4-step elastic, 10:10. Owerlok otwarty / Open overlock, 11:11. Owerlok zamknięty / Closed overlock, 12:12. Potrójny elastyczny / Triple stretch, 13:13. Drabinka cerująca / Ladder stitch, 14:14. Serpentyna szeroka / Wide serpentine (B1), 15:15. Serpentyna średnia / Med serpentine, 16:16. Serpentyna gęsta / Dense serpentine, 17:17. Muszelka łuskowa / Scallop wave, 18:18. Podwójna pętla / Double lobe, 19:19. Piórko gałązkowe / Feather stitch, 20:20. Jodełka schodkowa / Stepped chevron (B1), 21:21. Ząbki skośne piła / Angled saw (B1), 22:22. Grzebyk drobny / Fine comb, 23:23. Satynowy romb liść / Diamond satin (B1), 24:24. Satynowy romb gęsty / Diamond satin 4c, 25:25. Perełki satynowe / Pearl beads, 26:26. Klepsydra satynowa / Hourglass (C1), 27:27. Płomienie satynowe / Flame satin (C1), 28:28. Stożek satynowy / Taper satin, 29:29. Grecki klucz meander / Greek key 4c (C1), 30:30. Grecki klucz gęsty / Greek key 5c, 31:31. Bloki satynowe / Satin blocks (C1), 32:32. Szachownica / Checker step, 33:33. Krzyżyki / Cross stitch, 34:34. Strzałka ostra / Arrowhead, 35:35. Plaster miodu / Honeycomb]

// Pozycja 3
Position_3 = 23; // [0:0. Prosty / Straight, 1:1. Ścieg kryty standard / Blind hem std, 2:2. Ścieg kryty gęsty / Blind hem dense, 3:3. Ścieg kryty szeroki / Blind hem wide, 4:4. Zygzak standardowy / Zigzag ref (A1/B1/C1), 5:5. Zygzak szeroki / Wide zigzag, 6:6. Zygzak wąski / Narrow zigzag, 7:7. Zygzak gęsty satynowy / Dense satin, 8:8. Trójskok elastyczny / 3-step elastic (A1), 9:9. Zygzak 4-stopniowy / 4-step elastic, 10:10. Owerlok otwarty / Open overlock, 11:11. Owerlok zamknięty / Closed overlock, 12:12. Potrójny elastyczny / Triple stretch, 13:13. Drabinka cerująca / Ladder stitch, 14:14. Serpentyna szeroka / Wide serpentine (B1), 15:15. Serpentyna średnia / Med serpentine, 16:16. Serpentyna gęsta / Dense serpentine, 17:17. Muszelka łuskowa / Scallop wave, 18:18. Podwójna pętla / Double lobe, 19:19. Piórko gałązkowe / Feather stitch, 20:20. Jodełka schodkowa / Stepped chevron (B1), 21:21. Ząbki skośne piła / Angled saw (B1), 22:22. Grzebyk drobny / Fine comb, 23:23. Satynowy romb liść / Diamond satin (B1), 24:24. Satynowy romb gęsty / Diamond satin 4c, 25:25. Perełki satynowe / Pearl beads, 26:26. Klepsydra satynowa / Hourglass (C1), 27:27. Płomienie satynowe / Flame satin (C1), 28:28. Stożek satynowy / Taper satin, 29:29. Grecki klucz meander / Greek key 4c (C1), 30:30. Grecki klucz gęsty / Greek key 5c, 31:31. Bloki satynowe / Satin blocks (C1), 32:32. Szachownica / Checker step, 33:33. Krzyżyki / Cross stitch, 34:34. Strzałka ostra / Arrowhead, 35:35. Plaster miodu / Honeycomb]

// Pozycja 4
Position_4 = 29; // [0:0. Prosty / Straight, 1:1. Ścieg kryty standard / Blind hem std, 2:2. Ścieg kryty gęsty / Blind hem dense, 3:3. Ścieg kryty szeroki / Blind hem wide, 4:4. Zygzak standardowy / Zigzag ref (A1/B1/C1), 5:5. Zygzak szeroki / Wide zigzag, 6:6. Zygzak wąski / Narrow zigzag, 7:7. Zygzak gęsty satynowy / Dense satin, 8:8. Trójskok elastyczny / 3-step elastic (A1), 9:9. Zygzak 4-stopniowy / 4-step elastic, 10:10. Owerlok otwarty / Open overlock, 11:11. Owerlok zamknięty / Closed overlock, 12:12. Potrójny elastyczny / Triple stretch, 13:13. Drabinka cerująca / Ladder stitch, 14:14. Serpentyna szeroka / Wide serpentine (B1), 15:15. Serpentyna średnia / Med serpentine, 16:16. Serpentyna gęsta / Dense serpentine, 17:17. Muszelka łuskowa / Scallop wave, 18:18. Podwójna pętla / Double lobe, 19:19. Piórko gałązkowe / Feather stitch, 20:20. Jodełka schodkowa / Stepped chevron (B1), 21:21. Ząbki skośne piła / Angled saw (B1), 22:22. Grzebyk drobny / Fine comb, 23:23. Satynowy romb liść / Diamond satin (B1), 24:24. Satynowy romb gęsty / Diamond satin 4c, 25:25. Perełki satynowe / Pearl beads, 26:26. Klepsydra satynowa / Hourglass (C1), 27:27. Płomienie satynowe / Flame satin (C1), 28:28. Stożek satynowy / Taper satin, 29:29. Grecki klucz meander / Greek key 4c (C1), 30:30. Grecki klucz gęsty / Greek key 5c, 31:31. Bloki satynowe / Satin blocks (C1), 32:32. Szachownica / Checker step, 33:33. Krzyżyki / Cross stitch, 34:34. Strzałka ostra / Arrowhead, 35:35. Plaster miodu / Honeycomb]

// Pozycja 5 (zalecany standardowy zygzak 4 dla pozycji spoczynkowej mechanizmu)
Position_5 = 4; // [0:0. Prosty / Straight, 1:1. Ścieg kryty standard / Blind hem std, 2:2. Ścieg kryty gęsty / Blind hem dense, 3:3. Ścieg kryty szeroki / Blind hem wide, 4:4. Zygzak standardowy / Zigzag ref (A1/B1/C1), 5:5. Zygzak szeroki / Wide zigzag, 6:6. Zygzak wąski / Narrow zigzag, 7:7. Zygzak gęsty satynowy / Dense satin, 8:8. Trójskok elastyczny / 3-step elastic (A1), 9:9. Zygzak 4-stopniowy / 4-step elastic, 10:10. Owerlok otwarty / Open overlock, 11:11. Owerlok zamknięty / Closed overlock, 12:12. Potrójny elastyczny / Triple stretch, 13:13. Drabinka cerująca / Ladder stitch, 14:14. Serpentyna szeroka / Wide serpentine (B1), 15:15. Serpentyna średnia / Med serpentine, 16:16. Serpentyna gęsta / Dense serpentine, 17:17. Muszelka łuskowa / Scallop wave, 18:18. Podwójna pętla / Double lobe, 19:19. Piórko gałązkowe / Feather stitch, 20:20. Jodełka schodkowa / Stepped chevron (B1), 21:21. Ząbki skośne piła / Angled saw (B1), 22:22. Grzebyk drobny / Fine comb, 23:23. Satynowy romb liść / Diamond satin (B1), 24:24. Satynowy romb gęsty / Diamond satin 4c, 25:25. Perełki satynowe / Pearl beads, 26:26. Klepsydra satynowa / Hourglass (C1), 27:27. Płomienie satynowe / Flame satin (C1), 28:28. Stożek satynowy / Taper satin, 29:29. Grecki klucz meander / Greek key 4c (C1), 30:30. Grecki klucz gęsty / Greek key 5c, 31:31. Bloki satynowe / Satin blocks (C1), 32:32. Szachownica / Checker step, 33:33. Krzyżyki / Cross stitch, 34:34. Strzałka ostra / Arrowhead, 35:35. Plaster miodu / Honeycomb]

// --- Aktywna litera bębna ---
active_letter = (Preset == "A1") ? "A" :
                (Preset == "B1") ? "B" :
                (Preset == "C1") ? "C" :
                (Preset == "D")  ? "D" : Custom_Letter;

// --- Profile ściegowe wzorowane w 100% na modelach cam_A, cam_B, cam_C, cam_D ---
function active_pos1(a) =
    (Preset == "A1") ? blind_hem(a, 3, 0.20) :
    (Preset == "B1") ? sine_wave(a, 3) * 0.90 :
    (Preset == "C1") ? trap_wave(a, 4, 0.45) * 0.90 :
    (Preset == "D")  ? tri_wave(a, 10) * 0.40 :
    get_stitch_by_id(Position_1, a);

function active_pos2(a) =
    (Preset == "A1") ? three_step_zigzag(a, 3) :
    (Preset == "B1") ? (tri_wave(a, 3) * 0.70 + tri_wave(a, 18) * 0.25) :
    (Preset == "C1") ? arrow_sharpen(a, 6, 0.50) * 0.90 :
    (Preset == "D")  ? blind_hem(a, 4, 0.15) :
    get_stitch_by_id(Position_2, a);

function active_pos3(a) =
    (Preset == "A1") ? trap_wave(a, 9, 0.28) * 0.95 :
    (Preset == "B1") ? diamond_satin(a, 18, 3) :
    (Preset == "C1") ? block_satin(a, 16, 4) :
    (Preset == "D")  ? sign(sine_wave(a, 6)) * 0.85 :
    get_stitch_by_id(Position_3, a);

function active_pos4(a) =
    (Preset == "A1") ? trap_wave(a, 9, 0.28) * 0.80 :
    (Preset == "B1") ? saw_wave(a, 6, 0.80) * 0.90 :
    (Preset == "C1") ? hourglass_satin(a, 18, 3) :
    (Preset == "D")  ? tri_wave(a, 18) * 0.30 :
    get_stitch_by_id(Position_4, a);

function active_pos5(a) =
    (Preset == "A1" || Preset == "B1" || Preset == "C1" || Preset == "D") ? trap_wave(a, 9, 0.28) * 0.95 :
    get_stitch_by_id(Position_5, a);

// --- Wywołanie generatora bryły bębna ---
cam_with_grooves(active_letter, [
    function(a) active_pos1(a),
    function(a) active_pos2(a),
    function(a) active_pos3(a),
    function(a) active_pos4(a),
    function(a) active_pos5(a)
]);

