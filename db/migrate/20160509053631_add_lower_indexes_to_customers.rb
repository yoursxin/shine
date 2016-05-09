class AddLowerIndexesToCustomers < ActiveRecord::Migration
 
  def up
    execute %{
      CREATE INDEX 
        customer_lower_last_name
      ON 
        customers (lower(last_name) varchar_pattern_ops)
    }
    execute %{
      CREATE INDEX 
        customer_lower_first_name
      ON 
        customers (lower(first_name) varchar_pattern_ops)
    }
    execute %{
      CREATE INDEX 
        customer_lower_email
      ON 
        customers (lower(email) varchar_pattern_ops)
    }
  end
  def down
    remove_index :customers, name: 'customer_lower_last_name'
    remove_index :customers, name: 'customer_lower_first_name'
    remove_index :customers, name: 'customer_lower_email'
  end
end
