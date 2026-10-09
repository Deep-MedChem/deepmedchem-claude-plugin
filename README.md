# DeepMedChem plugin for Claude

Search public DeepMedChem chemical spaces for molecules similar to a structure you supply, directly from Claude.

The plugin contains no server code or credentials. It connects Claude to the remote MCP service at `https://mcp.deepmedchem.com/mcp`, which DeepMedChem operates, and adds a skill that tells Claude how to use it.

## What it does

- **catalog**: lists the available databases, their pricing and the guest limits.
- **similarity_search**: searches one SMILES against one database for up to 20 hits, using `morgan` (fingerprint), `shape` or `esp` (electrostatic) similarity.
- **render_results**: shows an earlier result again by its `result_id`.

In hosts that support MCP Apps, results appear as an interactive structure grid with CSV export and a link to the vendor's catalogue. Use the search-specific [CHEESE](https://cheese.deepmedchem.com) link returned with the result. A link containing `job=` opens the saved search results without submitting another search. Older server versions return a `run=0` link, which only prefills the query, database and method; choose Search to run that query. A general CHEESE homepage link does not identify saved results.

When the backend returns a vendor `catalog_id`, updated grids show it on the molecule card and include it in CSV exports. The platform `product_id` remains the API identity. Missing vendor IDs must not be inferred from internal hashes.

Guest access needs no signup, and all guests share the same capacity, so run one search at a time. A "busy" error means the shared capacity is in use; wait a moment and try again. For larger searches, substructure queries or persistent work, use a DeepMedChem account with the [Python SDK](https://github.com/Deep-MedChem/deepmedchem-python).

## Install

```
/plugin marketplace add Deep-MedChem/deepmedchem-claude-plugin
/plugin install deepmedchem
```

Whether Claude can reach the remote server depends on your Claude workspace's connector policy.

### ChatGPT

The same plugin is packaged for ChatGPT: `plugin.json`, `mcp.json`, `skills/` and `assets/` at the repository root. Download the ZIP from the latest release, or build it with `scripts/build-openai-zip.sh`. Submission details are in [OPENAI_SUBMISSION.md](OPENAI_SUBMISSION.md).

## Limits

Similarity scores measure structural similarity. They are not predictions of biological activity or safety. Vendors determine availability and synthesis. Prices are list prices in USD for the default 1 mg amount shipped to the US, as reported by the catalogue; many make-on-demand products share the same price tier. Results are a bounded shortlist, not every match.

## Data and privacy

The plugin runs no code on your machine and installs nothing. It only declares the remote MCP server and a skill.

- What is sent: the SMILES you search, the chosen database, method and result count, plus a `result_id` when an earlier result is shown again. Nothing else from the conversation is sent.
- Where it goes: `https://mcp.deepmedchem.com`, operated by Deep MedChem, which forwards the search to DeepMedChem backend services. Hosting and data handling are covered by the privacy policy below.
- Guest callers need no customer account or API key. The server uses a DeepMedChem-held backend credential; it is not included in this plugin or sent to the client. The plugin never asks users to paste API keys into a conversation.
- Widget snapshots are kept in bounded server memory so that `render_results` and the CSV export can return them. They can be evicted or lost when the server restarts, and old widget/CSV links can stop working.
- Searches routed through the CHEESE jobs API also create a stored CHEESE job containing the query and results. That storage is separate from the widget's memory snapshot; restarting MCP does not delete the CHEESE job. Its handling is subject to the CHEESE privacy policy.
- Links in the results grid open the vendor's general catalogue page or the returned CHEESE search link in your browser only when you click them.

Privacy policy: https://cheese.deepmedchem.com/privacy-policy. Terms: https://cheese.deepmedchem.com/terms-and-conditions.

## Support

Email info@deepmedchem.com, or open an issue in this repository.

## License

MIT
