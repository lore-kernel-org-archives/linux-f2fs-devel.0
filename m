From: Oded Gabbay <ogabbay@advaoptical.com>
Subject: [f2fs-dev] Kernel BUG when writing to f2fs drive, PowerPC, SD card,
	USB3
Date: Sun, 16 Jun 2013 14:51:26 +0300
Message-ID: <51BDA6BE.1040800@advaoptical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2550197755981024522=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <OGabbay@advaoptical.com>) id 1UoBUz-0003H4-9S
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jun 2013 11:51:57 +0000
Received: from mail.advaoptical.com ([91.217.199.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UoBUw-0001f6-Pc
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jun 2013 11:51:57 +0000
Received: from MUC-SRV-MAIL10.advaoptical.com (muc-srv-mail10.advaoptical.com
	[172.20.1.59])
	by muc-vsrv-fsmail.advaoptical.com (8.14.5/8.14.5) with ESMTP id
	r5GBplME021415
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 16 Jun 2013 13:51:48 +0200
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

--===============2550197755981024522==
Content-Type: multipart/alternative;
	boundary="------------080304090000050602040607"

--------------080304090000050602040607
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm working on a custom board with a PowerPC processor (Freescale P2020).
On the board there is an SD card, which is connected to a USB3 chip 
(from TI), which is connected to the PCI-e controller of the CPU.
I'm running with Linux kernel 3.9.6, with our custom rootFS.

I formatted an SD card using the mkfs.f2fs utility (after fixing some 
Big-endian issues - sent a patch a few days ago).
I then mounted the SD card, using "mount -o 
noatime,nodiratime,rw,nosuid,nodev,relatime,active_logs=6,uhelper=udisks2,background_gc_off 
/dev/sda /mnt/sd1"
Then, I started a small user-space test application which opens a file 
on the mount folder and starts to do "fwrite" into the file.
After 2-3 seconds, the kernel gives me a BUG and the system restarts.
When the system is up and I try to re-mount the SD card, I get the 
following error message:

F2FS-fs (sda): Failed to get valid F2FS checkpoint
mount: you must specify the filesystem type

Only way is to re-format the card using mkfs.f2fs

I took the f2fs patch that Jaegeuk Kim sent to Linus for 3.10 (here - 
https://lkml.org/lkml/2013/5/8/122) and applied it cleanly to 3.9.6
I repeated the procedure but got the same result.

The BUG is from this line, from segment.c:
         if (!f2fs_clear_bit(offset, se->cur_valid_map))
             BUG();

Additional information I can give is

1. I tried using F2FS in ArchLinux, kernel 3.9.5, on an x86 machine, 
with the same SD card and the same USB3-to-PCIe chip and it worked 
flawlessly there.
2. I can work with other FS on the SD card on our custom board, such as 
Ext3, Ext4 and vfat, so this is not a H/W issue.

Could you please try to help me pinpoint/debug the problem ?

Here is the complete kernel BUG print:

kernel BUG at .../linux-3.9.6-adva/fs/f2fs/segment.c:214!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT SMP NR_CPUS=2 P2020 FSP150
Modules linked in: mdio(O) hardware_version(PO) clipresent(PO) 
monotonic(O) restartcause(PO) panic_buffer(O)
NIP: c026a7e0 LR: c026a660 CTR: 00000000
REGS: ee761a60 TRAP: 0700   Tainted: P           O 
(3.9.6-dev_ogabbay-109482*)
MSR: 00029000 <CE,EE,ME>  CR: 24a52588  XER: 20000000
TASK = efb444c0[1755] 'flush-8:0' THREAD: ee760000 CPU: 1
GPR00: 00000000 ee761b10 efb444c0 0000004c 00000000 00000000 01dc4900 
eb0fa700
GPR08: 00000000 eb24cb00 00000040 00000040 00000038 00000000 ee761c64 
00000000
GPR16: c0aeea80 00080000 00000000 00000000 0000ed31 eb0fa700 00000000 
eb0fa734
GPR24: eb0fa700 00000080 f2030620 ffffffff ffffffc8 0000ed31 ffffffff 
c55a1000
NIP [c026a7e0] update_sit_entry+0x240/0x248
LR [c026a660] update_sit_entry+0xc0/0x248
Call Trace:
[ee761b10] [c55a1000] 0xc55a1000 (unreliable)
[ee761b40] [c026d1f4] do_write_page+0x198/0x660
[ee761b80] [c026d84c] write_data_page+0xa4/0xb8
[ee761bc0] [c0265118] do_write_data_page+0x1e8/0x20c
[ee761c20] [c02653dc] f2fs_write_data_page+0x2a0/0x2c0
[ee761c40] [c0263ad8] __f2fs_writepage+0x24/0x80
[ee761c50] [c00b05dc] write_cache_pages+0x1d0/0x35c
[ee761d00] [c0263cf4] f2fs_write_data_pages+0xf4/0xfc
[ee761d30] [c00b1d3c] do_writepages+0x30/0x64
[ee761d40] [c0103fbc] __writeback_single_inode+0x34/0x10c
[ee761d60] [c0104ef8] writeback_sb_inodes+0x204/0x370
[ee761dd0] [c01050f4] __writeback_inodes_wb+0x90/0xd4
[ee761e00] [c01054cc] wb_writeback+0x204/0x20c
[ee761e50] [c0105844] wb_do_writeback+0x144/0x20c
[ee761eb0] [c0105980] bdi_writeback_thread+0x74/0x144
[ee761ee0] [c0059dc4] kthread+0xa8/0xac
[ee761f40] [c000f014] ret_from_kernel_thread+0x64/0x6c
Instruction dump:
4bffff2c 813a0004 5720e8fe 7f39c8f8 39400001 5739077e 7d6900ae 7d59c830
7d6ac878 7d68c839 7d4901ae 4082fef0 <0fe00000> 0fe00000 9421ffe0 7c0802a6

-- 
Best regards,
Oded Gabbay
Principal Engineer Advanced Packet Technologies
ADVA Optical Networking Israel Ltd.
P.O. Box 2552
2 Hatidhar St.
Raanana 4366504, Israel
Tel: +(972)-9-7750130
Fax: +(972)-9-7462092
Mobile: +(972)-54-6543998
E-mail: ogabbay@advaoptical.com <%5C%22mailto:ogabbay@advaoptical.com%5C%22>
www.advaoptical.com <%5C%22http://www.advaoptical.com%5C%22>
*Let's ADVANCE*
ADVA Optical Networking SE is a European stock corporation (\"Societas 
Europaea\") with registered offices at Maerzenquelle 1-3, D-98617 
Meiningen, Germany * CEO: Brian L. Protiva, Chief Officers: Dr. 
Christoph Glingener, Christian Unterberger, Jaswir Singh * Chairman of 
the Supervisory Board: Anthony Maher * AG Jena HRB 508155 * VAT No. DE 
175 446 349


--------------080304090000050602040607
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi,<br>
    <br>
    I'm working on a custom board with a PowerPC processor (Freescale
    P2020).<br>
    On the board there is an SD card, which is connected to a USB3 chip
    (from TI), which is connected to the PCI-e controller of the CPU.<br>
    I'm running with Linux kernel 3.9.6, with our custom rootFS.<br>
    <br>
    I formatted an SD card using the mkfs.f2fs utility (after fixing
    some Big-endian issues - sent a patch a few days ago).<br>
    I then mounted the SD card, using "mount -o
    noatime,nodiratime,rw,nosuid,nodev,relatime,active_logs=6,uhelper=udisks2,background_gc_off
    /dev/sda /mnt/sd1"<br>
    Then, I started a small user-space test application which opens a
    file on the mount folder and starts to do "fwrite" into the file.<br>
    After 2-3 seconds, the kernel gives me a BUG and the system
    restarts. <br>
    When the system is up and I try to re-mount the SD card, I get the
    following error message:<br>
    <br>
    F2FS-fs (sda): Failed to get valid F2FS checkpoint<br>
    mount: you must specify the filesystem type<br>
    <br>
    Only way is to re-format the card using mkfs.f2fs<br>
    <br>
    I took the f2fs patch that Jaegeuk Kim sent to Linus for 3.10 (here
    -
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    <a href="https://lkml.org/lkml/2013/5/8/122">https://lkml.org/lkml/2013/5/8/122</a>)
    and applied it cleanly to 3.9.6<br>
    I repeated the procedure but got the same result.<br>
    <br>
    The BUG is from this line, from segment.c: <br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (!f2fs_clear_bit(offset, se-&gt;cur_valid_map))<br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BUG();<br>
    <br>
    Additional information I can give is <br>
    <br>
    1. I tried using F2FS in ArchLinux, kernel 3.9.5, on an x86 machine,
    with the same SD card and the same USB3-to-PCIe chip and it worked
    flawlessly there.<br>
    2. I can work with other FS on the SD card on our custom board, such
    as Ext3, Ext4 and vfat, so this is not a H/W issue.<br>
    <br>
    Could you please try to help me pinpoint/debug the problem ?<br>
    <br>
    Here is the complete kernel BUG print:<br>
    <br>
    kernel BUG at .../linux-3.9.6-adva/fs/f2fs/segment.c:214!<br>
    Oops: Exception in kernel mode, sig: 5 [#1]<br>
    PREEMPT SMP NR_CPUS=2 P2020 FSP150<br>
    Modules linked in: mdio(O) hardware_version(PO) clipresent(PO)
    monotonic(O) restartcause(PO) panic_buffer(O)<br>
    NIP: c026a7e0 LR: c026a660 CTR: 00000000<br>
    REGS: ee761a60 TRAP: 0700&nbsp;&nbsp; Tainted: P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; O&nbsp;
    (3.9.6-dev_ogabbay-109482*)<br>
    MSR: 00029000 &lt;CE,EE,ME&gt;&nbsp; CR: 24a52588&nbsp; XER: 20000000<br>
    TASK = efb444c0[1755] 'flush-8:0' THREAD: ee760000 CPU: 1<br>
    GPR00: 00000000 ee761b10 efb444c0 0000004c 00000000 00000000
    01dc4900 eb0fa700 <br>
    GPR08: 00000000 eb24cb00 00000040 00000040 00000038 00000000
    ee761c64 00000000 <br>
    GPR16: c0aeea80 00080000 00000000 00000000 0000ed31 eb0fa700
    00000000 eb0fa734 <br>
    GPR24: eb0fa700 00000080 f2030620 ffffffff ffffffc8 0000ed31
    ffffffff c55a1000 <br>
    NIP [c026a7e0] update_sit_entry+0x240/0x248<br>
    LR [c026a660] update_sit_entry+0xc0/0x248<br>
    Call Trace:<br>
    [ee761b10] [c55a1000] 0xc55a1000 (unreliable)<br>
    [ee761b40] [c026d1f4] do_write_page+0x198/0x660<br>
    [ee761b80] [c026d84c] write_data_page+0xa4/0xb8<br>
    [ee761bc0] [c0265118] do_write_data_page+0x1e8/0x20c<br>
    [ee761c20] [c02653dc] f2fs_write_data_page+0x2a0/0x2c0<br>
    [ee761c40] [c0263ad8] __f2fs_writepage+0x24/0x80<br>
    [ee761c50] [c00b05dc] write_cache_pages+0x1d0/0x35c<br>
    [ee761d00] [c0263cf4] f2fs_write_data_pages+0xf4/0xfc<br>
    [ee761d30] [c00b1d3c] do_writepages+0x30/0x64<br>
    [ee761d40] [c0103fbc] __writeback_single_inode+0x34/0x10c<br>
    [ee761d60] [c0104ef8] writeback_sb_inodes+0x204/0x370<br>
    [ee761dd0] [c01050f4] __writeback_inodes_wb+0x90/0xd4<br>
    [ee761e00] [c01054cc] wb_writeback+0x204/0x20c<br>
    [ee761e50] [c0105844] wb_do_writeback+0x144/0x20c<br>
    [ee761eb0] [c0105980] bdi_writeback_thread+0x74/0x144<br>
    [ee761ee0] [c0059dc4] kthread+0xa8/0xac<br>
    [ee761f40] [c000f014] ret_from_kernel_thread+0x64/0x6c<br>
    Instruction dump:<br>
    4bffff2c 813a0004 5720e8fe 7f39c8f8 39400001 5739077e 7d6900ae
    7d59c830 <br>
    7d6ac878 7d68c839 7d4901ae 4082fef0 &lt;0fe00000&gt; 0fe00000
    9421ffe0 7c0802a6 <br>
    <br>
    <div class="moz-signature">-- <br>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:14px;\&quot;">Best regards,</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:14px;\&quot;">Oded Gabbay</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">Principal Engineer
            Advanced Packet Technologies</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:" 12px;\"="">ADVA Optical Networking
            Israel Ltd.</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">P.O. Box 2552</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">2 Hatidhar St.</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">Raanana 4366504,
            Israel</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">Tel: +(972)-9-7750130</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">Fax: +(972)-9-7462092</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">Mobile:
            +(972)-54-6543998</span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">E-mail: <a
              href="%5C%22mailto:ogabbay@advaoptical.com%5C%22">ogabbay@advaoptical.com</a></span></span></div>
      <div>&nbsp;</div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:14px;\&quot;"><a
              href="%5C%22http://www.advaoptical.com%5C%22">www.advaoptical.com</a></span></span></div>
      <div><span style="\&quot;color:#000000;\&quot;"><strong
            style="\&quot;font-size:" 14px;\"="">Let's ADVANCE</strong></span></div>
      <div>&nbsp;</div>
      <div><span style="\&quot;color:#000000;\&quot;"><span
            style="\&quot;font-size:12px;\&quot;">ADVA Optical
            Networking SE is a European stock corporation (\"Societas
            Europaea\") with registered offices at Maerzenquelle 1-3,
            D-98617 Meiningen, Germany * CEO: Brian L. Protiva, Chief
            Officers: Dr. Christoph Glingener, Christian Unterberger,
            Jaswir Singh * Chairman of the Supervisory Board: Anthony
            Maher * AG Jena HRB 508155 * VAT No. DE 175 446 349</span></span></div>
    </div>
    <br>
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
  </body>
</html>

--------------080304090000050602040607--


--===============2550197755981024522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============2550197755981024522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============2550197755981024522==--
