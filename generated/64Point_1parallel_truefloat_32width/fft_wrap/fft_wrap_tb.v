module fft_wrap_testbench;

// Declare the inputs and outputs of fft_wrap module
reg clock;
reg reset;
reg io_start;
wire io_done;
reg [63:0] io_pargs, io_pdata, io_pres;
reg [31:0] io_args_len, io_data_len;
wire [31:0] io_ap_return;
wire [63:0] io_m_axi_gmem_AWADDR;
wire [7:0] io_m_axi_gmem_AWLEN;
wire [2:0] io_m_axi_gmem_AWSIZE;
wire [1:0] io_m_axi_gmem_AWBURST, io_m_axi_gmem_AWLOCK;
wire [3:0] io_m_axi_gmem_AWREGION, io_m_axi_gmem_AWCACHE, io_m_axi_gmem_AWPROT, io_m_axi_gmem_AWQOS;
wire io_m_axi_gmem_AWVALID;
wire io_m_axi_gmem_AWREADY;
wire [255:0] io_m_axi_gmem_WDATA;
wire [31:0] io_m_axi_gmem_WSTRB;
wire io_m_axi_gmem_WLAST, io_m_axi_gmem_WVALID;
wire io_m_axi_gmem_WREADY;
wire [1:0] io_m_axi_gmem_BRESP;
wire io_m_axi_gmem_BVALID;
wire io_m_axi_gmem_BREADY;
wire [63:0] io_m_axi_gmem_ARADDR;
wire [7:0] io_m_axi_gmem_ARLEN;
wire [2:0] io_m_axi_gmem_ARSIZE;
wire [1:0] io_m_axi_gmem_ARBURST, io_m_axi_gmem_ARLOCK;
wire [3:0] io_m_axi_gmem_ARREGION, io_m_axi_gmem_ARCACHE, io_m_axi_gmem_ARPROT, io_m_axi_gmem_ARQOS;
wire io_m_axi_gmem_ARVALID;
reg io_m_axi_gmem_ARREADY;
reg [255:0] io_m_axi_gmem_RDATA;
wire [1:0] io_m_axi_gmem_RRESP;
reg io_m_axi_gmem_RLAST, io_m_axi_gmem_RVALID;
wire io_m_axi_gmem_RREADY;

// Instantiate the fft_wrap module
fft_wrap DUT (
    .clock(clock),
    .reset(reset),
    .io_start(io_start),
    .io_done(io_done),
    .io_pargs(io_pargs),
    .io_pdata(io_pdata),
    .io_pres(io_pres),
    .io_args_len(io_args_len),
    .io_data_len(io_data_len),
    .io_ap_return(io_ap_return),
    .io_m_axi_gmem_AWADDR(io_m_axi_gmem_AWADDR),
    .io_m_axi_gmem_AWLEN(io_m_axi_gmem_AWLEN),
    .io_m_axi_gmem_AWSIZE(io_m_axi_gmem_AWSIZE),
    .io_m_axi_gmem_AWBURST(io_m_axi_gmem_AWBURST),
    .io_m_axi_gmem_AWLOCK(io_m_axi_gmem_AWLOCK),
    .io_m_axi_gmem_AWREGION(io_m_axi_gmem_AWREGION),
    .io_m_axi_gmem_AWCACHE(io_m_axi_gmem_AWCACHE),
    .io_m_axi_gmem_AWPROT(io_m_axi_gmem_AWPROT),
    .io_m_axi_gmem_AWQOS(io_m_axi_gmem_AWQOS),
    .io_m_axi_gmem_AWVALID(io_m_axi_gmem_AWVALID),
    .io_m_axi_gmem_AWREADY(io_m_axi_gmem_AWREADY),
    .io_m_axi_gmem_WDATA(io_m_axi_gmem_WDATA),
    .io_m_axi_gmem_WSTRB(io_m_axi_gmem_WSTRB),
    .io_m_axi_gmem_WLAST(io_m_axi_gmem_WLAST),
    .io_m_axi_gmem_WVALID(io_m_axi_gmem_WVALID),
    .io_m_axi_gmem_WREADY(io_m_axi_gmem_WREADY),
    .io_m_axi_gmem_BRESP(io_m_axi_gmem_BRESP),
    .io_m_axi_gmem_BVALID(io_m_axi_gmem_BVALID),
    .io_m_axi_gmem_BREADY(io_m_axi_gmem_BREADY),
    .io_m_axi_gmem_ARADDR(io_m_axi_gmem_ARADDR),
    .io_m_axi_gmem_ARLEN(io_m_axi_gmem_ARLEN),
    .io_m_axi_gmem_ARSIZE(io_m_axi_gmem_ARSIZE),
    .io_m_axi_gmem_ARBURST(io_m_axi_gmem_ARBURST),
    .io_m_axi_gmem_ARLOCK(io_m_axi_gmem_ARLOCK),
    .io_m_axi_gmem_ARREGION(io_m_axi_gmem_ARREGION),
    .io_m_axi_gmem_ARCACHE(io_m_axi_gmem_ARCACHE),
    .io_m_axi_gmem_ARPROT(io_m_axi_gmem_ARPROT),
    .io_m_axi_gmem_ARQOS(io_m_axi_gmem_ARQOS),
    .io_m_axi_gmem_ARVALID(io_m_axi_gmem_ARVALID),
    .io_m_axi_gmem_ARREADY(io_m_axi_gmem_ARREADY),
    .io_m_axi_gmem_RDATA(io_m_axi_gmem_RDATA),
    .io_m_axi_gmem_RRESP(io_m_axi_gmem_RRESP),
    .io_m_axi_gmem_RLAST(io_m_axi_gmem_RLAST),
    .io_m_axi_gmem_RVALID(io_m_axi_gmem_RVALID),
    .io_m_axi_gmem_RREADY(io_m_axi_gmem_RREADY)
);
reg [31:0] mem [127:0];

initial begin
    // Initialize signals
    $readmemb("32bits_one_line.hex", mem); // 从hex文件中读取数据到内存数组中
    clock = 0;
    reset = 1;
    io_start = 0;
    io_pargs = 64'b0;
    io_pdata = 64'b0;
    io_pres = 64'hf00000000;
    io_args_len = 64'd8; //点的的地址
    io_data_len = 64'b0;
    
    // Wait for reset to settle
    #10;
    reset = 0;
    io_start = 1;
    io_m_axi_gmem_ARREADY = 1'b1;//传输地址
    #10 //读数据的地址
    io_m_axi_gmem_RVALID = 1'b1;//input
    io_m_axi_gmem_RLAST = 1'b1;//input
    io_m_axi_gmem_RDATA = 256'h0ff000000; //data addr
    #10
    io_m_axi_gmem_ARREADY = 1'b1;//传输数据地址
    // 给我地址，我传输数据给他们
    // 传的数据
    for (int i = 0; i < 16; i = i + 1) begin
        #10 //传输实际的FFT的数据
        io_m_axi_gmem_RVALID = 1'b1;
        io_m_axi_gmem_RDATA = {mem[i],mem[i+1],mem[i+2],mem[i+3],mem[i+4],mem[i+5],mem[i+6],mem[i+7]};
        if (i == 15) begin
            io_m_axi_gmem_RLAST = 1'b1;
        end
    end
    #10
    // Drive the AXI interface with some test patterns (e.g., write-read operation)
end

always #5 clock = ~clock; // Generate a 10ns period clock



endmodule