From: Zeng Guangyue <zengguangyue@hisilicon.com>
Subject: [PATCH] f2fs: correct spelling mistake
Date: Mon, 18 Feb 2019 14:26:41 +0800
Message-ID: <20190218062641.104401-1-zengguangyue@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: zangleigang@hisilicon.com, kid.jin@hisilicon.com, zengguangyue@hisilicon.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

correct spelling mistake for "nunmber"

Signed-off-by: Zeng Guangyue <zengguangyue@hisilicon.com>
---
 include/linux/f2fs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d7711048ef93..4c25ab97107c 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -284,7 +284,7 @@ enum {
 
 struct node_footer {
 	__le32 nid;		/* node id */
-	__le32 ino;		/* inode nunmber */
+	__le32 ino;		/* inode number */
 	__le32 flag;		/* include cold/fsync/dentry marks and offset */
 	__le64 cp_ver;		/* checkpoint version */
 	__le32 next_blkaddr;	/* next node page block address */
-- 
2.20.1.309.g16a465bc01
