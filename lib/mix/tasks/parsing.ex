defmodule Mix.Tasks.Onix.Parsing do
  use Mix.Task
  @shortdoc "Parse ONIX document and print inspect"
  @moduledoc ~S"""
   This is used to parsing and print out all available node in ONIX document.
   You suppose to pass valid_file_path and version to the task.
   #Usage
   ```
      mix onix.parsing ["file_path", "2.1"|"3.0"]
   ```
  """

  def run([path, version]) do
    Application.ensure_all_started(:ex_catalogue)
    # IO.puts "args: #{inspect(args, [pretty: true, width: 0])}"
    ExOnixo.Parser.parse_stream_sender(path, %{release: version})
  end
end
