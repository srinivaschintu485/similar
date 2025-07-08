def build_prompt(db_schema, sql_prompt):
    return f"""Below is an instruction that describes a task, paired with an input and expected output.
### Instruction:
Company database: {db_schema}

### Input:
SQL Prompt: {sql_prompt}

### Response:"""

test_cases = [
    ("CREATE TABLE employees (id INT, name TEXT, salary REAL);", "What is the total number of employees?"),
    ("CREATE TABLE employees (id INT, name TEXT, salary REAL);", "Get the names of employees who earn more than 50000."),
    ("CREATE TABLE employees (id INT, name TEXT, salary REAL, department TEXT);", "What is the average salary per department?"),
    ("CREATE TABLE employees (id INT, name TEXT, salary REAL);", "Who is the highest-paid employee?"),
    ("CREATE TABLE employees (id INT, name TEXT, department TEXT);", "List departments that have more than 5 employees."),
]

for db_schema, prompt in test_cases:
    full_prompt = build_prompt(db_schema, prompt)
    inputs = tokenizer(full_prompt, return_tensors="pt").to(model.device)
    outputs = model.generate(
        input_ids=inputs["input_ids"],
        attention_mask=inputs["attention_mask"],
        max_new_tokens=256,
        temperature=0.7,
        do_sample=True,
        top_p=0.9,
        pad_token_id=tokenizer.eos_token_id,
    )
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    print(f"❓ Prompt: {prompt}\n📄 Response:\n{response.split('### Response:')[-1].split('<|endoftext|>')[0].strip()}\n{'-'*80}")
Drop files to upload them to session storage.
Disk
61.72 GB available

[ ]
ning) includes tools like SFTTrainer for supervised fine-tuning of LLMs. peft (Parameter-Efficient Fine-Tuning) enables LoRA and other lightweight fine-tuning methods. accelerate simplifies multi-GPU and mixed-precision training setups. Finally, bitsandbytes allows models to be quantized to 8-bit or 4-bit, reducing memory usage significantly and enabling model training or inference on consumer GPUs like T4 or 3060. This combined setup is ideal for training powerful LLMs even on limited hardware.

[2]
24s
from datasets import Dataset
from transformers import AutoTokenizer
import json
import pandas as pd
from datasets import Dataset
splits = {'train': 'synthetic_text_to_sql_train.snappy.parquet', 'test': 'synthetic_text_to_sql_test.snappy.parquet'}
df = pd.read_parquet("hf://datasets/gretelai/synthetic_text_to_sql/" + splits["train"])
df.isnull().sum()
dataset = Dataset.from_pandas(df)

# Define Alpaca-style SQL prompt template
alpaca_prompt = """Below is an instruction that describes a task, paired with an input and expected output.
### Instruction:
Company database: {company_database}

### Input:
SQL Prompt: {prompt}

### Response:
SQL: {sql}
Explanation: {explanation}<|endoftext|>"""

# Format each example into a single text string
def format_prompt(example):
    return alpaca_prompt.format(
        company_database=example['sql_context'],
        prompt=example['sql_prompt'],
        sql=example['sql'],
        explanation=example['sql_explanation']
    )

# Format your dataset from pandas dataframe `df`
formatted_data = [format_prompt(row) for _, row in df.iterrows()]
dataset = Dataset.from_dict({"text": formatted_data})

# Load tokenizer
tokenizer = AutoTokenizer.from_pretrained("Salesforce/codegen-350M-mono")

# Ensure pad token exists
if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token

# Done! Now pass this dataset to SFTTrainer like this:
# trainer = SFTTrainer(
#     model=model,
#     tokenizer=tokenizer,
#     train_dataset=dataset,
#     dataset_text_field="text",
#     ...
# )

