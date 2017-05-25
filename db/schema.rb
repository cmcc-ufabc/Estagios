# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160725162522) do

  create_table "aprovas", :force => true do |t|
    t.string   "tipo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "aluno_id"
  end

  create_table "avisos", :force => true do |t|
    t.string   "detalhes"
    t.string   "autor"
    t.string   "titulo"
    t.date     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "periodo_id"
    t.string   "centro"
  end

  create_table "cancelamentos", :force => true do |t|
    t.integer  "aluno_id"
    t.integer  "status"
    t.integer  "disciplina_id"
    t.string   "nomedis"
    t.string   "justificativa"
    t.string   "parecer",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mensagem",      :limit => 225
    t.string   "periodo_id"
    t.string   "centro"
  end

  create_table "chamadas", :force => true do |t|
    t.string   "aluno_id"
    t.text     "mensagem_sec"
    t.text     "mensagem_aluno"
    t.string   "tipo_chamada"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "protocolo"
    t.string   "status"
    t.string   "periodo_id"
  end

  create_table "cursos", :force => true do |t|
    t.integer  "aluno_id"
    t.string   "nome_do_curso"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "disciplinas", :force => true do |t|
    t.string   "curso"
    t.string   "codigo"
    t.string   "nome"
    t.string   "turno"
    t.string   "dia"
    t.time     "horario_inicio"
    t.time     "horario_fim"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "periodo_id"
    t.string   "docente"
  end

  create_table "docentes", :force => true do |t|
    t.string   "docente"
    t.string   "centro"
    t.string   "email"
    t.string   "ramal"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dssirelatorios", :force => true do |t|
    t.string   "dataenvio"
    t.string   "aluno"
    t.string   "matricula_id"
    t.string   "ci"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "fluxomatriculas", :force => true do |t|
    t.string   "aluno_id"
    t.string   "periodo_id"
    t.string   "disciplina_id"
    t.string   "data"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "formularios", :force => true do |t|
    t.string   "resposta_2"
    t.string   "resposta_3"
    t.string   "resposta_4"
    t.string   "resposta_5"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "aluno_id"
    t.integer  "periodo_id"
    t.string   "centro"
    t.string   "porcentagem"
    t.text     "mensagem"
    t.string   "resposta_6"
    t.string   "resposta_7"
  end

  create_table "matriculas", :force => true do |t|
    t.integer  "disciplina_id"
    t.integer  "aluno_id"
    t.integer  "periodo_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "status"
    t.string   "observacao"
    t.string   "parecer"
    t.string   "arquivo"
    t.text     "mensagem"
    t.string   "conceito"
    t.string   "horas"
    t.integer  "numero_ci"
    t.string   "cancelou"
    t.string   "centro"
  end

  create_table "periodos", :force => true do |t|
    t.date     "matricula_inicio"
    t.date     "matricula_fim"
    t.date     "reajuste_inicio"
    t.date     "reajuste_fim"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "quadrimestre"
    t.integer  "ano"
    t.integer  "registrador_ci"
    t.date     "remanescente_inicio"
    t.date     "remanescente_fim"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "nome"
    t.string   "tipo"
    t.string   "ra"
    t.string   "centro"
    t.string   "telefone"
  end

  add_index "usuarios", ["authentication_token"], :name => "index_usuarios_on_authentication_token", :unique => true
  add_index "usuarios", ["confirmation_token"], :name => "index_usuarios_on_confirmation_token", :unique => true
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true
  add_index "usuarios", ["unlock_token"], :name => "index_usuarios_on_unlock_token", :unique => true

end
