From: folkert <folkert@vanheusden.com>
Subject: Re: assertion failed
Date: Wed, 8 Jan 2014 22:09:52 +0100
Message-ID: <20140108210952.GB6833@belle.intranet.vanheusden.com>
References: <20140102145632.GI8406@belle.intranet.vanheusden.com>
	<1389056518.3035.2.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1W10O3-00055R-EM
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jan 2014 21:10:03 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W10Nz-00083c-I4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jan 2014 21:10:03 +0000
Content-Disposition: inline
In-Reply-To: <1389056518.3035.2.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

After I installed the latest I got this error:

build_nat_area_bitmap:1031] valid nat entries (block_addr != 0x0) [0x e65ee : 943598]
[build_sit_area_bitmap: 937] Blocks [0x198d273] Free Segs [0x1db2]
[fsck_chk_dentry_blk: 528] [  1] - no[0x2] name[belle] len[0x5] ino[0xd1] type[0x2]
[fsck_chk_dentry_blk: 528] [  2] - no[0x2] name[home] len[0x4] ino[0xd2] type[0x2]
[fsck_chk_dentry_blk: 528] [  3] - no[0x2] name[sandra] len[0x6] ino[0xd3] type[0x2]
[fsck_chk_dentry_blk: 528] [  4] - no[0x2] name[.less] len[0x5] ino[0xd4] type[0x1]
[fsck_chk_dentry_blk: 528] [  4] - no[0x3] name[.forward] len[0x8] ino[0xd5] type[0x1]
[fsck_chk_dentry_blk: 528] [  4] - no[0x4] name[.lessrc] len[0x7] ino[0xd6] type[0x1]
[fsck_chk_dentry_blk: 547] [  4] Dentry Block [0x1a3980a] Done : dentries:3 in 214 slots (len:255)

[fsck_chk_inode_blk: 377] Directory Inode: ino: d3 name: sandra depth: 1 child files: 3

[fsck_chk_dentry_blk: 528] [  3] - no[0x3] name[dialin] len[0x6] ino[0xd7] type[0x2]
[fsck_chk_dentry_blk: 528] [  4] - no[0x2] name[.less] len[0x5] ino[0xd8] type[0x1]
[fsck_chk_dentry_blk: 528] [  4] - no[0x3] name[.lessrc] len[0x7] ino[0xd9] type[0x1]
[fsck_chk_dentry_blk: 528] [  4] - no[0x4] name[.bash_history] len[0xd] ino[0xda] type[0x1]

Assertion failed!
[fsck_chk_dentry_blk: 509] le32_to_cpu(de_blk->dentry[i].hash_code) == hash_code


On Tue, Jan 07, 2014 at 10:01:58AM +0900, Jaegeuk Kim wrote:
> Hi,
> 
> Thank you for the report.
> Could you pull the lastest f2fs-tools and then test this again?
> Thanks,
> 
> 2014-01-02 (???), 15:56 +0100, folkert:
> > Hi,
> > 
> > While running fsck.f2fs I get an assertion. This is with the f2fs from
> > git from half an hour ago:
> > 
> > +--------------------------------------------------------+
> > | Checkpoint                                             |
> > +--------------------------------------------------------+
> > checkpoint_ver                          [0x     4a7 : 1191]
> > user_block_count                        [0x 1bcce00 : 29150720]
> > valid_block_count                       [0x 19769e2 : 26700258]
> > rsvd_segment_count                      [0x      30 : 48]
> > overprov_segment_count                  [0x     be4 : 3044]
> > free_segment_count                      [0x    1e7f : 7807]
> > alloc_type[CURSEG_HOT_NODE]             [0x       0 : 0]
> > alloc_type[CURSEG_WARM_NODE]            [0x       0 : 0]
> > alloc_type[CURSEG_COLD_NODE]            [0x       0 : 0]
> > cur_node_segno[0]                       [0x    df99 : 57241]
> > cur_node_segno[1]                       [0x    df91 : 57233]
> > cur_node_segno[2]                       [0x    d565 : 54629]
> > cur_node_blkoff[0]                      [0x     1a4 : 420]
> > cur_node_blkoff[1]                      [0x     1a5 : 421]
> > cur_node_blkoff[2]                      [0x       7 : 7]
> > alloc_type[CURSEG_HOT_DATA]             [0x       0 : 0]
> > alloc_type[CURSEG_WARM_DATA]            [0x       0 : 0]
> > alloc_type[CURSEG_COLD_DATA]            [0x       0 : 0]
> > cur_data_segno[0]                       [0x    dfef : 57327]
> > cur_data_segno[1]                       [0x    a531 : 42289]
> > cur_data_segno[2]                       [0x    a70d : 42765]
> > cur_data_blkoff[0]                      [0x      63 : 99]
> > cur_data_blkoff[1]                      [0x     13a : 314]
> > cur_data_blkoff[2]                      [0x      c3 : 195]
> > ckpt_flags                              [0x       5 : 5]
> > cp_pack_total_block_count               [0x       7 : 7]
> > cp_pack_start_sum                       [0x       1 : 1]
> > valid_node_count                        [0x   e359f : 931231]
> > valid_inode_count                       [0x   de77c : 911228]
> > next_free_nid                           [0x  11f16c : 1175916]
> > sit_ver_bitmap_bytesize                 [0x      c0 : 192]
> > nat_ver_bitmap_bytesize                 [0x     e80 : 3712]
> > checksum_offset                         [0x     ffc : 4092]
> > elapsed_time                            [0x  7f5b6a : 8346474]
> > sit_nat_version_bitmap[0]               [0x      40 : 64]
> > 
> > 
> > [build_nat_area_bitmap:1031] valid nat entries (block_addr != 0x0) [0x
> > e520f : 938511]
> > [build_sit_area_bitmap: 937] Blocks [0x19769e2] Free Segs [0x1e7f]
> > [fsck_chk_dentry_blk: 547] [  4] Dentry Block [0x1a3980a] Done :
> > dentries:3 in 214 slots (len:255)
> > 
> > [fsck_chk_inode_blk: 377] Directory Inode: ino: d3 name: sandra depth: 1
> > child files: 3
> > 
> > 
> > Assertion failed!
> > [fsck_chk_dentry_blk: 509] le32_to_cpu(de_blk->dentry[i].hash_code) ==
> > hash_code
> > 
> > 
> > 
> > Folkert van Heusden
> > 
> 
> -- 
> Jaegeuk Kim
> Samsung


Folkert van Heusden

-- 
MultiTail cok yonlu kullanimli bir program, loglari okumak, verilen
kommandolari yerine getirebilen. Filter, renk verme, merge, 'diff-
view', vs.  http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
