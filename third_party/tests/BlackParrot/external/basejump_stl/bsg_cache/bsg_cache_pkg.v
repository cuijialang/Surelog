/**
 *  bsg_cache_pkg.v
 *  
 *  @author tommy
 */

package bsg_cache_pkg;

  // cache opcode
  //
  typedef enum logic [4:0] {
    LB = 5'b00000         // load byte
    ,LH = 5'b00001        // load half
    ,LW = 5'b00010        // load word
    ,LD = 5'b00011        // load double (reserved)
    ,LM = 5'b00100        // load mask
    ,SB = 5'b01000        // store byte
    ,SH = 5'b01001        // store half
    ,SW = 5'b01010        // store word
    ,SD = 5'b01011        // store double (reserved)
    ,SM = 5'b01100        // store mask
    ,TAGST = 5'b10000     // tag store
    ,TAGFL = 5'b10001     // tag flush
    ,TAGLV = 5'b10010     // tag load valid
    ,TAGLA = 5'b10011     // tag load address
    ,AFL = 5'b11000       // address flush
    ,AFLINV = 5'b11001    // address flush invalidate
    ,AINV = 5'b11010      // address invalidate
  } bsg_cache_opcode_e;

  // bsg_cache_pkt_s
  //
  `define declare_bsg_cache_pkt_s(addr_width_mp, data_width_mp)   \
    typedef struct packed {                                     \
      logic sigext;                                             \
      logic [(data_width_mp>>3)-1:0] mask;                       \
      bsg_cache_opcode_e opcode;                                \
      logic [addr_width_mp-1:0] addr;                            \
      logic [data_width_mp-1:0] data;                            \
    } bsg_cache_pkt_s

  `define bsg_cache_pkt_width(addr_width_mp, data_width_mp) \
    (1+(data_width_mp>>3)+5+addr_width_mp+data_width_mp)

  // bsg_cache_dma_pkt_s
  //
  `define declare_bsg_cache_dma_pkt_s(addr_width_mp) \
    typedef struct packed {                         \
      logic write_not_read;                         \
      logic [addr_width_mp-1:0] addr;                \
    } bsg_cache_dma_pkt_s

  `define bsg_cache_dma_pkt_width(addr_width_mp)    \
    (1+addr_width_mp)

  // dma opcode (one-hot)
  //
  typedef enum logic [3:0] {
    e_dma_nop               = 4'b0000
    ,e_dma_send_fill_addr   = 4'b0001
    ,e_dma_send_evict_addr  = 4'b0010
    ,e_dma_get_fill_data    = 4'b0100
    ,e_dma_send_evict_data  = 4'b1000
  } bsg_cache_dma_cmd_e;


endpackage
