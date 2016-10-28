From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 6/7] mkfs.f2fs: Check zoned block devices
	configuration
Date: Fri, 28 Oct 2016 16:57:03 +0900
Message-ID: <1477641424-12367-8-git-send-email-damien.lemoal@wdc.com>
References: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02Gm-00036y-V3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:08 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02Gm-0007AL-35
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:08 +0000
In-Reply-To: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-f2fs-devel@lists.sourceforge.net

Make sure the drive has enough randomly writeable zones from
the beginning of the partition to hold the meta data sections.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 mkfs/f2fs_format.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index b40cd83..93b5c8f 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -183,6 +183,13 @@ static int f2fs_prepare_super_block(void)
 
 	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n", get_sb(segment0_blkaddr));
 
+	if (config.zoned_mode &&
+	    get_sb(segment0_blkaddr) % config.zone_blocks) {
+		MSG(1, "\tError: Unaligned segment0 block address %u\n",
+		    get_sb(segment0_blkaddr));
+		return -1;
+	}
+
 	set_sb(segment_count_ckpt, F2FS_NUMBER_OF_CHECKPOINT_PACK);
 
 	set_sb(sit_blkaddr, get_sb(segment0_blkaddr) + get_sb(segment_count_ckpt) *
@@ -267,6 +274,21 @@ static int f2fs_prepare_super_block(void)
 	set_sb(main_blkaddr, get_sb(segment0_blkaddr) + total_meta_zones *
 				config.segs_per_zone * config.blks_per_seg);
 
+	if (config.zoned_mode) {
+		/*
+		 * Make sure there is enough randomly writeable
+		 * space at the beginning of the disk.
+		 */
+		unsigned long main_blkzone = get_sb(main_blkaddr) / config.zone_blocks;
+
+		if (config.nr_rnd_zones < main_blkzone) {
+			MSG(1, "\tError: Device does not have enough random "
+			    "write zones for F2FS volume (%lu needed)",
+			    main_blkzone);
+			return -1;
+		}
+	}
+
 	total_zones = get_sb(segment_count) / (config.segs_per_zone) -
 							total_meta_zones;
 
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.


------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik
