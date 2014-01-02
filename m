From: folkert <folkert@vanheusden.com>
Subject: assertion failed
Date: Thu, 2 Jan 2014 15:56:32 +0100
Message-ID: <20140102145632.GI8406@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1VyjyS-0006AS-2e
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jan 2014 15:14:16 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VyjyP-0000EA-DS
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Jan 2014 15:14:16 +0000
Received: from belle.intranet.vanheusden.com (unknown [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id 1878315FC51
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu,  2 Jan 2014 15:56:33 +0100 (CET)
Content-Disposition: inline
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

Hi,

While running fsck.f2fs I get an assertion. This is with the f2fs from
git from half an hour ago:

+--------------------------------------------------------+
| Checkpoint                                             |
+--------------------------------------------------------+
checkpoint_ver                          [0x     4a7 : 1191]
user_block_count                        [0x 1bcce00 : 29150720]
valid_block_count                       [0x 19769e2 : 26700258]
rsvd_segment_count                      [0x      30 : 48]
overprov_segment_count                  [0x     be4 : 3044]
free_segment_count                      [0x    1e7f : 7807]
alloc_type[CURSEG_HOT_NODE]             [0x       0 : 0]
alloc_type[CURSEG_WARM_NODE]            [0x       0 : 0]
alloc_type[CURSEG_COLD_NODE]            [0x       0 : 0]
cur_node_segno[0]                       [0x    df99 : 57241]
cur_node_segno[1]                       [0x    df91 : 57233]
cur_node_segno[2]                       [0x    d565 : 54629]
cur_node_blkoff[0]                      [0x     1a4 : 420]
cur_node_blkoff[1]                      [0x     1a5 : 421]
cur_node_blkoff[2]                      [0x       7 : 7]
alloc_type[CURSEG_HOT_DATA]             [0x       0 : 0]
alloc_type[CURSEG_WARM_DATA]            [0x       0 : 0]
alloc_type[CURSEG_COLD_DATA]            [0x       0 : 0]
cur_data_segno[0]                       [0x    dfef : 57327]
cur_data_segno[1]                       [0x    a531 : 42289]
cur_data_segno[2]                       [0x    a70d : 42765]
cur_data_blkoff[0]                      [0x      63 : 99]
cur_data_blkoff[1]                      [0x     13a : 314]
cur_data_blkoff[2]                      [0x      c3 : 195]
ckpt_flags                              [0x       5 : 5]
cp_pack_total_block_count               [0x       7 : 7]
cp_pack_start_sum                       [0x       1 : 1]
valid_node_count                        [0x   e359f : 931231]
valid_inode_count                       [0x   de77c : 911228]
next_free_nid                           [0x  11f16c : 1175916]
sit_ver_bitmap_bytesize                 [0x      c0 : 192]
nat_ver_bitmap_bytesize                 [0x     e80 : 3712]
checksum_offset                         [0x     ffc : 4092]
elapsed_time                            [0x  7f5b6a : 8346474]
sit_nat_version_bitmap[0]               [0x      40 : 64]


[build_nat_area_bitmap:1031] valid nat entries (block_addr !=3D 0x0) [0x
e520f : 938511]
[build_sit_area_bitmap: 937] Blocks [0x19769e2] Free Segs [0x1e7f]
[fsck_chk_dentry_blk: 547] [  4] Dentry Block [0x1a3980a] Done :
dentries:3 in 214 slots (len:255)

[fsck_chk_inode_blk: 377] Directory Inode: ino: d3 name: sandra depth: 1
child files: 3


Assertion failed!
[fsck_chk_dentry_blk: 509] le32_to_cpu(de_blk->dentry[i].hash_code) =3D=3D
hash_code



Folkert van Heusden

-- =

MultiTail er et flexible tool for =E5 kontrolere Logfiles og commandoer.
Med filtrer, farger, sammenf=F8ringer, forskeliger ansikter etc.
http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

---------------------------------------------------------------------------=
---
Rapidly troubleshoot problems before they affect your business. Most IT =

organizations don't have a clear picture of how application performance =

affects their revenue. With AppDynamics, you get 100% visibility into your =

Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics P=
ro!
http://pubads.g.doubleclick.net/gampad/clk?id=3D84349831&iu=3D/4140/ostg.cl=
ktrk
