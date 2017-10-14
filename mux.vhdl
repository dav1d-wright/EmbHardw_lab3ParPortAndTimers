library ieee;
use ieee.std_logic_1164.all;

entity MUX is
    port
    {
        RegPort_DI:     in std_logic_vector (7 downto 0);
        RegSet_DI:      in std_logic_vector (7 downto 0);
        RegClr_DI:      in std_logic_vector (7 downto 0);
        WriteData_DI:	in std_logic_vector (7 downto 0);
        Out_DO:         out std_logic_vector(7 downto 0);
        
    };
end entity MUX;

architecture dataflow of MUX is
begin    
    Out_DO  <=  RegPort_DI or WriteData_DI          when "01",  -- set operation
                RegPort_DI and not WriteData_DI     when "10",  -- clear operation
                RegPort_DI                          when others; -- read and invalid operations
end dataflow;