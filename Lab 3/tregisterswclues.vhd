
--------------------------------------------------------------------------------
--
-- Test Bench for LAB #3
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testreg_vhd IS
END testreg_vhd;

ARCHITECTURE behavior OF testreg_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT adder_subtracter
	PORT(
		datain_a : IN std_logic_vector(31 downto 0);
		datain_b : IN std_logic_vector(31 downto 0);
		add_sub : IN std_logic;          
		dataout : OUT std_logic_vector(31 downto 0);
		co : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT register32
	PORT(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	END COMPONENT;
	
	COMPONENT shift_register
	PORT(	datain: in std_logic_vector(31 downto 0);
	   dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
	END COMPONENT;

	--Inputs
	SIGNAL add_sub :  std_logic := '0';
	SIGNAL datain_a :  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain_b :  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL data		:  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain	:	std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL dir : std_logic;
	SIGNAL shamt	:		std_logic_vector(4 downto 0)	:= (others=>'0');
	SIGNAL enout32,enout16,enout8: std_logic := '1';
	SIGNAL writein32,writein16,writein8: std_logic := '0';

	--Outputs
	SIGNAL addsubdataout :  std_logic_vector(31 downto 0);
	SIGNAL shdataout:	std_logic_vector(31 downto 0);
	SIGNAL dataout: std_logic_vector(31 downto 0);
	SIGNAL co :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: adder_subtracter PORT MAP(
		datain_a => datain_a,
		datain_b => datain_b,
		add_sub => add_sub,
		dataout => addsubdataout,
		co => co
	);
	
	uut2: register32 PORT MAP(
		datain => datain,
		enout32 => enout32,
		enout16 => enout16,
		enout8 => enout8,
		writein32 => writein32,
		writein16 => writein16,
		writein8 => writein8,
		dataout => dataout
	);
	
	uut3: shift_register PORT MAP(
		datain => datain,
		dir => dir,
		shamt => shamt,
		dataout => shdataout
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- test the adder_subtracter first
		datain_a <= X"4F302C85";
		datain_b <= X"7A222578";
		wait for 20 ns; -- dataout should be 0xC95251FD
		add_sub <= '1'; -- subtraction at 120nS
		wait for 20 ns; -- dataout should be 0xD50E070D
		add_sub <= '0'; -- addition at 140nS
		datain_a <= X"C0765A22";
		datain_b <= X"B4059ADD";
		wait for 20 ns; -- dataout should be 0x747BF4FF
		add_sub <= '1'; -- subtraction at 160nS
		wait for 20 ns; -- dataout should be 0x0C70BF45

		-- now test the register32
		datain <= X"5A5A5A5A";  -- at 180nS
		wait for 5 ns;
		writein32 <= '1'; -- can't tell if it took yet
		wait for 5 ns;
		writein32 <= '0';
		datain <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; -- at 190nS
		wait for 5 ns;  -- data should be 0x5A5A5A5A
		enout32 <= '0'; -- at 195nS
		wait for 5 ns;  -- data should be ZZZZZZZZ
		enout32 <= '1'; -- at 200nS
		wait for 5 ns;  -- at 205nS
		datain <= X"A5A5A5A5";
		wait for 5 ns;  -- at 210nS
		writein16 <= '1'; -- only low two bytes being written
		wait for 5 ns;  -- at 215nS
		writein16 <= '0';
		datain <= (others => 'Z');
		wait for 5 ns;
		enout16 <= '0'; -- data should be 0xZZZZA5A5 at 220nS
		wait for 5 ns;  -- data should be 0x5A5AA5A5 at 225nS
		enout16 <= '1';
		enout32 <= '0';
		wait for 5 ns;  --data should be 0x5A5AA5A5 up to 230nS
		enout32 <= '1'; -- data should be 0xZZZZZZZZ
		wait for 5 ns; -- at 235nS
		datain <= X"00000026";
		wait for 5 ns; -- at 240nS
		writein8 <= '1';
		wait for 5 ns; -- at 245nS
		writein8 <= '0';
		datain <= (others => 'Z');
		wait for 5 ns; -- at 250nS
		enout8 <= '0'; -- data shoul be 0xZZZZZZ26
		wait for 5 ns; -- at 255nS
		enout8 <= '1';
		enout32 <= '0'; -- data should be 0x5A5AA526
		wait for 5 ns; -- at 260nS
		enout32 <= '1';
		
		-- finally test the shift_register
		datain <= X"5A5A5A5A";
		dir <= '0'; -- left
		shamt <= "00001"; -- by 1 bits should be 0xB4B4B4B4
		wait for 5 ns; -- at 265nS
		dir <= '1'; -- right
		shamt <= "00010"; -- by 2 bits should be 0x16969696
		wait for 5 ns; -- at 270nS
		dir <= '1'; -- right again
		shamt <= "00011"; -- by 3 bits should be 0x0B4B4B4B
		wait for 5 ns; -- at 275nS
		dir <= '0'; -- left
		shamt <= "00001"; -- by 1 bits should be 0xB4B4B4B4
		wait for 5 ns; -- at 280nS

		wait; -- will wait forever
	END PROCESS;

END;
