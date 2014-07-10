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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140708112122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomodations", force: true do |t|
    t.string   "address_line"
    t.string   "city"
    t.string   "postcode"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentication_tokens", force: true do |t|
    t.string   "token"
    t.integer  "tenant_id"
    t.integer  "expires_in"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentication_tokens", ["tenant_id"], name: "index_authentication_tokens_on_tenant_id", using: :btree

  create_table "tenants", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.integer  "accomodation_id"
  end

  add_index "tenants", ["accomodation_id"], name: "index_tenants_on_accomodation_id", using: :btree

end
