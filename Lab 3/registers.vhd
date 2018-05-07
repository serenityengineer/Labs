--------------------------------------------------------------------------------
--
-- LAB #3
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	-- insert your code here.
	--Code: using generate to instantiate the register
	REG_GEN:
		FOR p IN 0 TO 7 GENERATE
			Rp: bitstorage PORT MAP(datain(p), enout, writein, dataout(p));
		END GENERATE;
end architecture memmy;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	-- hint: you'll want to put register8 as a component here 
	-- so you can use it below
COMPONENT register8		--this defines the 8bit register as a usable component
		PORT(datain: IN std_logic_vector(7 DOWNTO 0);
	    	enout:  IN std_logic;
	     	writein: IN std_logic;
	     	dataout: OUT std_logic_vector(7 DOWNTO 0));
	END COMPONENT;
	--enable created as a vector, used to enable the 4 components of the 32
	--bit register.
	SIGNAL 	enable: std_logic_vector(3 DOWNTO 0);
	SIGNAL	writein: std_logic_vector(3 DOWNTO 0);
begin
	-- insert code here.
	-- instantiating the register
	-- creating the structure for each component, set enables
	enable <= 	"0000" WHEN enout32 = '0' ELSE
				"1100" WHEN enout32 = '1' AND enout16 = '0' ELSE
				"1110" WHEN enout32 = '1' AND enout16 = '1' AND enout8 = '0' ELSE
				"1111" WHEN enout32 = '1' AND enout16 = '1' AND enout8 = '1';
	
	writein <=	"1111" WHEN writein32 = '1' ELSE
				"0011" WHEN writein32 = '0' AND writein16 = '1' ELSE
				"0001" WHEN writein32 = '0' AND writein16 = '0' AND writein8 = '1' ELSE
				"0000" WHEN writein32 = '0' AND writein16 = '0' AND writein8 = '0';

	-- using component of 8 bit register; stack of 4 8Bits creates a 32Bit reg:
R1: register8 PORT MAP(datain(7 DOWNTO 0), enable(0), writein(0), dataout(7 DOWNTO 0));
R2: register8 PORT MAP(datain(15 DOWNTO 8), enable(1), writein(1), dataout(15 DOWNTO 8));
R3: register8 PORT MAP(datain(23 DOWNTO 16), enable(2), writein(2), dataout(23 DOWNTO 16));
R4: register8 PORT MAP(datain(31 DOWNTO 24), enable(3), writein(3), dataout(31 DOWNTO 24));


end architecture biggermem;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic;
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is
-- use the fulladder from above
COMPONENT fulladder 
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end COMPONENT;
-- use cary32 as the register for adding
-- use hold to work through the operations
SIGNAL carry32: std_logic_vector(31 DOWNTO 0);
SIGNAL hold: std_logic_vector(31 DOWNTO 0);

begin
	-- insert code here.
	

end architecture calc;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
	
begin
	process (dir)
	begin

		if dir = '0' then
			
			if shamt = "00011" then
				dataout(31 downto 3) <= datain(28 downto 0);
				dataout(2 downto 0) <= "000";
			
			if shamt = "00010" then
				dataout(31 downto 2) <= datain(29 downto 0);
				dataout(1 downto 0) <= "00";
			
			if shamt = "00001" then
				dataout(31 downto 1) <= datain(30 downto 0);
				dataout(0) <= "0";

			else
				dataout <= datain;
			
			end if;
		end if;

		if dir = '1' then
	
			if shamt = "00011" then
				dataout(28 downto 0) <= datain(31 downto 3);
				dataout(31 downto 29) <= "000";
	
			elsif shamt = "00010" then
				dataout(29 downto 0) <= datain(31 downto 2);
				dataout(31 downto 30) <= "00";

			elsif shamt = "00001" then
				dataout(30 downto 0) <= datain(31 downto 0);
				dataout(31) <= "0";
	
			else
				dataout <= datain;
			end if;
		end if;

	end process; 
end architecture shifter;



