From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 1/2] f2fs: check name_len of dir entry to prevent
 from deadloop
Date: Wed, 02 Jul 2014 13:23:47 +0800
Message-ID: <000001cf95b5$eac71ad0$c0555070$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We assume that modification of some special application could result in zeroed
name_len, or it is consciously made by somebody. We will deadloop in
find_in_block when name_len of dir entry is zero.

This patch is added for preventing deadloop in above scenario.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index be8c7af..4316ec5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -121,6 +121,16 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 			}
 		}
 
+		/* check name_len to prevent from deadloop here */
+		if (unlikely(de->name_len == 0)) {
+			struct inode *inode = dentry_page->mapping->host;
+
+			f2fs_msg(inode->i_sb, KERN_ERR,
+				"zero-length dir entry, ino = %lu, name = %s",
+				(unsigned long)inode->i_ino, name->name);
+			break;
+		}
+
 		bit_start = bit_pos
 				+ GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 	}
-- 
1.7.9.5
