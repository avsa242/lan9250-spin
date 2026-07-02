{                                                                                                       
----------------------------------------------------------------------------------------------------
    Filename:       core.con.lan9250.spin2
    Description:    LAN9250-specific constants
    Author:         Jesse Burt
    Started:        Jul 27, 2025
    Updated:        Jul 2, 2026
    Copyright (c) 2026 - See end of file for terms of use.
----------------------------------------------------------------------------------------------------
}

con

    ' SPI configuration
    SPI_MODE            = 0
    SPI_MAX_FREQ        = 80_000_000


    ' Commands/Instructions
    WRITE               = $02
    READ                = $03


    ' multiple read/write - address increment
    AUTO_DIS            = %0000_0000            ' included for symbolism only
    AUTO_INC            = %0100_0000
    AUTO_DEC            = %1000_0000


    ' frame write
    '   TX Command A
    IOC                     = 31
    BUFFEND_ALIGN           = 24'..25
    DSTART_OFFS             = 16'..20
    FS                      = 13
    LS                      = 12
    BUFFSZ                  = 0'..10
    CMD_A_INT_ON_COMP       = 1 << IOC
    CMD_A_ALIGN_4B          = %00 << BUFFEND_ALIGN
    CMD_A_ALIGN_16B         = %01 << BUFFEND_ALIGN
    CMD_A_ALIGN_32B         = %10 << BUFFEND_ALIGN
    DSTART_OFFS_BITS        = %11111
    CMD_A_FS                = 1 << FS
    CMD_A_LS                = 1 << LS

    '   TX Command B
    PACKET_TAG              = 16'..31
    CK                      = 14
    ADD_CRC_DIS             = 13
    ETH_FRM_PAD_DIS         = 12
    PKT_LEN                 = 0'..10
    CMD_B_PACKET_TAG        = 1 << PACKET_TAG
    CMD_B_CK                = 1 << CK
    CMD_B_ADD_CRC_DIS       = 1 << ADD_CRC_DIS
    CMD_B_ETH_FRM_PAD_DIS   = 1 << ETH_FRM_PAD_DIS

    '   TX Status
    PACKET_TAG          = 16'..31
    ERROR_STATUS        = 15
    LOST_CARRIER        = 11
    NO_CARRIER          = 10
    LATE_COLLISION      = 9
    EXCESS_COLLISIONS   = 8
    COLLISION_CNT       = 3'..6
    EXCESS_DEFERRAL     = 2
    DEFERRED            = 0


    ' frame read
    '   RX status
    PKT_FILTER          = 31
    FILTER_FAIL         = 30
    RX_PKT_LEN          = 16'..29
    ERROR_STATUS        = 15
    BCAST_FRAME         = 13
    LEN_ERROR           = 12
    RUNT_FRAME          = 11
    MCAST_FRAME         = 10
    FRAME_TOO_LONG      = 7
    COLLISION_SEEN      = 6
    FRAME_TYPE          = 5
        FT_ETH          = 1
        FT_802_3        = 0
    RX_WD_TIMEOUT       = 4
    MII_ERROR           = 3
    DRIBBLING_BIT       = 2
    CRC_ERROR           = 1


    ' Registers
    RX_DATA_FIFO        = $0000
    TX_DATA_FIFO        = $0020

    RX_STATUS_FIFO      = $040
    RX_STATUS_FIFO_PEEK = $044
    TX_STATUS_FIFO      = $048
    TX_STATUS_FIFO_PEEK = $04c

    ID_REV              = $050

    IRQ_CFG             = $054
    IRQ_CFG_MASK        = $ff00_7113
        IRQ_CFG_INT_DEAS        = 24'..31
        IRQ_CFG_INT_DEAS_CLR    = 14
        IRQ_CFG_INT_DEAS_STS    = 13
        IRQ_CFG_IRQ_INT         = 12
        IRQ_CFG_IRQ_EN          = 8
        IRQ_CFG_INT_POL         = 4
        IRQ_CFG_IRQ_CLK_SELECT  = 1
        IRQ_CFG_IRQ_TYPE        = 0
        INT_DEAS                = 1 << IRQ_CFG_INT_DEAS
        INT_DEAS_CLR            = 1 << IRQ_CFG_INT_DEAS_CLR
        INT_DEAS_STS            = 1 << IRQ_CFG_INT_DEAS_STS
        IRQ_EN                  = 1 << IRQ_CFG_IRQ_EN
        INT_POL                 = 1 << IRQ_CFG_INT_POL
        IRQ_CLK_SELECT          = 1 << IRQ_CFG_IRQ_CLK_SELECT
        IRQ_TYPE                = 1 << IRQ_CFG_IRQ_TYPE
        INT_DEAS_BITS   = $ff
        INT_DEAS_MASK   = (INT_DEAS_BITS << IRQ_CFG_INT_DEAS) ^ IRQ_CFG_MASK
        IRQ_EN_MASK     = (1 << IRQ_CFG_IRQ_EN) ^ IRQ_CFG_MASK
        INT_POL_MASK    = (1 << IRQ_CFG_INT_POL) ^ IRQ_CFG_MASK
        IRQ_TYPE_MASK   = (1 << IRQ_CFG_IRQ_TYPE) ^ IRQ_CFG_MASK

    INT_STS             = $058
    INT_STS_MASK        = $e7bb_f7d8
    INT_STS_CLEAR_MASK  = $c3bb_e7d8

    INT_EN              = $05c
    INT_EN_MASK         = INT_STS_MASK
        SW_INT_EN       = 31
        READY_EN        = 30
        EVNT_1588_EN    = 29
        PHY_INT_EN      = 26
        TXSTOP_INT_EN   = 25
        RXSTOP_INT_EN   = 24
        RXDFH_INT_EN    = 23
        TIOC_INT_EN     = 21
        RXD_INT_EN      = 20
        GPT_INT_EN      = 19
        PME_INT_EN      = 17
        TXSO_EN         = 16
        RWT_INT_EN      = 15
        RXE_INT_EN      = 14
        TXE_INT_EN      = 13
        GPIO_EN         = 12
        TDFO_EN         = 10
        TDFA_EN         = 9
        TSFF_EN         = 8
        TSFL_EN         = 7
        RXDF_INT_EN     = 6
        RSSFF_EN        = 4
        RSFL_EN         = 3

    BYTE_TEST           = $064

    FIFO_INT            = $068
    FIFO_INT_MASK       = $ffff_00ff
        TX_DAL          = 24
        TX_SL           = 16
        RX_SL           = 0

    RX_CFG              = $06c
    RX_CFG_MASK         = $cfff_9f00
        RX_EA           = 30'..31
        RX_DMA_CNT      = 16'..27
        RX_DUMP         = 15                    ' WO, SC
        RXDOFF          = 8'..12
        RX_DMA_CNT_BITS = $7ff
        RX_DMA_CNT_MASK = (RX_DMA_CNT_BITS << RX_DMA_CNT) ^ RX_CFG_MASK
        RXDOFF_BITS     = %11111
        RXDOFF_MASK     = (RXDOFF_BITS << RXDOFF) ^ RX_CFG_MASK

    TX_CFG              = $070
    TX_CFG_MASK         = $0000_c007
        TXS_DUMP        = 15
        TXD_DUMP        = 14
        TXSAO           = 2
        TX_ON           = 1
        STOP_TX         = 0
        TXSAO_MASK      = (1 << TXSAO) ^ TX_CFG_MASK
        ALLOW_TXS_OR    = (1 << TXSAO)
        TX_ON_MASK      = (1 << TX_ON) ^ TX_CFG_MASK
        TX_ENABLED      = (1 << TX_ON)


    HW_CFG              = $074
        READY           = 27
        AMDIX_EN        = 25
        MBO1            = 20
        TX_FIF_SZ       = 16
        TX_FIF_SZ_BITS  = %1111
        MBO             = (1 << MBO1)


    RX_DP_CTRL          = $078
    RX_DP_CTRL_MASK     = $8000_0000
        RX_FFWD_BIT     = 31                    ' R/W, SC
        RX_FFWD         = (1 << RX_FFWD_BIT)

    RX_FIFO_INF         = $07c
    RX_FIFO_INF_MASK    = $00ff_ffff
        RXSUSED         = 16'..23
        RXDUSED         = 0'..15
        RXSUSED_BITS    = $ff
        RXDUSED_BITS    = $ffff

    TX_FIFO_INF         = $080
    TX_FIFO_INF_MASK    = $00ff_ffff
        TXSUSED         = 16'..23
        TXFREE          = 0'..15
        TXSUSED_BITS    = $ff
        TXFREE_BITS     = $ffff

    PMT_CTRL            = $084
    PMT_CTRL_MASK       = $fe4d_426f
        PM_MODE         = 29'..31
        PM_SLEEP_EN     = 28
        PM_WAKE         = 27
        LED_DIS         = 26
        DIS_1588        = 25
        DIS_TSU_1588    = 22
        HMAC_DIS        = 19
        HMAC_SYS_ONLY_DIS   = 18
        ED_STS              = 16
        ED_EN               = 14
        WOL_EN              = 9
        PME_TYPE            = 6
        WOL_STS             = 5
        PME_IND             = 3
        PME_POL             = 2
        PME_EN              = 1
        DEV_READY           = 0
        PM_MODE_BITS        = %111
        PM_MODE_MASK        = (PM_MODE_BITS << PM_MODE) ^ PMT_CTRL_MASK
        PME_EN_MASK         = (1 << PME_EN) ^ PMT_CTRL_MASK
        PMT_EN_BITS         =   (1 << WOL_EN) | (1 << ED_EN) | ...
                                (1 << HMAC_SYS_ONLY_DIS) | (1 << HMAC_DIS) | ...
                                (1 << DIS_TSU_1588) | (1 << DIS_1588) | (1 << LED_DIS) | ...
                                (1 << PM_WAKE)
        PMT_EN_MASK         = (PMT_EN_BITS ^ PMT_CTRL_MASK)

    GPT_CFG             = $08c

    GPT_CNT             = $090

    FREE_RUN            = $09c

    RX_DROP             = $0a0                  ' RC

    MAC_CSR_CMD         = $0a4
    MAC_CSR_CMD_MASK    = $c000_00ff
        HMAC_CSR_BUSY   = 31
        CSR_BUSY        = (1 << HMAC_CSR_BUSY)
        HMAC_CSR_BUSY_MASK  = (1 << HMAC_CSR_BUSY) ^ MAC_CSR_CMD_MASK
        RNW             = 30
        CSR_READ        = (1 << RNW)
        CSR_WRITE       = (0 << RNW)
        CSR_ADDRESS     = 0'..7


    MAC_CSR_DATA        = $0a8

    AFC_CFG             = $0ac
    AFC_CFG_MASK        = $00ff_ffff
        AFC_HI          = 16'..23
        AFC_LO          = 8'..15
        BACK_DUR        = 4'..7
        FCMULT          = 3
        FCBRD           = 2
        FCADD           = 1
        FCANY           = 0
        AFC_HI_BITS     = $ff
        AFC_HI_MASK     = (AFC_HI_BITS << AFC_HI) ^ AFC_CFG_MASK
        AFC_LO_BITS     = $ff
        AFC_LO_MASK     = (AFC_LO_BITS << AFC_LO) ^ AFC_CFG_MASK
        BACK_DUR_BITS   = $0f
        BACK_DUR_MASK   = (BACK_DUR_BITS << BACK_DUR) ^ AFC_CFG_MASK
        FCMULT_MASK     = (1 << FCMULT) ^ AFC_CFG_MASK
        FCBRD_MASK      = (1 << FCBRD) ^ AFC_CFG_MASK
        FCADD_MASK      = (1 << FCADD) ^ AFC_CFG_MASK
        FCANY_MASK      = (1 << FCANY) ^ AFC_CFG_MASK
        FCFRAME_BITS    = (1 << FCMULT) | (1 << FCBRD) | (1 << FCADD) | (1 << FCANY)
        FCFRAME_MASK    = FCFRAME_BITS ^ AFC_CFG_MASK


    HMAC_RX_LPI_TRANS   = $0b0

    HMAC_RX_LPI_TIME    = $0b4

    HMAC_TX_LPI_TRANS   = $0b8

    HMAC_TX_LPI_TIME    = $0bc

    LED_CFG             = $1bc

    GPIO_CFG            = $1e0

    GPIO_DATA_DIR       = $1e4

    GPIO_INT_STS_EN     = $1e8

    RESET_CTL           = $1f8
        HMAC_RST        = 5
        PHY_RST         = 1
        DIGITAL_RST     = 0
        RESET_HMAC      = 1 << HMAC_RST
        RESET_PHY       = 1 << PHY_RST
        RESET_DIGITAL   = 1

    ' host MAC control, status regs (use MAC_CSR_CMD to read from or write to)
    HMAC_CR             = $01
    HMAC_CR_MASK        = $82bf_adec
        RXALL           = 31
        HMAC_EEE_ENABLE = 25
        RCVOWN          = 23
        LOOPBK          = 21
        FDPX            = 20
        MCPAS           = 19
        PRMS            = 18
        INVFILT         = 17
        PASSBAD         = 16
        HO              = 15
        HPFILT          = 13
        BCAST           = 11
        DISRTY          = 10
        PADSTR          = 8
        BOLMT           = 6'..7
        DFCHK           = 5
        TXEN            = 3
        RXEN            = 2
        HPFILT_MASK     = (1 << HPFILT) ^ HMAC_CR_MASK
        RCVOWN_MASK     = (1 << RCVOWN) ^ HMAC_CR_MASK
        FDPX_MASK       = (1 << FDPX) ^ HMAC_CR_MASK
        PADSTR_MASK     = (1 << PADSTR) ^ HMAC_CR_MASK
        TXEN_MASK       = (1 << TXEN) ^ HMAC_CR_MASK
        RXEN_MASK       = (1 << RXEN) ^ HMAC_CR_MASK
        MAC_TX_ENA      = (1 << TXEN)
        MAC_RX_ENA      = (1 << RXEN)


    HMAC_ADDRH          = $02
    HMAC_ADDRH_MASK     = $0000_ffff
        MACADDRH        = 0'..15

    HMAC_ADDRL          = $03
    HMAC_ADDRL_MASK     = $ffff_ffff
        MACADDRL        = 0'..31

    HMAC_HASHH          = $04

    HMAC_HASHL          = $05

    HMAC_MII_ACC        = $06
    HMAC_MII_ACC_MASK   = $0000_ffc3
        PHY_ADDR        = 11'..15
        MIIRINDA        = 6'..10
        MIIWNR          = 1
        MIIBZY          = 0                     ' R/O, S/C
        MIIRINDA_BITS   = %11111
        PHY_ADDR_DEF    = (1 << PHY_ADDR)
        PHY_ADDR_BITS   = %11111
        PHY_ADDR_MASK   = (PHY_ADDR_BITS << PHY_ADDR) ^ HMAC_MII_ACC_MASK
        MII_WRITE       = (1 << MIIWNR)
        MII_READ        = (0 << MIIWNR)
        MII_BUSY        = (1 << MIIBZY)


    HMAC_MII_DATA       = $07
    HMAC_MII_DATA_MASK  = $0000_ffff

    HMAC_FLOW           = $08
    HMAC_FLOW_MASK      = $ffff_0007
        FCPT            = 16'..31
        FCPASS          = 2
        FCEN            = 1
        FCBSY           = 0                     ' R/W, S/C


    HMAC_VLAN1          = $09
    HMAC_VLAN1_MASK     = $0000_ffff
        VTI1            = 0'..15

    HMAC_VLAN2          = $0a
    HMAC_VLAN2_MASK     = $0000_ffff
        VTI2            = 0'..15

    HMAC_WUFF           = $0b

    HMAC_WUCSR          = $0c
    HMAC_WUCSR_MASK     = $8000_03ff
        WFF_PTR_RST     = 31
        GUE             = 9
        WOL_WAIT_SLEEP  = 8
        PFDA_FR         = 7
        WUFR            = 6
        MPR             = 5
        BCAST_FR        = 4
        PFDA_EN         = 3
        WUEN            = 2
        MPEN            = 1
        BCST_EN         = 0

    HMAC_COE_CR         = $0d
    HMAC_COE_CR_MASK    = $0001_0003
        TX_COE_EN       = 16
        RX_COE_MODE     = 1
        RX_COE_EN       = 0

    HMAC_EEE_TW_TX_SYS  = $0e
    HMAC_EEE_TW_TX_SYS_MASK = $00ff_ffff


    HMAC_EEE_TX_LPI_REQ_DLY = $0f


    ' PHY registers
    PHY_BASIC_CONTROL       = 0
    PHY_BASIC_CONTROL_MASK  = $fb80
        PHY_SPEED_SEL_LSB   = 13
        PHY_AN              = 12
        PHY_DUPLEX          = 8
        PHY_SPEED_SEL_LSB_MASK  = (1 << PHY_SPEED_SEL_LSB) ^ PHY_BASIC_CONTROL_MASK
        PHY_DUPLEX_MASK     = (1 << PHY_DUPLEX) ^ PHY_BASIC_CONTROL_MASK
        PHY_AN_MASK         = (1 << PHY_AN) ^ PHY_BASIC_CONTROL_MASK

    PHY_BASIC_STATUS        = 1
        AUTONEG_COMPLETE    = 5
        LINK_STATE          = 2

    PHY_ID_MSB              = 2
    PHY_ID_LSB              = 3

    PHY_AN_ADV              = 4
    PHY_AN_ADV_REGMASK      = $bdff
        ADV_ASYMMETRIC_PAUSE= 11
        ADV_SYMMETRIC_PAUSE = 10
        ADV_100BASEX_FDPX   = 8
        ADV_100BASEX_HDPX   = 7
        ADV_10BASET_FDPX    = 6
        ADV_10BASET_HDPX    = 5
        ADV_SELECTOR        = 0
        ADV_SELECTOR_BITS   = %11111
        SEL_IEEE802_3       = %00001
        ADV_ASYMMETRIC_PAUSE_MASK   = (1 << ADV_ASYMMETRIC_PAUSE) ^ PHY_AN_ADV_REGMASK
        ADV_SYMMETRIC_PAUSE_MASK    = (1 << ADV_SYMMETRIC_PAUSE) ^ PHY_AN_ADV_REGMASK
        ADV_100BASEX_FDPX_MASK      = (1 << ADV_100BASEX_FDPX) ^ PHY_AN_ADV_REGMASK
        ADV_100BASEX_HDPX_MASK      = (1 << ADV_100BASEX_HDPX) ^ PHY_AN_ADV_REGMASK
        ADV_10BASET_FDPX_MASK       = (1 << ADV_10BASET_FDPX) ^ PHY_AN_ADV_REGMASK
        ADV_10BASET_HDPX_MASK       = (1 << ADV_10BASET_HDPX) ^ PHY_AN_ADV_REGMASK
        ADV_SELECTOR_MASK           = ADV_SELECTOR_BITS ^ PHY_AN_ADV_REGMASK

    PHY_AN_LP_BASE_ABILITY  = 5
    PHY_AN_EXP              = 6
    PHY_AN_NP_TX            = 7
    PHY_AN_NP_RX            = 8
    PHY_MMD_ACCESS          = 13
    PHY_MMD_ADDR_DATA       = 14
    PHY_EDPD_CFG            = 16
    PHY_MODE_CONTROL_STATUS = 17

    PHY_SPECIAL_MODES       = 18
    PHY_SPECIAL_MODES_MASK  = $04ff
        PHY_MODE            = 5'..7
        PHY_ADD             = 0'..4
        PHY_MODE_BITS       = %111
        PHY_MODE_MASK       = (PHY_MODE_BITS << PHY_MODE) ^ PHY_SPECIAL_MODES_MASK
        PHY_ADD_BITS        = %11111
        PHY_ADD_MASK        = PHY_ADD_BITS ^ PHY_SPECIAL_MODES_MASK

    PHY_TDR_PAT_DELAY       = 24
    PHY_TDR_CONTROL_STAT    = 25
    PHY_SYMBOL_ERR_CNT      = 26

    PHY_SPECIAL_CTRL_STAT_IND   = 27
    PHY_SPECIAL_CTRL_STAT_IND_MASK  = $e830
        AMDIXCTRL                   = 15
        AMDIXEN                     = 14
        AMDIXSTATE                  = 13
        AMDIX                       = 13
        SQEOFF                      = 11
        AMDIXCTRL_MASK              = (1 << AMDIXCTRL) ^ PHY_SPECIAL_CTRL_STAT_IND_MASK
        AMDIX_BITS                  = %11
        AMDIX_MASK                  = (AMDIX_BITS << AMDIX) ^ PHY_SPECIAL_CTRL_STAT_IND_MASK
        SQEOFF_MASK                 = (1 << SQEOFF) ^ PHY_SPECIAL_CTRL_STAT_IND_MASK

    PHY_CABLE_LEN               = 28
    PHY_INT_SRC                 = 29

    PHY_INT_MASK                = 30
    PHY_INT_MASK_REGMASK        = $02fe
        INT9_LINK_UP            = 9
        INT7_ENERGY_ON          = 7
        INT4_LINK_DOWN          = 4

    PHY_SPECIAL_CTRL_STATUS             = 31
    PHY_SPECIAL_CTRL_STATUS_MASK        = $101c
        AUTODONE                        = 12
        PHY_SPECIAL_CTRL_STATUS_RES     = 5
        SPEED_IND                       = 2
        SPEED_IND_BITS                  = %111
        PHY_SPECIAL_CTRL_STATUS_RES_BITS= %000_0010
        PHY_SPECIAL_CTRL_STATUS_RES_MASK= (%111_1111 << PHY_SPECIAL_CTRL_STATUS_RES) ^ PHY_SPECIAL_CTRL_STATUS_MASK
        PHY_SPECIAL_RESERVED            = %10 << PHY_SPECIAL_CTRL_STATUS_RES


dat
{
Copyright 2026 Jesse Burt

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
}

