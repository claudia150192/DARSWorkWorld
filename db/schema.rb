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

ActiveRecord::Schema.define(:version => 20120320044344) do

  create_table "answers", :force => true do |t|
    t.text     "answer"
    t.integer  "question_id"
    t.integer  "situation_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "cases", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "type"
    t.text     "notes"
  end

  create_table "chart_results", :force => true do |t|
    t.string   "name"
    t.integer  "chart_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "web_calc_id"
  end

  create_table "charts", :force => true do |t|
    t.string   "chart_type"
    t.string   "title"
    t.string   "yaxis_label"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "stack_type"
  end

  create_table "county_or_cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "medically_needy_group"
  end

  create_table "federal_poverty_levels", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "family_size_1"
    t.float    "family_size_2"
    t.float    "family_size_3"
    t.float    "family_size_4"
    t.float    "family_size_5"
    t.float    "family_size_6"
    t.float    "family_size_7"
    t.float    "family_size_8"
    t.float    "family_size_9"
    t.float    "family_size_10"
    t.float    "family_size_11"
    t.float    "family_size_12"
    t.float    "family_size_13"
    t.float    "family_size_14"
    t.float    "family_size_15"
    t.float    "additional"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "federal_rates", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "fbr_amount"
    t.float    "fbr_couple_amount"
    t.float    "pmv_amount"
    t.float    "pmv_couple_amount"
    t.float    "two_thirds_fbr_amount"
    t.float    "two_thirds_fbr_couple_amount"
    t.float    "services_amount"
    t.float    "sga_disabled_amount"
    t.float    "sga_blind_amount"
    t.float    "gen_exclude_amount"
    t.float    "earned_inc_disregard_amount"
    t.float    "seie_max_monthly"
    t.float    "seie_max_year"
    t.float    "RateCareBPremium"
    t.float    "RateSsiResourceLimit"
    t.float    "RateCoupleSsiResourceLimit"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.float    "RateCaidMostGroupsResourceLimit"
    t.float    "RateCoupleCaidMostGroupsResourceLimit"
    t.float    "RateQwdiResouceLimit"
    t.float    "RateCoupleQwdiResouceLimit"
    t.float    "RateQmbSlmbQiResouceLimit"
    t.float    "RateCoupleQmbSlmbQiResouceLimit"
    t.float    "RateLtcCaidSpousalResourceStandard"
    t.float    "RateLtcCaidSpousalMaxResourceStandard"
    t.float    "RateInfreqOrIrregUnearnPerQuarterAmt"
    t.float    "RateInfreqOrIrregEarnPerQuarterAmt"
  end

  create_table "helps", :force => true do |t|
    t.string   "topic"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "medicaid_annual_blind_thresholds", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "alabama"
    t.float    "alaska"
    t.float    "arizona"
    t.float    "arkansas"
    t.float    "california"
    t.float    "colorado"
    t.float    "connecticut"
    t.float    "delaware"
    t.float    "district_of_columbia"
    t.float    "florida"
    t.float    "georgia"
    t.float    "hawaii"
    t.float    "idaho"
    t.float    "illinois"
    t.float    "indiana"
    t.float    "iowa"
    t.float    "kansas"
    t.float    "kentucky"
    t.float    "louisiana"
    t.float    "maine"
    t.float    "maryland"
    t.float    "massachusetts"
    t.float    "michigan"
    t.float    "minnesota"
    t.float    "mississippi"
    t.float    "missouri"
    t.float    "montana"
    t.float    "nebraska"
    t.float    "nevada"
    t.float    "new_hampshire"
    t.float    "new_jersey"
    t.float    "new_mexico"
    t.float    "new_york"
    t.float    "north_carolina"
    t.float    "north_dakota"
    t.float    "ohio"
    t.float    "oklahoma"
    t.float    "oregon"
    t.float    "pennsylvania"
    t.float    "rhode_island"
    t.float    "south_carolina"
    t.float    "south_dakota"
    t.float    "tennessee"
    t.float    "texas"
    t.float    "utah"
    t.float    "vermont"
    t.float    "virginia"
    t.float    "washington"
    t.float    "west_virginia"
    t.float    "wisconsin"
    t.float    "wyoming"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "medicaid_annual_thresholds", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "alabama"
    t.float    "alaska"
    t.float    "arizona"
    t.float    "arkansas"
    t.float    "california"
    t.float    "colorado"
    t.float    "connecticut"
    t.float    "delaware"
    t.float    "district_of_columbia"
    t.float    "florida"
    t.float    "georgia"
    t.float    "hawaii"
    t.float    "idaho"
    t.float    "illinois"
    t.float    "indiana"
    t.float    "iowa"
    t.float    "kansas"
    t.float    "kentucky"
    t.float    "louisiana"
    t.float    "maine"
    t.float    "maryland"
    t.float    "massachusetts"
    t.float    "michigan"
    t.float    "minnesota"
    t.float    "mississippi"
    t.float    "missouri"
    t.float    "montana"
    t.float    "nebraska"
    t.float    "nevada"
    t.float    "new_hampshire"
    t.float    "new_jersey"
    t.float    "new_mexico"
    t.float    "new_york"
    t.float    "north_carolina"
    t.float    "north_dakota"
    t.float    "ohio"
    t.float    "oklahoma"
    t.float    "oregon"
    t.float    "pennsylvania"
    t.float    "rhode_island"
    t.float    "south_carolina"
    t.float    "south_dakota"
    t.float    "tennessee"
    t.float    "texas"
    t.float    "utah"
    t.float    "vermont"
    t.float    "virginia"
    t.float    "washington"
    t.float    "west_virginia"
    t.float    "wisconsin"
    t.float    "wyoming"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "medicaid_fpl_based_income_limits", :force => true do |t|
    t.datetime "start_date"
    t.float    "caid_80percent_fpl_inc_limit_assist_unit_1"
    t.float    "caid_80percent_fpl_inc_limit_assist_unit_2"
    t.float    "caid_qmb_inc_limit_assist_unit_1"
    t.float    "caid_qmb_inc_limit_assist_unit_2"
    t.float    "caid_slmb_inc_limit_assist_unit_1"
    t.float    "caid_slmb_inc_limit_assist_unit_2"
    t.float    "caid_qi_inc_limit_assist_unit_1"
    t.float    "caid_qi_inc_limit_assist_unit_2"
    t.float    "caid_qdwi_works_earn_inc_limit_assist_unit_1"
    t.float    "caid_qdwi_works_earn_inc_limit_assist_unit_2"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "question_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "parent_id"
    t.integer  "next_group_id"
    t.integer  "order"
    t.float    "workbook_order"
  end

  create_table "question_inserts", :force => true do |t|
    t.integer  "question_id"
    t.integer  "insert_number"
    t.integer  "webcalc_id_to_insert"
    t.string   "insert_type"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "insert_marker"
  end

  create_table "question_validation_inserts", :force => true do |t|
    t.integer  "question_id"
    t.integer  "insert_number"
    t.integer  "webcalc_id_to_insert"
    t.string   "insert_type"
    t.string   "insert_marker"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "name"
    t.string   "text",               :limit => 1000
    t.text     "display_rules"
    t.text     "default_answer",     :limit => 255
    t.string   "reference_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "group_id"
    t.string   "question_type"
    t.text     "answer_choices"
    t.integer  "question_order"
    t.text     "validation_rules"
    t.text     "validation_message", :limit => 255
    t.integer  "help_id"
    t.float    "workbook_order"
    t.string   "all_inputs_text"
    t.boolean  "force_default"
  end

  add_index "questions", ["name"], :name => "index_questions_on_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shared_cases_users", :id => false, :force => true do |t|
    t.integer "shared_case_id", :null => false
    t.integer "user_id",        :null => false
  end

  create_table "situations", :force => true do |t|
    t.string   "situation_type"
    t.string   "mode",           :default => "one_at_a_time"
    t.integer  "case_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.boolean  "completed",      :default => false
    t.integer  "parent_id"
  end

  create_table "text_result_inserts", :force => true do |t|
    t.integer  "web_text_result_id"
    t.integer  "insert_number"
    t.integer  "webcalc_id_to_insert"
    t.string   "insert_marker"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "insert_type"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "admin",               :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "mode_preference"
    t.string   "counselor_name"
    t.boolean  "allow_fileshare",     :default => false
    t.boolean  "receive_fileshare",   :default => false
    t.boolean  "receive_share_email", :default => false
    t.datetime "deleted_at"
    t.boolean  "active",              :default => false, :null => false
  end

  create_table "va_max_auxiliary_grant_facility_rates", :force => true do |t|
    t.datetime "start_date"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.float    "ag_personal_allowance"
    t.float    "ag_max_payment_pd8"
    t.float    "ag_couple_max_payment_pd8"
    t.float    "ag_max_payment_elsewhere"
    t.float    "ag_couple_max_payment_elsewhere"
  end

  create_table "va_medicaid_rates", :force => true do |t|
    t.datetime "start_date"
    t.float    "va_rate_caid_works_resource_limit"
    t.float    "va_rate_caid_real_estate_resource_limit"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.float    "va_rate_caid_ltc_home_equity_limit"
  end

  create_table "va_medically_needy_monthly_income_limits", :force => true do |t|
    t.datetime "start_date"
    t.integer  "assist_size"
    t.float    "group1"
    t.float    "group2"
    t.float    "group3"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "web_calcs", :force => true do |t|
    t.string   "name"
    t.text     "operation"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "web_calcs", ["name"], :name => "index_web_calcs_on_name"

  create_table "web_numerical_results", :force => true do |t|
    t.string   "name"
    t.text     "display_rules"
    t.integer  "order"
    t.integer  "web_calc_id"
    t.integer  "group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "text"
    t.string   "result_type"
    t.integer  "help_id"
  end

  create_table "web_numerical_results_groups", :force => true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "web_text_results", :force => true do |t|
    t.text     "text"
    t.string   "reference_id"
    t.string   "identifier"
    t.text     "display_rules"
    t.text     "comment"
    t.float    "workbook_order"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "group_id"
    t.string   "name"
    t.integer  "order"
    t.integer  "help_id"
  end

  create_table "web_text_results_groups", :force => true do |t|
    t.string   "name"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "web_tip_inserts", :force => true do |t|
    t.integer  "web_tip_id"
    t.integer  "insert_number"
    t.integer  "webcalc_id_to_insert"
    t.string   "insert_marker"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "insert_type"
  end

  create_table "web_tips", :force => true do |t|
    t.text     "text"
    t.string   "identifier"
    t.text     "display_rules"
    t.integer  "group_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "web_numerical_result_id"
    t.integer  "group_order"
    t.float    "workbook_order"
  end

end
