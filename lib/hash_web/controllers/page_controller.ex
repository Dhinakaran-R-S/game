defmodule HashWeb.PageController do
  use HashWeb, :controller
  alias Hash.LongText

  def home(conn, _params) do
    word_counts = LongText.count_words()
    render(conn, :home, word_counts: word_counts)
  end
end
