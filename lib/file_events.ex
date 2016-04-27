defmodule LiveReload.FileEvents do
	use GenServer

	def start_link() do
		GenServer.start_link(__MODULE__, [], name: __MODULE__)
	end

	def init([]) do
		:fs.subscribe()
		{:ok, []}
	end

	def handle_info({_pid, {:fs, :file_event}, {path, _event}}, socket) do
		hidden = is_hidden?(path)
		extension = Path.extname(path)

		path
		|> Path.relative_to_cwd
		|> reload_file(extension, hidden)

		{:noreply, socket}
	end

	defp reload_file(path, ".ex", false) do
		IO.puts IO.ANSI.bright <> "Reloaded #{path}" <> IO.ANSI.normal
		Code.load_file(path)
	end
	
	defp reload_file(path, _ext, _hidden) do
		IO.puts IO.ANSI.bright <> "Not reloaded: #{path}" <> IO.ANSI.normal
	end

	defp is_hidden?(path) do
		path
		|> Path.basename
		|> String.first
		|> is_dot?
	end

	defp is_dot?(char) do
		char == "."
	end
end
