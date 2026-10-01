# DeepMedChem plugin for Claude

Search public DeepMedChem chemical spaces for molecules similar to a structure you supply, directly from Claude.

The plugin contains no server code or credentials. It connects Claude to the remote MCP service at `https://mcp.deepmedchem.com/mcp`, which DeepMedChem operates, and adds a skill that tells Claude how to use it.

## What it does

- **catalog**: lists the available databases, their pricing and the guest limits.
- **similarity_search**: searches one SMILES against one database for up to 20 hits, using `morgan` (fingerprint), `shape` or `esp` (electrostatic) similarity.
- **render_results**: shows an earlier result again by its `result_id`.

In hosts that support MCP Apps, results appear as an interactive structure grid with CSV export and links to [CHEESE](https://cheese.deepmedchem.com).

Guest access needs no signup, and all guests share the same capacity. For larger searches, substructure queries or persistent work, use a DeepMedChem account with the [Python SDK](https://github.com/Deep-MedChem/deepmedchem-python).

## Install

```
/plugin marketplace add Deep-MedChem/deepmedchem-claude-plugin
/plugin install deepmedchem
```

Whether Claude can reach the remote server depends on your Claude workspace's connector policy.

## Limits

Similarity scores measure structural similarity. They are not predictions of biological activity or safety. Vendors determine availability and synthesis. Results are a bounded shortlist, not every match.

## Data and privacy

The plugin runs no code on your machine and installs nothing. It only declares the remote MCP server and a skill.

- What is sent: the SMILES you search, the chosen database, method and result count, plus a `result_id` when an earlier result is shown again. Nothing else from the conversation is sent.
- Where it goes: `https://mcp.deepmedchem.com`, operated by Deep MedChem, which forwards the search to the DeepMedChem API. No third party receives the query.
- No account or credentials are used, and the plugin never asks for an API key.
- Results are kept on the server for a short time so that `render_results` and the CSV export can return them, then discarded.
- Links in the results grid open `https://cheese.deepmedchem.com` (and vendor pages for product listings) in your browser only when you click them.

Privacy policy: https://cheese.deepmedchem.com/privacy-policy. Terms: https://cheese.deepmedchem.com/terms-and-conditions.

## Support

Email info@deepmedchem.com, or open an issue in this repository.

## License

MIT
