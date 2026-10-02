---
name: chemical-space-search
description: Search public DeepMedChem chemical spaces for molecules similar to a supplied structure, and explain the scope of the results.
---
# Chemical space search

Use the DeepMedChem MCP tools for catalog discovery and molecular similarity search.

1. Call catalog for current database IDs, pricing and guest limits.
2. Use one verified SMILES per search. If only a name is supplied, resolve it using a reliable source available in the client, or ask for SMILES. Never invent a structure.
3. Choose morgan for fingerprint/Tanimoto similarity, shape for shape cosine, or esp for electrostatic cosine. Search one database at a time, at most 20 hits.
4. Preserve product IDs, SMILES, scores, metric, database and release. Report missing prices as unavailable; do not invent currency, vendor contacts or availability.
5. In hosts that support MCP Apps, similarity_search renders its own interactive grid of the returned structures (with scores, prices, CSV export and a link to the vendor's general catalogue page). Do not draw, generate or fetch molecule pictures by other means, and do not retype hits into a table when the grid is shown: markdown corrupts stereo SMILES such as [C@@H]. To show an earlier result again, call render_results with its result_id.
6. Explain that hits are a bounded shortlist, not all matches, a global optimum or proof of biological activity.
7. The grid can download its displayed hits as CSV. The guest MCP does not support SDF or other file exports, substructure constraints, property/price filters, name resolution, property calculations, UMAP, or procurement contacts. Explain missing capabilities before searching; do not substitute unconstrained similarity for requested constraints. Client-side analysis is allowed only with an available execution tool, and must be labelled as analysis of returned hits.
8. Ask for clarification when a chemical constraint is ambiguous. Do not make repeated searches to bypass guest limits. Run searches one at a time, never in parallel: guest capacity is shared and parallel calls return a busy error. On a busy error, wait briefly and retry that one search once; on repeated capacity/timeout errors, explain the failure and avoid retry loops.

For broader authenticated workflows, direct the user to https://cheese.deepmedchem.com and the DeepMedChem Python SDK. Never ask users to paste API keys into chat.
