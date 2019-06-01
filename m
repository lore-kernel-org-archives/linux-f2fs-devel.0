From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 045/186] f2fs: fix error path of
 recovery
Date: Sat,  1 Jun 2019 09:14:21 -0400
Message-ID: <20190601131653.24205-45-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1hX3uM-0003OL-P7
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:18:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hX3uK-00EBwt-UP
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:18:50 +0000
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 988385795c7f46b231982d54750587f204bd558b ]

There are some places in where we missed to unlock page or unlock page
incorrectly, fix them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 73338c432e7e4..b14c718139a96 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -325,8 +325,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			break;
 		}
 
-		if (!is_recoverable_dnode(page))
+		if (!is_recoverable_dnode(page)) {
+			f2fs_put_page(page, 1);
 			break;
+		}
 
 		if (!is_fsync_dnode(page))
 			goto next;
@@ -338,8 +340,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			if (!check_only &&
 					IS_INODE(page) && is_dent_dnode(page)) {
 				err = f2fs_recover_inode_page(sbi, page);
-				if (err)
+				if (err) {
+					f2fs_put_page(page, 1);
 					break;
+				}
 				quota_inode = true;
 			}
 
@@ -355,6 +359,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 					err = 0;
 					goto next;
 				}
+				f2fs_put_page(page, 1);
 				break;
 			}
 		}
@@ -370,6 +375,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 				"%s: detect looped node chain, "
 				"blkaddr:%u, next:%u",
 				__func__, blkaddr, next_blkaddr_of_node(page));
+			f2fs_put_page(page, 1);
 			err = -EINVAL;
 			break;
 		}
@@ -380,7 +386,6 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 
 		f2fs_ra_meta_pages_cond(sbi, blkaddr);
 	}
-	f2fs_put_page(page, 1);
 	return err;
 }
 
@@ -674,8 +679,10 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		 */
 		if (IS_INODE(page)) {
 			err = recover_inode(entry->inode, page);
-			if (err)
+			if (err) {
+				f2fs_put_page(page, 1);
 				break;
+			}
 		}
 		if (entry->last_dentry == blkaddr) {
 			err = recover_dentry(entry->inode, page, dir_list);
-- 
2.20.1
