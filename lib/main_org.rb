# To change this template, choose Tools | Templates
# and open the template in the editor.

require "cgi"
require "erb"
require "pstore"

class Syuketsu
  INDEX_HTML = "index.erb"
  REFERER    = "http://localhost:4989/index.cgi"
  USERS      = "users.list"
  SCHEDULE   = "schedule.list"

  #===================================================
  # main
  #===================================================
  def initialze
    begin
      raise "test"
      @cgi =CGI.new

      case @cgi.params["cmd"]
      when "check"
        body = check
      when "save"
        body = save
      else
        body = schedule
      end

#      render(body)
    rescue => e
      render(e.message)
    end
  end

  #===================================================
  # html出力
  #===================================================
  def render(html)
    @cgi.out("text/html") {
      html
    }
  end

  #===================================================
  # スケジュール画面
  #===================================================
  def schedule
    users    = File.open(USERS).readlines
    schedule = File.open(SCHEDULE).readlines
    erb = ERB.new(File.open(INDEX_HTML).read)

#    return erb.result
    return "a"
  end
  #===================================================
  # 変更チェック
  # top画面を表示してから変更がないかチェックする
  #===================================================
  def check(access_time)

    return "stil not impliment"
  end
  #===================================================
  # 保存
  #===================================================
  def save
  # refererがhttp://localhost:4989/index.cgi以外だったら何もしない
    if @cgi.referer == REFERER
      params = @cgi.params
      body = params.inspect
      body += @cgi.referer
    end
    return "stil not impliment"
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

end