library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity axim_snooper_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line

        -- Parameters of the Input Axi Slave Bus Interface S01_AXI
        C_S01_AXI_DATA_WIDTH    : integer   := 32;
        C_S01_AXI_ADDR_WIDTH    : integer   := 32;

        --For the Master Interface (Output) M00_AXI
        C_M00_AXI_DATA_WIDTH    : integer   := 32;
        C_M00_AXI_ADDR_WIDTH    : integer   := 32;

		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 32
	);
	port (

        --input_slave
        s01_axi_aclk    : in std_logic;
        s01_axi_aresetn : in std_logic;
        s01_axi_awaddr  : in std_logic_vector(C_S01_AXI_ADDR_WIDTH-1 downto 0);
        s01_axi_awprot  : in std_logic_vector(2 downto 0);
        s01_axi_awvalid : in std_logic;
        s01_axi_awready : out std_logic;
        s01_axi_wdata   : in std_logic_vector(C_S01_AXI_DATA_WIDTH-1 downto 0);
        s01_axi_wstrb   : in std_logic_vector((C_S01_AXI_DATA_WIDTH/8)-1 downto 0);
        s01_axi_wvalid  : in std_logic;
        s01_axi_wready  : out std_logic;
        s01_axi_bresp   : out std_logic_vector(1 downto 0);
        s01_axi_bvalid  : out std_logic;
        s01_axi_bready  : in std_logic;
        s01_axi_araddr  : in std_logic_vector(C_S01_AXI_ADDR_WIDTH-1 downto 0);
        s01_axi_arprot  : in std_logic_vector(2 downto 0);
        s01_axi_arvalid : in std_logic;
        s01_axi_arready : out std_logic;
        s01_axi_rdata   : out std_logic_vector(C_S01_AXI_DATA_WIDTH-1 downto 0);
        s01_axi_rresp   : out std_logic_vector(1 downto 0);
        s01_axi_rvalid  : out std_logic;
        s01_axi_rready  : in std_logic;

        --output_master
        m00_axi_init_axi_txn    : in std_logic;
        m00_axi_error   : out std_logic;
        m00_axi_txn_done    : out std_logic;
        m00_axi_aclk    : in std_logic;
        m00_axi_aresetn : in std_logic;
        m00_axi_awaddr  : out std_logic_vector(C_M00_AXI_ADDR_WIDTH-1 downto 0);
        m00_axi_awprot  : out std_logic_vector(2 downto 0);
        m00_axi_awvalid : out std_logic;
        m00_axi_awready : in std_logic;
        m00_axi_wdata   : out std_logic_vector(C_M00_AXI_DATA_WIDTH-1 downto 0);
        m00_axi_wstrb   : out std_logic_vector(C_M00_AXI_DATA_WIDTH/8-1 downto 0);
        m00_axi_wvalid  : out std_logic;
        m00_axi_wready  : in std_logic;
        m00_axi_bresp   : in std_logic_vector(1 downto 0);
        m00_axi_bvalid  : in std_logic;
        m00_axi_bready  : out std_logic;
        m00_axi_araddr  : out std_logic_vector(C_M00_AXI_ADDR_WIDTH-1 downto 0);
        m00_axi_arprot  : out std_logic_vector(2 downto 0);
        m00_axi_arvalid : out std_logic;
        m00_axi_arready : in std_logic;
        m00_axi_rdata   : in std_logic_vector(C_M00_AXI_DATA_WIDTH-1 downto 0);
        m00_axi_rresp   : in std_logic_vector(1 downto 0);
        m00_axi_rvalid  : in std_logic;
        m00_axi_rready  : out std_logic;

		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end axim_snooper_v1_0;

architecture arch_imp of axim_snooper_v1_0 is

	-- component declaration
	component axim_snooper_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		ARVALID_INPUT	: in std_logic;
		AWVALID_INPUT	: in std_logic;
		AXIM_RADDR_INPUT : in std_logic_vector(31 downto 0);
		AXIM_WADDR_INPUT : in std_logic_vector(31 downto 0);
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component axim_snooper_v1_0_S00_AXI;

signal patch_axi_aclk           :   std_logic;
signal patch_axi_aresertn       :   std_logic;
signal patch_axi_awaddr         :   std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
signal patch_axi_awprot         :   std_logic_vector(2 downto 0);
signal patch_axi_awvalid        :   std_logic;
signal patch_axi_awready        :   std_logic;
signal patch_axi_wdata          :   std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
signal patch_axi_wstrb          :   std_logic_vector(C_S00_AXI_DATA_WIDTH/8-1 downto 0);
signal patch_axi_wvalid         :   std_logic;
signal patch_axi_wready         :   std_logic;
signal patch_axi_bresp          :   std_logic_vector(1 downto 0);
signal patch_axi_bvalid         :   std_logic;
signal patch_axi_bready         :   std_logic;
signal patch_axi_araddr         :   std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
signal patch_axi_arprot         :   std_logic_vector(2 downto 0);
signal patch_axi_arvalid        :   std_logic;
signal patch_axi_arready        :   std_logic;
signal patch_axi_rdata          :   std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
signal patch_axi_rresp          :   std_logic_vector(1 downto 0);
signal patch_axi_rvalid         :   std_logic;

begin

-- Instantiation of Axi Bus Interface S00_AXI
axim_snooper_v1_0_S00_AXI_inst : axim_snooper_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
		ARVALID_INPUT => patch_axi_arvalid,
		AWVALID_INPUT => patch_axi_awvalid,
		AXIM_RADDR_INPUT => patch_axi_araddr,
		AXIM_WADDR_INPUT => patch_axi_awaddr,
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

	-- Add user logic here
    --Patching signals to allow passthrough of AXI signals
    --These are the signals that we will tap and look at as they pass through.
    
    --Putting the AXI slave signals into the Patch signals
    --patch_axi_aclk <= s01_axi_aclk;
    --patch_axi_aresetn <= s01_axi_aresetn;
    patch_axi_awaddr <= s01_axi_awaddr;
    patch_axi_awprot <= s01_axi_awprot;
    patch_axi_awvalid <= s01_axi_awvalid;
    s01_axi_awready <= patch_axi_awready;
    patch_axi_wdata <= s01_axi_wdata;
    patch_axi_wstrb <= s01_axi_wstrb;
    patch_axi_wvalid <= s01_axi_wvalid;
    s01_axi_wready <= patch_axi_wready;
    s01_axi_bresp <= patch_axi_bresp;
    s01_axi_bvalid <= patch_axi_bvalid;
    patch_axi_bready <= s01_axi_bready;
    patch_axi_araddr <= s01_axi_araddr;
    patch_axi_arprot <= s01_axi_arprot;
    patch_axi_arvalid <= s01_axi_arvalid;
    s01_axi_arready <= patch_axi_arready;
    s01_axi_rdata <= patch_axi_rdata;
    s01_axi_rresp <= patch_axi_rresp;
    s01_axi_rvalid <= patch_axi_rvalid;
    patch_axi_rready <= s01_axi_rready;

    m00_axi_awaddr <= patch_axi_awaddr;
    m00_axi_awprot <= patch_axi_awprot;
    m00_axi_awvalid <= patch_axi_awvalid;
    patch_axi_awready <= m00_axi_awready;
    m00_axi_wdata <= patch_axi_wdata;
    m00_axi_wstrb <= patch_axi_wstrb;
    m00_axi_wvalid <= patch_axi_wvalid;
    patch_axi_wready <= m00_axi_wready;
    patch_axi_bresp <= m00_axi_bresp;
    patch_axi_bvalid <= m00_axi_bvalid;
    m00_axi_bready <= patch_axi_bready;
    m00_axi_araddr <= patch_axi_araddr;
    m00_axi_arprot <= patch_axi_arprot;
    m00_axi_arvalid <= patch_axi_arvalid;
    patch_axi_arready <= m00_axi_arready;
    patch_axi_rdata <= m00_axi_rdata;
    patch_axi_rresp <= m00_axi_rresp;
    patch_axi_rvalid <= m00_axi_rvalid;
    m00_axi_rready <= patch_axi_rready;

    --Passing the patch signals into the master ports


	-- User logic ends

end arch_imp;
