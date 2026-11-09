/* Минимальный QR-энкодер (byte mode, уровень коррекции L, версии 1–20).
   Уровень L и версии до 20 нужны для длинного EMV-payload с кириллицей (~300 байт UTF-8).
   qrMatrix(text) -> { n, bits: Uint8Array(n*n) } — реально сканируемый код. */

const EXP = new Array(256), LOG = new Array(256);
(() => { let x = 1; for (let i = 0; i < 255; i++) { EXP[i] = x; LOG[x] = i; x <<= 1; if (x & 0x100) x ^= 0x11d; } EXP[255] = 1; })();
const mul = (a, b) => (a === 0 || b === 0) ? 0 : EXP[(LOG[a] + LOG[b]) % 255];

function rsGen(n) {
  let p = [1];
  for (let i = 0; i < n; i++) {
    const q = [1, EXP[i]], r = new Array(p.length + 1).fill(0);
    for (let a = 0; a < p.length; a++) for (let b = 0; b < 2; b++) r[a + b] ^= mul(p[a], q[b]);
    p = r;
  }
  return p;
}

function rsEc(data, ecLen) {
  const gen = rsGen(ecLen), res = new Array(data.length + ecLen).fill(0);
  data.forEach((d, i) => { res[i] = d; });
  for (let i = 0; i < data.length; i++) {
    const f = res[i];
    if (!f) continue;
    for (let j = 0; j < gen.length; j++) res[i + j] ^= mul(gen[j], f);
  }
  return res.slice(data.length);
}

/* уровень L: ec-кодовых слов на блок + группы [кол-во блоков, данных в блоке] */
const SPEC = {
  1: { ec: 7, groups: [[1, 19]] },
  2: { ec: 10, groups: [[1, 34]] },
  3: { ec: 15, groups: [[1, 55]] },
  4: { ec: 20, groups: [[1, 80]] },
  5: { ec: 26, groups: [[1, 108]] },
  6: { ec: 18, groups: [[2, 68]] },
  7: { ec: 20, groups: [[2, 78]] },
  8: { ec: 24, groups: [[2, 97]] },
  9: { ec: 30, groups: [[2, 116]] },
  10: { ec: 18, groups: [[2, 68], [2, 69]] },
  11: { ec: 20, groups: [[4, 81]] },
  12: { ec: 24, groups: [[2, 92], [2, 93]] },
  13: { ec: 26, groups: [[4, 107]] },
  14: { ec: 30, groups: [[3, 115], [1, 116]] },
  15: { ec: 22, groups: [[5, 87], [1, 88]] },
  16: { ec: 24, groups: [[5, 98], [1, 99]] },
  17: { ec: 28, groups: [[1, 107], [5, 108]] },
  18: { ec: 30, groups: [[5, 120], [1, 121]] },
  19: { ec: 28, groups: [[3, 113], [4, 114]] },
  20: { ec: 28, groups: [[3, 107], [5, 108]] }
};
const ALIGN = {
  1: [], 2: [6, 18], 3: [6, 22], 4: [6, 26], 5: [6, 30], 6: [6, 34],
  7: [6, 22, 38], 8: [6, 24, 42], 9: [6, 26, 46], 10: [6, 28, 50],
  11: [6, 30, 54], 12: [6, 32, 58], 13: [6, 34, 62], 14: [6, 26, 46, 66],
  15: [6, 26, 48, 70], 16: [6, 26, 50, 74], 17: [6, 30, 54, 78], 18: [6, 30, 56, 82],
  19: [6, 30, 58, 86], 20: [6, 34, 62, 90]
};
const MAXV = 20;

const dataCap = (v) => SPEC[v].groups.reduce((a, g) => a + g[0] * g[1], 0);

function utf8(text) {
  const out = [];
  const s = String(text);
  for (let i = 0; i < s.length; i++) {
    const cp = s.codePointAt(i);
    if (cp > 0xffff) i++;
    if (cp < 0x80) out.push(cp);
    else if (cp < 0x800) out.push(0xc0 | (cp >> 6), 0x80 | (cp & 0x3f));
    else if (cp < 0x10000) out.push(0xe0 | (cp >> 12), 0x80 | ((cp >> 6) & 0x3f), 0x80 | (cp & 0x3f));
    else out.push(0xf0 | (cp >> 18), 0x80 | ((cp >> 12) & 0x3f), 0x80 | ((cp >> 6) & 0x3f), 0x80 | (cp & 0x3f));
  }
  return out;
}

