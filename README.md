**Requires:** Python 3.10+ and Node.js 18+ (with npm).

## Quick start

The app needs **two terminals running at the same time**: one for the backend,
one for the frontend. Unzip the project first, then open both terminals in the
unzipped project folder (the one containing `app.py`).

### Step 1: start the backend (terminal 1)

Paste the block for your system. Leave this terminal open; the backend must keep running.

**macOS / Linux**

```bash
python3 -m venv venv
venv/bin/python -m pip install -r requirements.txt
venv/bin/python app.py
```

**Windows (PowerShell)**

```powershell
python -m venv venv
venv\Scripts\python -m pip install -r requirements.txt
venv\Scripts\python app.py
```

Wait until it says it is running on http://127.0.0.1:5000.

### Step 2: start the frontend (terminal 2)

Open a **second** terminal in the same project folder and paste this (same on every system):

```bash
cd frontend
npm install
npm run dev
```

Open the URL it prints, usually **http://localhost:5173**, and click **Start Survey**
(top right). With the default setup this opens the **playground** (see below).

Keep both terminals open while you use it. To stop, press `Ctrl+C` in each.

### Running it again later

The installs only need to happen once. Next time, from the project folder:

- Terminal 1: `venv/bin/python app.py` (Windows: `venv\Scripts\python app.py`)
- Terminal 2: `cd frontend` then `npm run dev`

## Playground and survey setups

What happens after you click **Start Survey** depends on the **setup**. A setup
is a folder of JSON configs. With no setup chosen, the app uses
`survey_data/current_setup/`, which is the **playground**.

### Playground (default)

Free exploration with no tasks and no questionnaire:

1. Click **Start Survey**. A "Playground" welcome screen appears; click **Open Playground →**.
2. Two portfolio 3D frontiers load: equity heavy and fixed income/cash heavy,
   plus the benchmark.
3. Everything is unlocked. Toggle frontiers in the **Frontiers** panel, switch
   charts and explore as long as you like. **Chart Guide** explains the interactions.

### Survey setups

| Setup | Data | Question files |
| --- | --- | --- |
| `expert_inteviews` | Expert interviews: portfolio 3D and 6D, single- and multi-frontier (20 tasks + 4 rating questions + comment box) | `questions_config.json` (default, no `file=` needed) |
| `single_front_portfolio` | Portfolio, one frontier at a time | `single_portfolio_dashboard_then_table.json`, `single_portfolio_table_then_dashboard.json` |
| `multi_front_portfolio` | Portfolio, comparing frontiers | `multi_portfolio_dashboard_then_table.json`, `multi_portfolio_table_then_dashboard.json` |
| `single_front_diet` | Diet, one frontier at a time | `single_diet_dashboard_then_table.json`, `single_diet_table_then_dashboard.json` |
| `multi_front_diet` | Diet, comparing frontiers | `multi_diet_dashboard_then_table.json`, `multi_diet_table_then_dashboard.json` |

The `..._dashboard_then_table` and `..._table_then_dashboard` files contain the
same tasks in a different order (which views come first).

To run one, put the setup and question file in the URL, then click **Start Survey**:

```text
http://localhost:5173/?setup=single_front_portfolio&file=single_portfolio_dashboard_then_table.json
```

Each run goes intro → tutorial → tasks → short questionnaire. Responses are
written to `survey_data/responses/<setup>/responses_<sessionId>.json` on the
machine running the backend only.

### What a setup folder contains

- `intro_config.json`: the welcome screen (title, body, button label).
- `tutorial_config.json`: the dataset to load (`frontiers` + `benchmark`) and
  the tutorial steps.
- `questions_config.json` (or another name passed via `file=`): the tasks and the
  post-task questionnaire. See `survey_data/example_questions.json` for one
  example of each task type. The playground has no questions file.
