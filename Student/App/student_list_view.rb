require 'fox16'
require_relative '../student_list_json'
require_relative '../student_list_yaml'
require_relative '../strategy'
require_relative '../student_list_db'
require_relative '../student_list'
require_relative '../data_list'
require_relative '../data_list_student_short'
require_relative './student_list_controller'

include Fox

class StudentListView < FXMainWindow
  private attr_accessor :filters, :table, :prev_button, :next_button, :total_pages,
  :page_index, :delete_button, :edit_button, :controller, :selected_rows
  attr_accessor :current_page, :items_per_page

  def initialize(app)
    super(app, "Students", width: 1200, height: 768)

    self.controller = Students_list_controller.new(self)
    self.filters = {}
    self.current_page = 1
    self.items_per_page = 5
    self.total_pages = 0

    main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL)
    filter_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 220, padding: 15)
    setup_filter_segment(filter_segment)

    table_segment = FXVerticalFrame.new(main_frame, LAYOUT_FILL, padding: 10)
    setup_table_segment(table_segment)
    
    crud_segment = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 130, padding: 10)
    setup_crud_segment(crud_segment)

    self.current_page = 1

    # Объект view вызывает метод refresh_data у контроллера
    self.controller.refresh_data
    update_buttons_state
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  # Устанавливаем колонки таблицы и кол-во страниц
  def set_table_params(column_names, logs_count)
    column_names.each_with_index do |name, index|
        self.table.setItemText(0, index, name)
    end
    self.total_pages = (logs_count / (self.items_per_page-1 ).to_f).ceil
    self.page_index.text = "#{self.current_page} out of #{self.total_pages}"
  end

  # Заполнение таблицы
  def set_table_data(data_table)
    clear_table
    (0...data_table.count_of_columns).each do |col|
    (0...data_table.count_of_rows).each do |row|
     
        self.table.setItemText(row, col, data_table.get_by_index(row, col).to_s)
         puts "Row #{row}, Col #{col}: #{data_table.get_by_index(row, col)}"
      end
    end

  end
  

  private 

  # Создание области фильтрации
  def setup_filter_segment(parent)
  
    add_filter_row(parent, "Git:")
    add_filter_row(parent, "Email:")
    add_filter_row(parent, "Phone:")
    add_filter_row(parent, "Telegram:")
  end

  # Создание области с таблицой студентов 
  def setup_table_segment(parent)
    self.table = FXTable.new(parent, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.setTableSize(self.items_per_page, 4)
    self.table.setColumnWidth(0, 100)
    (1..3).each {|col| self.table.setColumnWidth(col, 200)}
    self.table.rowHeaderWidth = 0

    self.table.connect(SEL_COMMAND) do |_, _, pos|
      if pos.row == 0 && pos.col == 1
        self.controller.sort_table_by_column
        self.controller.refresh_data
      end

      if pos.col == 0
        self.table.selectRow(pos.row)
      end

      update_buttons_state
    end

    navigation_segment = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    self.prev_button = FXButton.new(navigation_segment, "<-", opts: LAYOUT_LEFT | BUTTON_NORMAL)
    self.page_index = FXLabel.new(navigation_segment, "1", opts: LAYOUT_CENTER_X)
    self.next_button = FXButton.new(navigation_segment, "->", opts: LAYOUT_RIGHT | BUTTON_NORMAL)
    self.prev_button.connect(SEL_COMMAND) {change_page(-1)}
    self.next_button.connect(SEL_COMMAND) {change_page(1)}
  end

  # Создание области управления
  def setup_crud_segment(parent)
    add_button = FXButton.new(parent, "Add", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    add_button.setBackColor(FXRGB(0, 105, 0)) 
    add_button.setTextColor(FXRGB(0, 0, 0)) 
    add_button.connect(SEL_COMMAND) do
      self.controller.create
    end

    self.delete_button = FXButton.new(parent, "Delete", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    delete_button.setBackColor(FXRGB(0, 105, 0)) 
    delete_button.setTextColor(FXRGB(0, 0, 0)) 
    delete_button.connect(SEL_COMMAND) do
      delete_logs
    end

    self.edit_button = FXButton.new(parent, "Change", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    edit_button.setBackColor(FXRGB(0, 105, 0)) 
    edit_button.setTextColor(FXRGB(0, 0, 0)) 
    edit_button.connect(SEL_COMMAND) do
      change_log
    end

    refresh_button = FXButton.new(parent, "Update", opts: LAYOUT_FILL_X | BUTTON_NORMAL)
    refresh_button.setBackColor(FXRGB(0, 105, 0)) 
    refresh_button.setTextColor(FXRGB(0, 0, 0)) 
    refresh_button.connect(SEL_COMMAND) do
      self.controller.renew
    end

    self.table.connect(SEL_CHANGED) {update_buttons_state}
  end

  # Добавление выбора наличия или отсутствия фильтра
  def add_filter_row(parent, label)
    FXLabel.new(parent, label, opts: LABEL_NORMAL).setTextColor(FXRGB(0, 0, 0)) # Ярко-розовый
    cbx = FXComboBox.new(parent, 3, opts: LAYOUT_FIX_WIDTH | COMBOBOX_STATIC, width: 190)
    cbx.numVisible = 3
    cbx.appendItem("No matter")
    cbx.appendItem("Yes")
    cbx.appendItem("No")
  
    # Установка цвета фона и текста для ComboBox
    cbx.setBackColor(FXRGB(0, 192, 0)) # Розовый фон для ComboBox
    cbx.setTextColor(FXRGB(0, 0, 0)) # Черный текст для ComboBox
  
    search_tbx = FXTextField.new(parent, 25)
    search_tbx.setBackColor(FXRGB(0, 192, 0)) # Розовый фон для текстового поля
    search_tbx.setTextColor(FXRGB(0, 0, 0)) # Черный текст
    search_tbx.visible = false
  
    self.filters[label] = { combo_box: cbx, text_field: search_tbx }
    cbx.connect(SEL_COMMAND) do
      search_tbx.visible = (cbx.currentItem == 1)
      parent.recalc
    end
  end

  # Обновление доступ к кнопкам CRUD в зависимости от выбранных строк
  def update_buttons_state
    selected_rows = (0...self.table.numRows).select {|row| self.table.rowSelected?(row)}
    self.delete_button.enabled = !selected_rows.empty?
    self.edit_button.enabled = (selected_rows.size == 1)
  end

  # Переключение страниц
  def change_page(offset)
    new_page = self.current_page + offset
    return if new_page < 1 || new_page > self.total_pages
    self.current_page = new_page
    self.controller.refresh_data
  end

  # Очистка таблицы
  def clear_table
    (1...self.table.numRows).each do |row|
      (0...self.table.numColumns).each do |col|
        self.table.setItemText(row, col, "")
      end
    end
  end

  # Нажатие кнопки "Изменить"
  def change_log
    self.selected_rows = []
    (0...self.table.numRows).each do |row_ix|
        self.selected_rows << row_ix if self.table.rowSelected?(row_ix)
    end
    self.controller.change(self.selected_rows[0])
  end

  # Нажатие кнопки "Удалить"
  def delete_logs
    self.selected_rows = []
    (0...self.table.numRows).each do |row_ix|
      self.selected_rows << row_ix if self.table.rowSelected?(row_ix)
    end
    self.controller.delete(self.selected_rows)
  end
end