// Test siatki generowanej w przeglądarce (index.html) bez przeglądarki:
//   node tools/test_browser_mesh.js out_dir
// Wycina z index.html katalog ściegów + funkcje fal + generateWatertightDrumGeometry, buduje bębny
// dla presetów i dla każdego ściegu na wszystkich 5 pozycjach i zapisuje binarne STL do sprawdzenia
// (tools/verify_drums.py --browser out_dir).
'use strict';
const fs = require('fs');
const path = require('path');

const html = fs.readFileSync(path.join(__dirname, '..', 'index.html'), 'utf8');
const cut = (from, to) => {
  const a = html.indexOf(from), b = html.indexOf(to, a);
  if (a < 0 || b < 0) throw new Error('nie znaleziono: ' + from);
  return html.slice(a, b);
};
const catalog = cut('    const STITCHES = [', '    // Stan bieżący');
const presets = cut('    const PRESETS = {', '    // --- Inicjalizacja aplikacji ---');
const geomSrc = cut('    function generateWatertightDrumGeometry(slots) {', '    // ===');

// minimalny THREE: tylko to, czego używa generator
const THREE = {
  BufferAttribute: function (arr, n) { this.array = arr; this.itemSize = n; },
  BufferGeometry: function () {
    this.attributes = {};
    this.setAttribute = (k, v) => { this.attributes[k] = v; };
    this.setIndex = (ix) => { this.index = ix; };
    this.computeVertexNormals = () => {};
  },
};
const api = new Function('THREE', catalog + presets + geomSrc + '\nreturn { STITCHES, PRESETS, generateWatertightDrumGeometry };')(THREE);

function writeStl(geom, file) {
  const p = geom.attributes.position.array, ix = geom.index, n = ix.length / 3;
  const buf = Buffer.alloc(84 + n * 50);
  buf.write('browser mesh test', 0);
  buf.writeUInt32LE(n, 80);
  let o = 84;
  for (let t = 0; t < n; t++) {
    o += 12; // normalna 0 (trimesh liczy sama)
    for (let k = 0; k < 3; k++) {
      const v = ix[3 * t + k];
      buf.writeFloatLE(p[3 * v], o); buf.writeFloatLE(p[3 * v + 1], o + 4); buf.writeFloatLE(p[3 * v + 2], o + 8);
      o += 12;
    }
    o += 2;
  }
  fs.writeFileSync(file, buf);
}

const out = process.argv[2] || 'browser_test';
fs.mkdirSync(out, { recursive: true });
let count = 0;
for (const [name, p] of Object.entries(api.PRESETS)) {
  writeStl(api.generateWatertightDrumGeometry(p.slots), path.join(out, `preset_${name}.stl`)); count++;
}
for (const s of api.STITCHES) {
  writeStl(api.generateWatertightDrumGeometry([s.id, s.id, s.id, s.id, s.id]), path.join(out, `stitch_${String(s.id).padStart(2, '0')}.stl`)); count++;
}
console.log(`${count} STL -> ${out}`);
