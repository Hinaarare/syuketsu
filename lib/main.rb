# To change this template, choose Tools | Templates
# and open the template in the editor.

require "cgi"
require "pstore"

INDEX_HTML = "index.html"
REFERER    = "http://localhost:4989/index.cgi"


#===================================================
# html出力
#===================================================
def render(html)
  @cgi.out("text/html") {
    html
  }
end

#===================================================
# フォーム情報保存
#===================================================
def store_db
  db = Pstore.new("schedule.db")
  db.transaction do
    db["params"] = params
  end
end

#===================================================
# フォーム情報読み込み
#===================================================
def read_db

  db = Pstore.new("schedule.db")
  db.transaction do
    @cgi.params = db["params"]
  end
end

#===================================================
# main
#===================================================
begin
  @cgi =CGI.new

  # refererがhttp://localhost:4989/index.cgi以外のはすべてトップページを表示
  if @cgi.referer == REFERER
    params = @cgi.params
    body = params.inspect
    body += @cgi.referer
  else
    body = File.open(INDEX_HTML).read
  end

  render(body)
rescue => e
  render(e.message)
end