library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture behavioural of testbench is
    component writer
    port
    (
        Clk_CI:         	in std_logic;
        Address_DI:     	in std_logic_vector (2 downto 0);
        Write_SI:		    in std_logic;
        WriteData_DI:       in std_logic_vector (7 downto 0);
              
        -- Register write from CPU
        RegDir_DO:          out std_logic_vector (7 downto 0);
        RegPort_DIO:        inout std_logic_vector (7 downto 0)
    );
    end component;

   --declare inputs and initialize them
   signal Clk_S :               std_logic := '0';
   signal Address_D:            std_logic_vector (2 downto 0) := (others => '1');
   signal Write_S:       	    std_logic   := '0' ;
   signal WriteData_D:		    std_logic_vector (7 downto 0) := (others => '0');
   signal RegDir_D: 		    std_logic_vector (7 downto 0) := (others => '0');
   signal RegPort_D:    		std_logic_vector (7 downto 0) := (others => '0');
   
   signal Time_S:               time := 0 ns;
   
   constant TimeMax_C:          time := 1000 ns;
   constant Clk_period_C :      time := 20 ns;
begin   
    wr: writer port map(Clk_CI => Clk_S,
                        Address_DI => Address_D,
                        Write_SI => Write_S,
                        WriteData_DI => WriteData_D,
                        RegDir_DO => RegDir_D,
                        RegPort_DIO => RegPort_D);

   clk_process :process
   begin
        if(Time_S < TimeMax_C)then
            Clk_S <= '0';
            wait for Clk_period_C/2;
            Clk_S <= '1';
            wait for Clk_period_C/2;
            Time_S <= Time_S + Clk_period_C;
        end if;
   end process;
   
   -- Stimulus process
  stim_proc: process
   begin         
        wait for 7 ns;
        Address_D <= "000";
        WriteData_D <= (others => '1');
        wait for 4 * Clk_period_C;        
        Write_S <= '1';
        wait for 4 * Clk_period_C;      
        Write_S <= '0';
        wait for Clk_period_C; 
        WriteData_D <= (others => '0');
        wait for Clk_period_C; 
        Address_D <= "010";
        WriteData_D <= (others => '1');
        wait for 4 * Clk_period_C;        
        Write_S <= '1';
        wait for 4 * Clk_period_C;      
        Write_S <= '0';
        wait;
  end process;
end;
