From: folkert <folkert@vanheusden.com>
Subject: [f2fs-dev] fsck: assertion failed
Date: Sun, 7 Jul 2013 12:19:30 +0200
Message-ID: <20130707101930.GD19245@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1Uvm4C-0004wU-Au
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 07 Jul 2013 10:19:40 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Uvm49-0007UA-Kv
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 07 Jul 2013 10:19:40 +0000
Received: from belle.intranet.vanheusden.com (unknown [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id 3A536162EC8
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun,  7 Jul 2013 12:19:31 +0200 (CEST)
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

Hello,

Trying to fsck an f2fs volume. This gives an assertion failed:

+--------------------------------------------------------+
| Checkpoint                                             |
+--------------------------------------------------------+  
checkpoint_ver                          [0x      82 : 130]
user_block_count                        [0x 1bcfe00 : 29163008]  
valid_block_count                       [0x  cb2600 : 13313536]
rsvd_segment_count                      [0x      19 : 25]  
overprov_segment_count                  [0x     bce : 3022]
free_segment_count                      [0x    84b3 : 33971]  
alloc_type[CURSEG_HOT_NODE]             [0x       0 : 0]
alloc_type[CURSEG_WARM_NODE]            [0x       0 : 0]  
alloc_type[CURSEG_COLD_NODE]            [0x       0 : 0]
cur_node_segno[0]                       [0x    e4e6 : 58598]  
cur_node_segno[1]                       [0x    e546 : 58694]  
cur_node_segno[2]                       [0x    e902 : 59650]
cur_node_blkoff[0]                      [0x      5c : 92]  
cur_node_blkoff[1]                      [0x      91 : 145]
cur_node_blkoff[2]                      [0x     1b8 : 440]  
alloc_type[CURSEG_HOT_DATA]             [0x       0 : 0]
alloc_type[CURSEG_WARM_DATA]            [0x       0 : 0]  
alloc_type[CURSEG_COLD_DATA]            [0x       0 : 0]
cur_data_segno[0]                       [0x    e3ff : 58367]  
cur_data_segno[1]                       [0x    219e : 8606]
cur_data_segno[2]                       [0x    e4a3 : 58531]  
cur_data_blkoff[0]                      [0x     152 : 338]
cur_data_blkoff[1]                      [0x      63 : 99]  
cur_data_blkoff[2]                      [0x     11b : 283]
ckpt_flags                              [0x       5 : 5]  
cp_pack_total_block_count               [0x       7 : 7]
cp_pack_start_sum                       [0x       1 : 1]  
valid_node_count                        [0x   ccdba : 839098]
valid_inode_count                       [0x   cb031 : 831537]  
next_free_nid                           [0x  113607 : 1127943]
sit_ver_bitmap_bytesize                 [0x      c0 : 192]  
nat_ver_bitmap_bytesize                 [0x     e80 : 3712]
checksum_offset                         [0x     ffc : 4092]  
elapsed_time                            [0x  2d76c1 : 2979521]
sit_nat_version_bitmap[0]               [0x      81 : 129]  


[build_nat_area_bitmap:1031] valid nat entries (block_addr != 0x0) [0x   ce30b : 844555]  
[build_sit_area_bitmap: 937] Blocks [0xcb2600] Free Segs [0x84b3]

Assertion failed!
[fsck_chk_dentry_blk: 509] le32_to_cpu(de_blk->dentry[i].hash_code) == hash_code



Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
