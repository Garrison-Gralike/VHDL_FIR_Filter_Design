
--VHDL Lab 10

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_testing is
  generic (
    NUM_COEF  : natural := 21;
    BITS_COEF : natural := 10;
    BITS_IN   : natural := 4;
    BITS_OUT  : natural := 16
  );
  port (
    clk     : in  std_logic;
    rst     : in  std_logic;
    x       : in  std_logic_vector(BITS_IN-1 downto 0);
    y       : out std_logic_vector(BITS_OUT-1 downto 0)
  );
end fir_testing;

architecture behavioral of fir_testing is

	type int_array is array (0 to NUM_COEF-1) of integer range -2**(BITS_COEF-1) to 2**(BITS_COEF-1)-1;
	constant coef	: int_array := (-10, -18, -6, 28, 44, 2, -64, -52, 100, 311, 410, 311, 100, -52, -64, 2, 44, 28, -6, -18, -10); --(-8, -5, -5, -1, 1, 2, 2, 3, 5, 7, 7)
	
	-- Internal Signals
	type signed_array	is array (natural range <>) of signed;
	signal shift_reg	: signed_array (0 to NUM_COEF-1)(BITS_COEF-1 DOWNTO 0);
	signal prod		: signed_array (0 to NUM_COEF-1)(BITS_IN + BITS_COEF-1 DOWNTO 0);
	signal sum 		: signed_array (0 to NUM_COEF-1)(BITS_OUT-1 DOWNTO 0);
	signal sum_reg : signed_array (0 to NUM_COEF-1)(BITS_OUT-1 DOWNTO 0);

begin

  process(clk, rst)
  begin
		 if rst = '0' then
			shift_reg <= (others => (others => '0'));
		elsif rising_edge(clk) then 
			shift_reg <= signed(x) & shift_reg(0 to NUM_COEF-2);
		end if;
	end process;
		
	-- Multipiers
	mult: for i in 0 to NUM_COEF-1 generate
		prod(i) <= to_signed(coef(i), BITS_COEF)*shift_reg(i);
	end generate;
	
	-- Adder
	sum(0) <= resize(prod(0), BITS_OUT);
	adder: for i in 1 to NUM_COEF-1 generate
		sum(i) <= sum(i-1) + prod(i);
--		when rising_egde(clk) => sum_reg(i) <= sum(i);
		reg: process (clk)
		begin
			if rising_edge(clk) then 
				sum_reg(i) <= sum(i);
				end if;
			end process;
	end generate;

	y <= std_logic_vector(sum_reg(NUM_COEF-1));
		
end behavioral;