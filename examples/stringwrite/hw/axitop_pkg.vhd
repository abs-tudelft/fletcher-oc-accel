-- Copyright 2018 Delft University of Technology
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

package Axitop_pkg is
  component AxiTop is
    generic (
    INDEX_WIDTH                 : natural := 32;
    REG_WIDTH                   : natural := 32;
    TAG_WIDTH                   : natural := 1;
    BUS_ADDR_WIDTH              : natural := 64;
    BUS_DATA_WIDTH              : natural := 512;
    BUS_LEN_WIDTH               : natural := 8;
    BUS_BURST_MAX_LEN           : natural := 64;
    BUS_BURST_STEP_LEN          : natural := 1
    );
    port (
      kcd_clk                     : in  std_logic;
      kcd_reset                   : in  std_logic;
      bcd_clk                     : in  std_logic;
      bcd_reset                   : in  std_logic;
      m_axi_araddr                : out std_logic_vector(BUS_ADDR_WIDTH-1 downto 0);
      m_axi_arlen                 : out std_logic_vector(7 downto 0);
      m_axi_arvalid               : out std_logic := '0';
      m_axi_arready               : in  std_logic;
      m_axi_arsize                : out std_logic_vector(2 downto 0);
      m_axi_rdata                 : in  std_logic_vector(BUS_DATA_WIDTH-1 downto 0);
      m_axi_rresp                 : in  std_logic_vector(1 downto 0);
      m_axi_rlast                 : in  std_logic;
      m_axi_rvalid                : in  std_logic;
      m_axi_rready                : out std_logic := '0';
      m_axi_awvalid               : out std_logic := '0';
      m_axi_awready               : in  std_logic;
      m_axi_awaddr                : out std_logic_vector(BUS_ADDR_WIDTH-1 downto 0);
      m_axi_awlen                 : out std_logic_vector(7 downto 0);
      m_axi_awsize                : out std_logic_vector(2 downto 0);
      m_axi_wvalid                : out std_logic := '0';
      m_axi_wready                : in  std_logic;
      m_axi_wdata                 : out std_logic_vector(BUS_DATA_WIDTH-1 downto 0);
      m_axi_wlast                 : out std_logic;
      m_axi_wstrb                 : out std_logic_vector(BUS_DATA_WIDTH/8-1 downto 0);
      m_axi_bvalid                : in  std_logic;
      m_axi_bready                : out std_logic;
      m_axi_bresp                 : in  std_logic_vector(1 downto 0);
      s_axi_awvalid               : in std_logic;
      s_axi_awready               : out std_logic;
      s_axi_awaddr                : in std_logic_vector(32-1 downto 0);
      s_axi_wvalid                : in std_logic;
      s_axi_wready                : out std_logic;
      s_axi_wdata                 : in std_logic_vector(32-1 downto 0);
      s_axi_wstrb                 : in std_logic_vector((32/8)-1 downto 0);
      s_axi_bvalid                : out std_logic;
      s_axi_bready                : in std_logic;
      s_axi_bresp                 : out std_logic_vector(1 downto 0);
      s_axi_arvalid               : in std_logic;
      s_axi_arready               : out std_logic;
      s_axi_araddr                : in std_logic_vector(32-1 downto 0);
      s_axi_rvalid                : out std_logic;
      s_axi_rready                : in std_logic;
      s_axi_rdata                 : out std_logic_vector(32-1 downto 0);
      s_axi_rresp                 : out std_logic_vector(1 downto 0)
    );
  end component;
end Axitop_pkg;
