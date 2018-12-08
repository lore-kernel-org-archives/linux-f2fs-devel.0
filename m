From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] fsck: Fix big endian platforms
Date: Fri,  7 Dec 2018 17:45:31 -0800
Message-ID: <20181208014531.2504-1-rosenp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rosenp@gmail.com>) id 1gVRgb-0001B7-N6
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Dec 2018 01:45:41 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gVRgZ-009k0U-UN
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Dec 2018 01:45:41 +0000
Received: by mail-pl1-f193.google.com with SMTP id e5so2605815plb.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 07 Dec 2018 17:45:39 -0800 (PST)
Received: from desktop.lan (astound-69-42-16-32.ca.astound.net. [69.42.16.32])
 by smtp.gmail.com with ESMTPSA id
 u8sm6171759pfl.16.2018.12.07.17.45.32
 for <linux-f2fs-devel@lists.sourceforge.net>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 17:45:32 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Since "fsck.f2fs: integrate sanity_check_inode to __check_inode_mode",
big endian platforms have been broken due to an endianness bug.

More info: https://github.com/openwrt/openwrt/pull/1575

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 fsck/fsck.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 366ba13..73901d1 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -339,7 +339,7 @@ out:
 	return ret;
 }
 
-static int __check_inode_mode(u32 nid, enum FILE_TYPE ftype, u32 mode)
+static int __check_inode_mode(u32 nid, enum FILE_TYPE ftype, u16 mode)
 {
 	if (ftype >= F2FS_FT_MAX)
 		return 0;
@@ -457,7 +457,7 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 		return 0;
 
 	if (ntype == TYPE_INODE &&
-		__check_inode_mode(nid, ftype, le32_to_cpu(node_blk->i.i_mode)))
+		__check_inode_mode(nid, ftype, le16_to_cpu(node_blk->i.i_mode)))
 		return -EINVAL;
 
 	/* workaround to fix later */
-- 
2.19.2