# Optional: preview first row
print(dataset[0]['text'])
dataset = dataset.select(range(200))
/usr/local/lib/python3.11/dist-packages/huggingface_hub/utils/_auth.py:94: UserWarning: 
The secret `HF_TOKEN` does not exist in your Colab secrets.
To authenticate with the Hugging Face Hub, create a token in your settings tab (https://huggingface.co/settings/tokens), set it as secret in your Google Colab and restart your session.
You will be able to reuse this secret in all of your notebooks.
Please note that authentication is recommended but still optional to access public models or datasets.
  warnings.warn(
Below is an instruction that describes a task, paired with an input and expected output.
### Instruction:
Company database: CREATE TABLE salesperson (salesperson_id INT, name TEXT, region TEXT); INSERT INTO salesperson (salesperson_id, name, region) VALUES (1, 'John Doe', 'North'), (2, 'Jane Smith', 'South'); CREATE TABLE timber_sales (sales_id INT, salesperson_id INT, volume REAL, sale_date DATE); INSERT INTO timber_sales (sales_id, salesperson_id, volume, sale_date) VALUES (1, 1, 120, '2021-01-01'), (2, 1, 150, '2021-02-01'), (3, 2, 180, '2021-01-01');

### Input:
SQL Prompt: What is the total volume of timber sold by each salesperson, sorted by salesperson?

### Response:
SQL: SELECT salesperson_id, name, SUM(volume) as total_volume FROM timber_sales JOIN salesperson ON timber_sales.salesperson_id = salesperson.salesperson_id GROUP BY salesperson_id, name ORDER BY total_volume DESC;
Explanation: Joins timber_sales and salesperson tables, groups sales by salesperson, calculates total volume sold by each salesperson, and orders the results by total volume in descending order.<|endoftext|>

[1]
10s
# For GPU check
import torch
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'None'}")
CUDA available: True
GPU: Tesla T4

[3]
29s
from unsloth import FastLanguageModel
import torch

model_name = "unsloth/Phi-3-mini-4k-instruct-bnb-4bit"

max_seq_length = 2048  # Choose sequence length
dtype = None  # Auto detection

# Load model and tokenizer
model, tokenizer = FastLanguageModel.from_pretrained(
    model_name=model_name,
    max_seq_length=max_seq_length,
    dtype=dtype,
    load_in_4bit=True,
)
/tmp/ipython-input-3-4282502808.py:1: UserWarning: WARNING: Unsloth should be imported before transformers to ensure all optimizations are applied. Your code may run slower or encounter memory issues without these optimizations.

Please restructure your imports with 'import unsloth' at the top of your file.
  from unsloth import FastLanguageModel
🦥 Unsloth: Will patch your computer to enable 2x faster free finetuning.
🦥 Unsloth Zoo will now patch everything to make training faster!
==((====))==  Unsloth 2025.6.12: Fast Mistral patching. Transformers: 4.53.0.
   \\   /|    Tesla T4. Num GPUs = 1. Max memory: 14.741 GB. Platform: Linux.
O^O/ \_/ \    Torch: 2.7.1+cu126. CUDA: 7.5. CUDA Toolkit: 12.6. Triton: 3.3.1
\        /    Bfloat16 = FALSE. FA [Xformers = 0.0.30. FA2 = False]
 "-____-"     Free license: http://github.com/unslothai/unsloth
Unsloth: Fast downloading is enabled - ignore downloading bars which are red colored!

[ ]
# from datasets import Dataset

# def format_prompt(example):
#     return f"### Input: {example['input']}\n### Output: {json.dumps(example['output'])}<|endoftext|>"

# formatted_data = [format_prompt(item) for item in file]
# dataset = Dataset.from_dict({"text": formatted_data})

[4]
7s
# Add LoRA adapters
model = FastLanguageModel.get_peft_model(
    model,
    r=64,  # LoRA rank - higher = more capacity, more memory
    target_modules=[
        "q_proj", "k_proj", "v_proj", "o_proj",
        "gate_proj", "up_proj", "down_proj",
    ],
    lora_alpha=128,  # LoRA scaling factor (usually 2x rank)
    lora_dropout=0,  # Supports any, but = 0 is optimized
    bias="none",     # Supports any, but = "none" is optimized
    use_gradient_checkpointing="unsloth",  # Unsloth's optimized version
    random_state=3407,
    use_rslora=False,  # Rank stabilized LoRA
    loftq_config=None, # LoftQ
)
Unsloth 2025.6.12 patched 32 layers with 32 QKV layers, 32 O layers and 32 MLP layers.

[5]
0s
from trl import SFTTrainer
from transformers import TrainingArguments

# Training arguments optimized for Unsloth
trainer = SFTTrainer(
    model=model,
    tokenizer=tokenizer,
    train_dataset=dataset,
    dataset_text_field="text",
    max_seq_length=max_seq_length,
    dataset_num_proc=2,
    args=TrainingArguments(
        per_device_train_batch_size=2,
        gradient_accumulation_steps=4,  # Effective batch size = 8
        warmup_steps=10,
        num_train_epochs=3,
        learning_rate=2e-4,
        fp16=not torch.cuda.is_bf16_supported(),
        bf16=torch.cuda.is_bf16_supported(),
        logging_steps=25,
        optim="adamw_8bit",
        weight_decay=0.01,
        lr_scheduler_type="linear",
        seed=3407,
        output_dir="outputs",
        save_strategy="epoch",
        save_total_limit=2,
        dataloader_pin_memory=False,
        report_to="none", # Disable Weights & Biases logging
    ),
)


[6]
6m
# Train the model
trainer_stats = trainer.train()


[7]
15s
# If using PEFT (LoRA adapter)
from peft import PeftModel

# Save and push
model.save_pretrained("mymodel")
tokenizer.save_pretrained("mymodel")
('mymodel/tokenizer_config.json',
 'mymodel/special_tokens_map.json',
 'mymodel/chat_template.jinja',
 'mymodel/tokenizer.model',
 'mymodel/added_tokens.json',
 'mymodel/tokenizer.json')

[9]
5s
import torch

# Enable Unsloth 2x faster inference
from unsloth import FastLanguageModel
FastLanguageModel.for_inference(model)

# ---- 1. Build prompt just like during training ----
def build_prompt(company_db, sql_prompt):
    return f"""Below is an instruction that describes a task, paired with an input and expected output.
### Instruction:
Company database: {company_db}

### Input:
SQL Prompt: {sql_prompt}

### Response:"""

# ---- 2. Define your question ----
company_database = "CREATE TABLE employees (id INT, name TEXT, salary REAL, department TEXT);"
question = "What is the average salary per department?"

# ---- 3. Format the full prompt ----
prompt = build_prompt(company_database, question)

# ---- 4. Tokenize input prompt ----
inputs = tokenizer(prompt, return_tensors="pt").to(model.device)

# ---- 5. Generate response ----
with torch.no_grad():
    outputs = model.generate(
        input_ids=inputs["input_ids"],
        attention_mask=inputs["attention_mask"],
        max_new_tokens=256,
        temperature=0.7,
        do_sample=True,
        top_p=0.9,
        pad_token_id=tokenizer.eos_token_id,
    )

# ---- 6. Decode and clean output ----
decoded_output = tokenizer.decode(outputs[0], skip_special_tokens=True)
response_only = decoded_output.split("### Response:")[-1].split("<|endoftext|>")[0].strip()

# ---- 7. Print the final result ----
print("=== Model Response ===\n", response_only)

=== Model Response ===
 SQL: SELECT department, AVG(salary) FROM employees GROUP BY department;
Explanation: The SQL query calculates the average salary for each department by grouping the records by the department column and applying the AVG function to the salary column.

[10]
19s
    response = tokenizer.decode(outputs[0], skip_special_tokens=True)
    print(f"❓ Prompt: {prompt}\n📄 Response:\n{response.split('### Response:')[-1].split('<|endoftext|>')[0].strip()}\n{'-'*80}")

❓ Prompt: What is the total number of employees?
📄 Response:
SQL: SELECT COUNT(*) FROM employees;
Explanation: This SQL query calculates the total number of employees by using the COUNT function to count the number of rows in the employees table.
--------------------------------------------------------------------------------
❓ Prompt: Get the names of employees who earn more than 50000.
📄 Response:
SQL: SELECT name FROM employees WHERE salary > 50000;
Explanation: This query retrieves the names of employees who earn more than 50000 by selecting the name column from the employees table where the salary is greater than 50000.
--------------------------------------------------------------------------------
❓ Prompt: What is the average salary per department?
📄 Response:
SQL: SELECT department, AVG(salary) FROM employees GROUP BY department;
Explanation: This SQL query calculates the average salary per department. It uses the AVG() function to calculate the average value of the salary column, and the GROUP BY clause to group the results by department.
--------------------------------------------------------------------------------
❓ Prompt: Who is the highest-paid employee?
📄 Response:
SQL: SELECT name FROM employees ORDER BY salary DESC LIMIT 1;
Explanation: This query orders the employees table by salary in descending order and returns the name of the highest-paid employee.
--------------------------------------------------------------------------------
❓ Prompt: List departments that have more than 5 employees.
📄 Response:
SQL: SELECT department FROM employees GROUP BY department HAVING COUNT(*) > 5;
Explanation: The SQL query lists the departments that have more than 5 employees by grouping the 'employees' table by the 'department' column and filtering the groups using the HAVING clause.
