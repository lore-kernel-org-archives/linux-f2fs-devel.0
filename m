From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: fsck is broken on mips32 platform
Date: Fri, 25 Nov 2016 09:23:44 +0800
Message-ID: <583792A0.2080209@huawei.com>
References: <56969233.20161125013035@vodka.home.kg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1cA5GI-0003xw-SY
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 01:25:10 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cA5GG-0006w6-0d
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Nov 2016 01:25:10 +0000
In-Reply-To: <56969233.20161125013035@vodka.home.kg>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, k@vodka.home.kg

Hi,

On 11/25/2016 6:30 AM, k@vodka.home.kg wrote:
> Hi !
> 
> I'm using f2fs on router Dlink dir-825 with openwrt/LEDE firmware.
> Its mips32 rel 2 big endian cpu.
> 
> mkfs.f2fs - works
> mount - works
> fsck.f2fs - corrupts filesystem
> 
> # i'm  trying  to fsck valid empty mountable f2fs partition i have just mkfs'ed
> fsck.f2fs /dev/sda2
> Info: Segments per section = 1
> Info: Sections per zone = 1
> Info: sector size = 512
> Info: total sectors = 6508544 (3178 MB)
> Info: MKFS version
>   "Linux version 4.4.0-21-generic (buildd@lgw01-21) (gcc version 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2) ) #37-Ubuntu SMP Mon Apr 18 18:33:37 UTC 2016"
> Info: FSCK version
>   from "Linux version 4.4.0-21-generic (buildd@lgw01-21) (gcc version 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2) ) #37-Ubuntu SMP Mon Apr 18 18:33:37 UTC 2016"
>     to "Linux version 4.4.30 (vasya@nowhere) (gcc version 5.4.0 (LEDE GCC 5.4.0 r2084) ) #0 PREEMPT Thu Nov 3 07:34:38 2016"
> Info: superblock features = 0 : 
> Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
> Info: total FS sectors = 6508544 (3178 MB)
> Info: CKPT version = 1
> Info: checkpoint state = 5 :  compacted_summary unmount
> [ASSERT] (sanity_check_nid: 356)  --> nid is not valid. [0x3]
It seems that sanity_check_nid does not switch little endian value to big endian.
I'm not sure if it is caused by this and if there are any other places have this
endian switch issue, could you please test this.

thanks,
Sheng

======

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 39ff161..9dc832c 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -370,7 +370,7 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
 {
        return (nid <= (NAT_ENTRY_PER_BLOCK *
-                       F2FS_RAW_SUPER(sbi)->segment_count_nat
+                       le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_nat)
                        << (sbi->log_blocks_per_seg - 1)));
 }

@@ -378,7 +378,7 @@ static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
 {
        int i;

-       if (addr >= F2FS_RAW_SUPER(sbi)->block_count ||
+       if (addr >= le64_to_cpu(F2FS_RAW_SUPER(sbi)->block_count) ||
                                addr < SM_I(sbi)->main_blkaddr) {
                DBG(1, "block addr [0x%x]\n", addr);
                return 0;
> 
> NID[0x3] is unreachable
> [FSCK] Unreachable nat entries                        [Fail] [0x1]
> [FSCK] SIT valid block bitmap checking                [Fail]
> [FSCK] Hard link checking for regular file            [Ok..] [0x0]
> [FSCK] valid_block_count matching with CP             [Fail] [0x0]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Fail] [0x0]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x1]
> [FSCK] valid_inode_count matched with CP              [Fail] [0x0]
> [FSCK] free segment_count matched with CP             [Fail] [0x621]
> [FSCK] next block offset is free                      [Ok..]
> [FSCK] fixing SIT types
> [FSCK] other corrupted bugs                           [Fail]
> [FIX] (nullify_nat_entry:1688)  --> Remove nid [0x3] in nat journal
> 
> After failed mount attempt :
> 
> dmesg
> F2FS-fs (sda2): Failed to read root inode
> 
> On x86 and ARM everything is ok
> 
> f2fs-tools 1.7.0
> kernel 4.4.30
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 


------------------------------------------------------------------------------
