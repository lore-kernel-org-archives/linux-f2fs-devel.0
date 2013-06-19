From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 2/2] mkfs: fix to store __le32 for checkpoint
	flags
Date: Wed, 19 Jun 2013 21:45:39 +0900
Message-ID: <1371645939.2072.24.camel@kjgkr>
References: <51BDA6BE.1040800@advaoptical.com> <1371471068.10480.8.camel@kjgkr>
	<51BF1B84.8080802@advaoptical.com> <51C02BE6.4070007@advaoptical.com>
	<51C04E24.6090200@advaoptical.com> <1371645828.2072.22.camel@kjgkr>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UpHle-0005Pq-LK
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 12:45:42 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UpHlb-0003SH-2o for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 12:45:42 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MON00LJU4RQURU0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Jun 2013 21:45:32 +0900 (KST)
In-reply-to: <1371645828.2072.22.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Oded Gabbay <ogabbay@advaoptical.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

>From 55e3fbfb074e8e1bf769b5b0c1e6de8ea9df7260 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Wed, 19 Jun 2013 21:36:39 +0900
Subject: [PATCH 2/2] mkfs: fix to store __le32 for checkpoint flags
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

The checkpoint flags also should be stored as little endian style.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 9115520..06771ff 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -563,7 +563,7 @@ static int f2fs_write_check_point_pack(void)
 			le32_to_cpu(ckp->overprov_segment_count)) *
 			 config.blks_per_seg));
 	ckp->cp_pack_total_block_count = cpu_to_le32(8);
-	ckp->ckpt_flags |= CP_UMOUNT_FLAG;
+	ckp->ckpt_flags = cpu_to_le32(CP_UMOUNT_FLAG);
 	ckp->cp_pack_start_sum = cpu_to_le32(1);
 	ckp->valid_node_count = cpu_to_le32(1);
 	ckp->valid_inode_count = cpu_to_le32(1);
-- 
1.8.3.1.437.g0dbd812



-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