function bch(v, gpoly, bits) {
  let d = v << (bits - 1);
  while (Math.floor(Math.log2(d)) >= bits - 1) d ^= gpoly << (Math.floor(Math.log2(d)) - (bits - 1));
  return d;
}

function formatBits(mask) {
  const data = (1 << 3) | mask;                     // 01 = уровень L
  const raw = (data << 10) | bch(data, 0x537, 11);
  return (raw ^ 0x5412) & 0x7fff;
}

function versionBits(v) {
  return (v << 12) | bch(v, 0x1f25, 13);
}

const MASKS = [
  (r, c) => (r + c) % 2 === 0,
  (r) => r % 2 === 0,
  (r, c) => c % 3 === 0,
  (r, c) => (r + c) % 3 === 0,
  (r, c) => (Math.floor(r / 2) + Math.floor(c / 3)) % 2 === 0,
  (r, c) => ((r * c) % 2) + ((r * c) % 3) === 0,
  (r, c) => (((r * c) % 2) + ((r * c) % 3)) % 2 === 0,
  (r, c) => (((r + c) % 2) + ((r * c) % 3)) % 2 === 0
];

export function qrMatrix(text) {
  const bytes = utf8(text);
  let v = 0;
  for (let i = 1; i <= MAXV; i++) {
    const lenBits = i >= 10 ? 16 : 8;
    if (dataCap(i) * 8 >= 4 + lenBits + bytes.length * 8) { v = i; break; }
  }
  if (!v) throw new Error("payload too long");

  /* поток бит */
  const bits = [];
  const push = (val, len) => { for (let i = len - 1; i >= 0; i--) bits.push((val >> i) & 1); };
  push(4, 4);
  push(bytes.length, v >= 10 ? 16 : 8);
  bytes.forEach((b) => push(b, 8));
  const capBits = dataCap(v) * 8;
  for (let i = 0; i < 4 && bits.length < capBits; i++) bits.push(0);
  while (bits.length % 8) bits.push(0);
  const words = [];
  for (let i = 0; i < bits.length; i += 8) words.push(bits.slice(i, i + 8).reduce((a, b) => (a << 1) | b, 0));
  const PAD = [0xec, 0x11];
  let padI = 0;
  while (words.length < dataCap(v)) words.push(PAD[padI++ % 2]);

  /* блоки + коррекция */
  const blocks = [];
  let p = 0;
  SPEC[v].groups.forEach(([count, len]) => {
    for (let i = 0; i < count; i++) { blocks.push(words.slice(p, p + len)); p += len; }
  });
  const ecs = blocks.map((b) => rsEc(b, SPEC[v].ec));
  const maxData = Math.max(...blocks.map((b) => b.length));
  const stream = [];
  for (let i = 0; i < maxData; i++) blocks.forEach((b) => { if (i < b.length) stream.push(b[i]); });
  for (let i = 0; i < SPEC[v].ec; i++) ecs.forEach((e) => stream.push(e[i]));

  /* матрица */
  const n = 17 + 4 * v;
  const m = Array.from({ length: n }, () => new Array(n).fill(0));
  const fn = Array.from({ length: n }, () => new Array(n).fill(false));
  const set = (r, c, val) => { if (r >= 0 && r < n && c >= 0 && c < n) { m[r][c] = val ? 1 : 0; fn[r][c] = true; } };

  const finder = (R, C) => {
    for (let r = -1; r <= 7; r++) for (let c = -1; c <= 7; c++) {
      const ring = Math.max(Math.abs(r - 3), Math.abs(c - 3));
      set(R + r, C + c, r >= 0 && r <= 6 && c >= 0 && c <= 6 && (ring === 3 || ring <= 1));
    }
  };
  finder(0, 0); finder(0, n - 7); finder(n - 7, 0);

  for (let i = 8; i < n - 8; i++) { set(6, i, i % 2 === 0); set(i, 6, i % 2 === 0); }

  ALIGN[v].forEach((r) => ALIGN[v].forEach((c) => {
    if ((r < 9 && c < 9) || (r < 9 && c > n - 10) || (r > n - 10 && c < 9)) return;
    for (let dr = -2; dr <= 2; dr++) for (let dc = -2; dc <= 2; dc++) {
      const ring = Math.max(Math.abs(dr), Math.abs(dc));
      set(r + dr, c + dc, ring !== 1);
    }
  }));

  set(n - 8, 8, 1);                                   // dark module
  for (let i = 0; i < 9; i++) { if (i === 6) continue; set(8, i, 0); set(i, 8, 0); }
  for (let i = 0; i < 8; i++) { set(8, n - 1 - i, 0); set(n - 1 - i, 8, 0); }

  if (v >= 7) {
    const vb = versionBits(v);
    for (let i = 0; i < 18; i++) {
      const bit = (vb >> i) & 1;
      set(Math.floor(i / 3), n - 11 + (i % 3), bit);
      set(n - 11 + (i % 3), Math.floor(i / 3), bit);
    }
  }

  /* данные зигзагом */
  const bitAt = (i) => (stream[i >> 3] >> (7 - (i & 7))) & 1;
  const total = stream.length * 8;
  let idx = 0, up = true;
  for (let col = n - 1; col > 0; col -= 2) {
    if (col === 6) col--;
    for (let k = 0; k < n; k++) {
      const row = up ? n - 1 - k : k;
      for (const c of [col, col - 1]) {
        if (fn[row][c]) continue;
        m[row][c] = idx < total ? bitAt(idx) : 0;
        idx++;
      }
    }
    up = !up;
  }

  /* маска: берём с наименьшим штрафом по правилам 1 и 4 */
  let best = 0, bestScore = Infinity, bestGrid = null;
  for (let mask = 0; mask < 8; mask++) {
    const g = m.map((row, r) => row.map((val, c) => (fn[r][c] ? val : (MASKS[mask](r, c) ? val ^ 1 : val))));
    let score = 0, dark = 0;
    for (let r = 0; r < n; r++) {
      let runR = 1, runC = 1;
      for (let c = 0; c < n; c++) {
        dark += g[r][c];
        if (c && g[r][c] === g[r][c - 1]) { runR++; if (runR === 5) score += 3; else if (runR > 5) score++; } else runR = 1;
        if (c && g[c][r] === g[c - 1][r]) { runC++; if (runC === 5) score += 3; else if (runC > 5) score++; } else runC = 1;
      }
    }
    score += Math.floor(Math.abs((dark * 100) / (n * n) - 50) / 5) * 10;
    if (score < bestScore) { bestScore = score; best = mask; bestGrid = g; }
  }

  const fb = formatBits(best);
  const put = (r, c, val) => { bestGrid[r][c] = val; };
  for (let i = 0; i < 15; i++) {
    const bit = (fb >> i) & 1;
    if (i < 6) put(i, 8, bit);
    else if (i < 8) put(i + 1, 8, bit);
    else if (i === 8) put(8, 7, bit);
    else put(8, 14 - i, bit);
    if (i < 8) put(8, n - 1 - i, bit);
    else put(n - 15 + i, 8, bit);
  }
  put(n - 8, 8, 1);

  const out = new Uint8Array(n * n);
  for (let r = 0; r < n; r++) for (let c = 0; c < n; c++) out[r * n + c] = bestGrid[r][c];
  return { n: n, bits: out };
}

/* SVG-строка кода: дешевле, чем n*n элементов в DOM */
export function qrSvg(text, quiet) {
  const g = qrMatrix(text);
  const q = quiet == null ? 2 : quiet;
  const size = g.n + q * 2;
  let d = "";
  for (let r = 0; r < g.n; r++) {
    let c = 0;
    while (c < g.n) {
      if (!g.bits[r * g.n + c]) { c++; continue; }
      let len = 0;
      while (c + len < g.n && g.bits[r * g.n + c + len]) len++;
      d += "M" + (c + q) + " " + (r + q) + "h" + len + "v1h-" + len + "z";
      c += len;
    }
  }
  return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ' + size + " " + size + '" shape-rendering="crispEdges"><rect width="' + size + '" height="' + size + '" fill="#fff"/><path d="' + d + '" fill="#16181A"/></svg>';
}
