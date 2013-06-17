From: Oded Gabbay <ogabbay@advaoptical.com>
Subject: Re: [f2fs-dev] Kernel BUG when writing to f2fs drive, PowerPC,
 SD card, USB3
Date: Mon, 17 Jun 2013 15:38:23 +0300
Message-ID: <51BF033F.4080804@advaoptical.com>
References: <51BDA6BE.1040800@advaoptical.com>
	<CA+v9cxZUftbQigWM5fAn9-5VBciAyKG9_yf5d2LpXUD6JOeiTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <OGabbay@advaoptical.com>) id 1UoYhz-0007Jc-QF
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jun 2013 12:38:55 +0000
Received: from mail.advaoptical.com ([91.217.199.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UoYhw-00047k-Os
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jun 2013 12:38:55 +0000
In-Reply-To: <CA+v9cxZUftbQigWM5fAn9-5VBciAyKG9_yf5d2LpXUD6JOeiTA@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

Hi,

Thanks for the patch.
Unfortunately, I tried it and it didn't help. I got the same result.
Oded

On 06/17/2013 10:20 AM, Huajun Li wrote:
> Hi,
> Is it possible caused by bitmap ? you know, bitmaps are unsigned
> variable, while f2fs_{clear, set, test}_bit() parameter is signed
> variable.
> So, could you please try following patch, and update the same issue in
> mkfs.f2fs tool.
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3e7cb33..28d31f1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -209,7 +209,7 @@ struct f2fs_nm_info {
>       struct mutex build_lock;    /* lock for build free nids */
>
>       /* for checkpoint */
> -    char *nat_bitmap;        /* NAT bitmap pointer */
> +    unsigned char *nat_bitmap;    /* NAT bitmap pointer */
>       int bitmap_size;        /* bitmap size */
>   };
>
> @@ -820,7 +820,7 @@ static inline block_t datablock_addr(struct page *node_page,
>       return le32_to_cpu(addr_array[offset]);
>   }
>
> -static inline int f2fs_test_bit(unsigned int nr, char *addr)
> +static inline int f2fs_test_bit(unsigned int nr, unsigned char *addr)
>   {
>       int mask;
>
> @@ -829,7 +829,7 @@ static inline int f2fs_test_bit(unsigned int nr, char *addr)
>       return mask & *addr;
>   }
>
> -static inline int f2fs_set_bit(unsigned int nr, char *addr)
> +static inline int f2fs_set_bit(unsigned int nr, unsigned char *addr)
>   {
>       int mask;
>       int ret;
> @@ -841,7 +841,7 @@ static inline int f2fs_set_bit(unsigned int nr, char *addr)
>       return ret;
>   }
>
> -static inline int f2fs_clear_bit(unsigned int nr, char *addr)
> +static inline int f2fs_clear_bit(unsigned int nr, unsigned char *addr)
>   {
>       int mask;
>       int ret;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b15debc..b191449 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1402,7 +1402,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>       struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>       struct sit_info *sit_i;
>       unsigned int sit_segs, start;
> -    char *src_bitmap, *dst_bitmap;
> +    unsigned char *src_bitmap, *dst_bitmap;
>       unsigned int bitmap_size;
>
>       /* allocate memory for SIT information */
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 062424a..a96f7f4 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -175,7 +175,7 @@ struct sit_info {
>       block_t sit_base_addr;        /* start block address of SIT area */
>       block_t sit_blocks;        /* # of blocks used by SIT area */
>       block_t written_valid_blocks;    /* # of valid blocks in main area */
> -    char *sit_bitmap;        /* SIT bitmap pointer */
> +    unsigned char *sit_bitmap;    /* SIT bitmap pointer */
>       unsigned int bitmap_size;    /* SIT bitmap size */
>
>       unsigned long *dirty_sentries_bitmap;    /* bitmap for dirty sentries */
>
> On Sun, Jun 16, 2013 at 7:51 PM, Oded Gabbay <ogabbay@advaoptical.com> wrote:
>> Hi,
>>
>> I'm working on a custom board with a PowerPC processor (Freescale P2020).
>> On the board there is an SD card, which is connected to a USB3 chip (from
>> TI), which is connected to the PCI-e controller of the CPU.
>> I'm running with Linux kernel 3.9.6, with our custom rootFS.
>>
>> I formatted an SD card using the mkfs.f2fs utility (after fixing some
>> Big-endian issues - sent a patch a few days ago).
>> I then mounted the SD card, using "mount -o
>> noatime,nodiratime,rw,nosuid,nodev,relatime,active_logs=6,uhelper=udisks2,background_gc_off
>> /dev/sda /mnt/sd1"
>> Then, I started a small user-space test application which opens a file on
>> the mount folder and starts to do "fwrite" into the file.
>> After 2-3 seconds, the kernel gives me a BUG and the system restarts.
>> When the system is up and I try to re-mount the SD card, I get the following
>> error message:
>>
>> F2FS-fs (sda): Failed to get valid F2FS checkpoint
>> mount: you must specify the filesystem type
>>
>> Only way is to re-format the card using mkfs.f2fs
>>
>> I took the f2fs patch that Jaegeuk Kim sent to Linus for 3.10 (here -
>> https://lkml.org/lkml/2013/5/8/122) and applied it cleanly to 3.9.6
>> I repeated the procedure but got the same result.
>>
>> The BUG is from this line, from segment.c:
>>          if (!f2fs_clear_bit(offset, se->cur_valid_map))
>>              BUG();
>>
>> Additional information I can give is
>>
>> 1. I tried using F2FS in ArchLinux, kernel 3.9.5, on an x86 machine, with
>> the same SD card and the same USB3-to-PCIe chip and it worked flawlessly
>> there.
>> 2. I can work with other FS on the SD card on our custom board, such as
>> Ext3, Ext4 and vfat, so this is not a H/W issue.
>>
>> Could you please try to help me pinpoint/debug the problem ?
>>
>> Here is the complete kernel BUG print:
>>
>> kernel BUG at .../linux-3.9.6-adva/fs/f2fs/segment.c:214!
>> Oops: Exception in kernel mode, sig: 5 [#1]
>> PREEMPT SMP NR_CPUS=2 P2020 FSP150
>> Modules linked in: mdio(O) hardware_version(PO) clipresent(PO) monotonic(O)
>> restartcause(PO) panic_buffer(O)
>> NIP: c026a7e0 LR: c026a660 CTR: 00000000
>> REGS: ee761a60 TRAP: 0700   Tainted: P           O
>> (3.9.6-dev_ogabbay-109482*)
>> MSR: 00029000 <CE,EE,ME>  CR: 24a52588  XER: 20000000
>> TASK = efb444c0[1755] 'flush-8:0' THREAD: ee760000 CPU: 1
>> GPR00: 00000000 ee761b10 efb444c0 0000004c 00000000 00000000 01dc4900
>> eb0fa700
>> GPR08: 00000000 eb24cb00 00000040 00000040 00000038 00000000 ee761c64
>> 00000000
>> GPR16: c0aeea80 00080000 00000000 00000000 0000ed31 eb0fa700 00000000
>> eb0fa734
>> GPR24: eb0fa700 00000080 f2030620 ffffffff ffffffc8 0000ed31 ffffffff
>> c55a1000
>> NIP [c026a7e0] update_sit_entry+0x240/0x248
>> LR [c026a660] update_sit_entry+0xc0/0x248
>> Call Trace:
>> [ee761b10] [c55a1000] 0xc55a1000 (unreliable)
>> [ee761b40] [c026d1f4] do_write_page+0x198/0x660
>> [ee761b80] [c026d84c] write_data_page+0xa4/0xb8
>> [ee761bc0] [c0265118] do_write_data_page+0x1e8/0x20c
>> [ee761c20] [c02653dc] f2fs_write_data_page+0x2a0/0x2c0
>> [ee761c40] [c0263ad8] __f2fs_writepage+0x24/0x80
>> [ee761c50] [c00b05dc] write_cache_pages+0x1d0/0x35c
>> [ee761d00] [c0263cf4] f2fs_write_data_pages+0xf4/0xfc
>> [ee761d30] [c00b1d3c] do_writepages+0x30/0x64
>> [ee761d40] [c0103fbc] __writeback_single_inode+0x34/0x10c
>> [ee761d60] [c0104ef8] writeback_sb_inodes+0x204/0x370
>> [ee761dd0] [c01050f4] __writeback_inodes_wb+0x90/0xd4
>> [ee761e00] [c01054cc] wb_writeback+0x204/0x20c
>> [ee761e50] [c0105844] wb_do_writeback+0x144/0x20c
>> [ee761eb0] [c0105980] bdi_writeback_thread+0x74/0x144
>> [ee761ee0] [c0059dc4] kthread+0xa8/0xac
>> [ee761f40] [c000f014] ret_from_kernel_thread+0x64/0x6c
>> Instruction dump:
>> 4bffff2c 813a0004 5720e8fe 7f39c8f8 39400001 5739077e 7d6900ae 7d59c830
>> 7d6ac878 7d68c839 7d4901ae 4082fef0 <0fe00000> 0fe00000 9421ffe0 7c0802a6
>>
>> --
>> Best regards,
>> Oded Gabbay
>> Principal Engineer Advanced Packet Technologies
>> ADVA Optical Networking Israel Ltd.
>> P.O. Box 2552
>> 2 Hatidhar St.
>> Raanana 4366504, Israel
>> Tel: +(972)-9-7750130
>> Fax: +(972)-9-7462092
>> Mobile: +(972)-54-6543998
>> E-mail: ogabbay@advaoptical.com
>>
>> www.advaoptical.com
>> Let's ADVANCE
>>
>> ADVA Optical Networking SE is a European stock corporation (\"Societas
>> Europaea\") with registered offices at Maerzenquelle 1-3, D-98617 Meiningen,
>> Germany * CEO: Brian L. Protiva, Chief Officers: Dr. Christoph Glingener,
>> Christian Unterberger, Jaswir Singh * Chairman of the Supervisory Board:
>> Anthony Maher * AG Jena HRB 508155 * VAT No. DE 175 446 349
>>
>>
>> ------------------------------------------------------------------------------
>> This SF.net email is sponsored by Windows:
>>
>> Build for Windows Store.
>>
>> http://p.sf.net/sfu/windows-dev2dev
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
