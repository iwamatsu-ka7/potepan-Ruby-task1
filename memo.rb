require "csv"

memo_type = nil

loop do
  puts "1（新規でメモを作成） / 2（既存のメモ編集する）"
  print "番号を入力してください → "
  memo_type = gets.to_i

  if memo_type == 1 || memo_type == 2
    break
  else
    puts "不正な値です。1か2を入力してください。"
  end
end

# 新規でメモを作成する（1）
if memo_type == 1
  file_name = ""
  loop do
   puts "拡張子を除いたファイルを入力してください"
   file_name = gets.chomp
   break unless file_name.empty? # 空っぽでなければループを抜ける
   puts "ファイル名が入力されていません！"
  end

  puts "メモしたい内容を記入してください。\n完了したらEnterを押し、Ctrl＋Z＋Enterを押します。\n※Macの場合はCtrl＋Dを押してください。" 
  input_text = $stdin.read   
  memo_lines = input_text.split("\n") 

  CSV.open("#{file_name}.csv", "w") do |csv|
    memo_lines.each do |line|
      csv << [line]
    end
  end

  puts "新規メモを保存しました！"

# 既存のメモを編集する（2）
elsif memo_type == 2
  file_name = ""
  loop do
  puts "拡張子を除いた編集したいファイルを入力してください"
  file_name = gets.chomp

  if File.exist?("#{file_name}.csv")
      break # ファイルがあればループを抜ける
    else
      puts "「#{file_name}.csv」というファイルが見つかりません。もう一度入力してください。"
    end
  end

  puts "編集したい内容を記入してください。\n完了したらEnterを押し、Ctrl＋Z＋Enterを押します。\n※Macの場合はCtrl＋Dを押してください。" 
  input_text = $stdin.read
  memo_lines = input_text.split("\n")  # 行ごと追加

  CSV.open("#{file_name}.csv", "a") do |csv|
    memo_lines.each do |line|
      csv << [line]
    end
  end

  puts "メモを追記しました！"
end