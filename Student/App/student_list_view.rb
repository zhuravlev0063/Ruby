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
  def initialize(app)
      super(app, "Student List", width: 980, height: 720)

      self.controller = Students_list_controller.new(self)
      self.filters = {}
      self.current_page = 1
      self.items_per_page = 11
      
      main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)
      main_frame.backColor = FXRGB(255, 255, 255)
      
      filter_frame = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 250, padding: 10)
      setup_filter_area(filter_frame)
      
      table_frame = FXVerticalFrame.new(main_frame, LAYOUT_FILL_X | LAYOUT_FILL_Y, padding: 10)
      setup_table_area(table_frame)
      
      control_frame = FXVerticalFrame.new(main_frame, LAYOUT_FIX_WIDTH, width: 150, padding: 10)
      setup_control_area(control_frame)
      
      refresh_data
  end
  def refresh_data
    puts "Рефреш на стороне вьюхи выполнен, передача уведомления контроллеру..."
    self.controller.refresh_data
  end

  def set_table_data(input_data_table)
    clear_table
    (0...input_data_table.count_of_rows - 1).each do |row|
      (0...input_data_table.count_of_columns).each do |col|
        self.table.setItemText(row, col, input_data_table.get_by_index(row, col).to_s)
      end
    end
  end
  
  def set_table_params(column_names, entities_count)
    column_names.each_with_index do |name, index|
      self.table.setItemText(0, index, name)
    end
    self.total_pages = (entities_count / self.items_per_page.to_f).ceil
    self.page_label.text = "Страница #{self.current_page} из #{self.total_pages}"
  end

  def setup_filter_area(parent)
    parent.backColor = FXRGB(255, 255, 255)
      filters_label = FXLabel.new(parent, "Фильтры")
      filters_label.backColor = FXRGB(240, 240, 255)

      initials_label = FXLabel.new(parent, "Фамилия и инициалы:")
      initials_label.backColor = FXRGB(255, 255, 255)
      
      name_text_field = nil
      name_text_field = FXTextField.new(parent, 25, opts: TEXTFIELD_NORMAL)
      
      self.filters['name'] = { text_field: name_text_field }
      add_filtering_row(parent, "Git:")
      add_filtering_row(parent, "Email:")
      add_filtering_row(parent, "Телефон:")
      add_filtering_row(parent, "Telegram:")
      FXButton.new(parent, "Сбросить фильтры", opts: BUTTON_TOOLBAR | LAYOUT_CENTER_X).tap do |button|
        button.backColor = FXRGB(255, 0, 0)
        button.textColor = FXRGB(255, 255, 255)
        button.connect(SEL_COMMAND) do
          button.backColor = FXRGB(180, 0, 0)
          
          app = button.app
          app.addTimeout(100) do
            button.backColor = FXRGB(255, 0, 0)
          end
          reset_filters
        end
      end
  end

  def add_filtering_row(parent, label)
    combo_label = FXLabel.new(parent, label)
    combo_label.backColor = FXRGB(255, 255, 255)
    combo = FXComboBox.new(parent, 3, opts: LAYOUT_FILL_X | FRAME_SUNKEN | FRAME_THICK | COMBOBOX_STATIC)
    combo.numVisible = 3
    combo.appendItem("Не важно")
    combo.appendItem("Да")
    combo.appendItem("Нет")
    text_field = FXTextField.new(parent, 15, opts: TEXTFIELD_NORMAL)
    text_field.visible = false
    self.filters[label] = { combo: combo, text_field: text_field }
    combo.connect(SEL_COMMAND) do
        text_field.visible = (combo.currentItem == 1)
        parent.recalc
    end
  end
    
  def setup_table_area(parent)
    parent.backColor = FXRGB(255, 255, 255)
    # Setup table
    self.table = FXTable.new(parent, opts: LAYOUT_FILL_X | LAYOUT_FILL_Y | TABLE_READONLY)
    self.table.setTableSize(self.items_per_page, 4)
    self.table.setColumnWidth(0, 30)
    self.table.setColumnWidth(1, 100)
    self.table.setColumnWidth(2, 200)
    self.table.setColumnWidth(3, 200)
    self.table.rowHeaderWidth = 0
    self.table.columnHeaderHeight = 0

    self.table.connect(SEL_COMMAND) do |_, _, pos|
        if pos.row == 0
            sort_table_by_column(pos.col)
        end

        if pos.col == 0
            self.table.selectRow(pos.row)
        end
    end

    # Setup navigation
    navigation_frame = FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X)
    navigation_frame.backColor = FXRGB(240, 240, 255)
    self.prev_button = FXButton.new(navigation_frame, "<", opts: BUTTON_TOOLBAR | LAYOUT_LEFT, padLeft: 10, padRight: 10)
    self.next_button = FXButton.new(navigation_frame, ">", opts: BUTTON_TOOLBAR | LAYOUT_RIGHT, padLeft: 10, padRight: 10)
    self.page_label = FXLabel.new(navigation_frame, "Страница 1", opts: LAYOUT_CENTER_X)
    page_label.backColor = FXRGB(240, 240, 255)
    self.prev_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        change_page(-1)
      end
    end
    self.next_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        change_page(1)
      end
    end
  end

  def setup_control_area(parent)
    parent.backColor = FXRGB(255, 255, 255)
    self.add_button = FXButton.new(parent, "Добавить", opts: BUTTON_TOOLBAR | LAYOUT_FILL_X)
    add_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        #TODO add logic
      end
    end
    self.delete_button = FXButton.new(parent, "Удалить", opts: BUTTON_TOOLBAR | LAYOUT_FILL_X)
    delete_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        #TODO add logic
      end
    end
    self.change_button = FXButton.new(parent, "Изменить", opts: BUTTON_TOOLBAR | LAYOUT_FILL_X)
    change_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        #TODO add logic
      end
    end
    self.update_button = FXButton.new(parent, "Обновить", opts: BUTTON_TOOLBAR | LAYOUT_FILL_X)
    update_button.tap do |button|
      button.backColor = FXRGB(100, 100, 255)
      button.textColor = FXRGB(255, 255, 255)
      button.connect(SEL_COMMAND) do
        button.backColor = FXRGB(0, 0, 200)
        
        app = button.app
        app.addTimeout(100) do
          button.backColor = FXRGB(100, 100, 255)
        end
        refresh_data
      end
    end

    self.table.connect(SEL_CHANGED) do
      update_buttons_state
    end
  end


  def change_page(offset)
    new_page = self.current_page + offset
    puts "#{self.current_page}, #{new_page}"
    if self.current_page + offset < 1 || self.current_page + offset > self.total_pages
      puts "Недопустимая страница: #{new_page}"
      return
    end
    self.current_page = new_page
    refresh_data
  end
  

  def sort_table_by_column(col_idx=0)
    #TODO realize
  end

  def create
      super
      show(PLACEMENT_SCREEN)
  end

  def update_buttons_state
    selected_rows = (0...self.table.numRows).select { |row| self.table.rowSelected?(row) }
    self.delete_button.enabled = !selected_rows.empty?
    self.change_button.enabled = (selected_rows.size == 1)
  end

  def clear_table
    (0...self.table.numRows).each do |row|
      (0...self.table.numColumns).each do |col|
        self.table.setItemText(row, col, "")
      end
    end
  end

  attr_accessor :current_page, :items_per_page

  private
  attr_accessor :filters, :table, :prev_button, :next_button, :page_label, :sort_order, :data, :controller, :total_pages, :delete_button, :change_button, :selected_rows, :add_button, :update_button
  def reset_filters
      self.filters.each do |key, field|
          field[:combo].setCurrentItem(0) if !field[:combo].nil?
          field[:text_field].text = ""
          field[:text_field].visible = false if key != 'name'
      end
      refresh_data
  end
end