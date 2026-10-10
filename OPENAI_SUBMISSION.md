# OpenAI plugin submission material

Paste these into https://platform.openai.com/plugins. Upload the ZIP attached to the
latest GitHub release of this repository, or build it from the repository root with
`zip -qrX dist/deepmedchem-openai-plugin.zip plugin.json mcp.json skills assets -x '.*'`.

The OpenAI package uses `plugin.json`, `mcp.json`, `skills/` and `assets/`. The Claude
plugin uses `.claude-plugin/` and `.mcp.json`. Both share the same skill.

## Before submitting

1. Production serves `openai/widgetDomain` on the results resource. Refresh the ChatGPT connection and check the widget-domain
   warning is gone.
2. Enter the domain-verification token from the portal's MCP connection step in the
   production MCP server's OpenAI challenge setting and deploy. Then open
   https://mcp.deepmedchem.com/.well-known/openai-apps-challenge in a browser: the page
   must show only the token.

## Listing

| Field | Value |
|---|---|
| Display name (≤30) | DeepMedChem |
| Short description (≤30) | Molecular similarity search |
| Long description | from `plugin.json` `longDescription` |
| Icon | `assets/icon.png` (256×256 PNG) |
| Website URL | https://deepmedchem.com |
| Support URL | https://github.com/Deep-MedChem/plugin/issues |
| Privacy policy URL | https://cheese.deepmedchem.com/privacy-policy |
| Terms of service URL | https://cheese.deepmedchem.com/terms-and-conditions |
| MCP server | `https://mcp.deepmedchem.com/mcp`, authentication None |

Reviewer access: public, read-only endpoint. No account, login or test credentials.

## Positive test cases

1. **List databases.** Prompt: "Which chemical space databases can I search with
   DeepMedChem?" Tool: `catalog`. Expected: a list including Enamine REAL v5a,
   Freedom Space 5 and Synple eXplore, with the 20-result guest limit.
2. **Fingerprint search.** Prompt: "Find 20 molecules similar to aspirin, SMILES
   CC(=O)Oc1ccccc1C(=O)O, in Enamine REAL." Tools: `catalog`, `similarity_search`
   (method `morgan`). Expected: a structure grid of 20 hits ranked by ECFP4
   Tanimoto, each with a product ID and price.
3. **Shape search.** Prompt: "Search Enamine REAL for shape-similar analogues of
   c1ccc(CCNc2ncnc3ccccc23)cc1." Tool: `similarity_search` (method `shape`).
   Expected: grid of up to 20 hits ranked by shape cosine.
4. **Show an earlier result again.** After case 2, prompt: "Show me those aspirin
   results again." Tool: `render_results` with the earlier `result_id`. Expected: the
   same grid, same structures and scores, without a new search.
5. **CSV export.** In the grid from case 2, click the CSV download. Expected: a CSV
   with the same SMILES, platform product IDs, scores and prices as the grid,
   plus the returned vendor catalog IDs when available. Missing IDs remain blank.
6. **Open saved CHEESE results.** In a fresh grid from the updated production
   server, click its CHEESE link. Expected: a `job=` URL opens the existing
   results, without another Search action or a new paid search. Refresh that
   page and check the same stored results remain visible. A `run=0` link means
   the older server is still being served and this release is not ready.

Complete these checks in both ChatGPT and Claude before submitting. Verify that
the server's CHEESE API credential is accepted and its service-account allowance
supports the published guest capacity. Never upload that credential with either
plugin package.

## Negative test cases

1. **Name without a structure.** Prompt: "Find molecules similar to cetirizine."
   Expected: the assistant does not invent a structure. It asks for a SMILES, or uses
   a reliable source it has, and says DeepMedChem itself does not resolve names.
2. **Unsupported constraint.** Prompt: "Find analogues of CC(=O)Oc1ccccc1C(=O)O with
   logP below 1 and price under $50." Expected: the assistant explains that property
   and price filters are not supported before searching, and does not present an
   unfiltered similarity search as satisfying the constraint.
3. **Beyond the guest cap.** Prompt: "Give me 500 molecules similar to aspirin."
   Expected: the assistant explains the 20-result guest limit, returns at most 20,
   and does not loop searches to get around it.

## Release notes

First public release. Similarity search over public DeepMedChem chemical spaces by
Morgan fingerprint, 3D shape or electrostatic similarity, one SMILES and one
database per search, up to 20 hits. Results render as an interactive structure grid
with CSV export. No account required.

## Still needed

- Video walkthrough of the cases above, at a reviewer-accessible URL.
- Organization-level access: a verified company organization, and Owner or Apps
  Management Write for the submitter.
