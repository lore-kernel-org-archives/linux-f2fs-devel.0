From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 003/192] f2fs: fix to adapt small
 inline xattr space in __find_inline_xattr()
Date: Wed, 27 Mar 2019 14:07:15 -0400
Message-ID: <20190327181025.13507-3-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1h9D0V-0004xQ-Pa
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 18:10:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h9D0U-00CjeQ-Kp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 18:10:35 +0000
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
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

[ Upstream commit 2c28aba8b2e2a51749fa66e01b68e1cd5b53e022 ]

With below testcase, we will fail to find existed xattr entry:

1. mkfs.f2fs -O extra_attr -O flexible_inline_xattr /dev/zram0
2. mount -t f2fs -o inline_xattr_size=1 /dev/zram0 /mnt/f2fs/
3. touch /mnt/f2fs/file
4. setfattr -n "user.name" -v 0 /mnt/f2fs/file
5. getfattr -n "user.name" /mnt/f2fs/file

/mnt/f2fs/file: user.name: No such attribute

The reason is for inode which has very small inline xattr size,
__find_inline_xattr() will fail to traverse any entry due to first
entry may not be loaded from xattr node yet, later, we may skip to
check entire xattr datas in __find_xattr(), result in such wrong
condition.

This patch adds condition to check such case to avoid this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/xattr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 087e53a2d96c..409a637f7a92 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -227,11 +227,11 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
 {
 	struct f2fs_xattr_entry *entry;
 	unsigned int inline_size = inline_xattr_size(inode);
+	void *max_addr = base_addr + inline_size;
 
 	list_for_each_xattr(entry, base_addr) {
-		if ((void *)entry + sizeof(__u32) > base_addr + inline_size ||
-			(void *)XATTR_NEXT_ENTRY(entry) + sizeof(__u32) >
-			base_addr + inline_size) {
+		if ((void *)entry + sizeof(__u32) > max_addr ||
+			(void *)XATTR_NEXT_ENTRY(entry) > max_addr) {
 			*last_addr = entry;
 			return NULL;
 		}
@@ -242,6 +242,13 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
 		if (!memcmp(entry->e_name, name, len))
 			break;
 	}
+
+	/* inline xattr header or entry across max inline xattr size */
+	if (IS_XATTR_LAST_ENTRY(entry) &&
+		(void *)entry + sizeof(__u32) > max_addr) {
+		*last_addr = entry;
+		return NULL;
+	}
 	return entry;
 }
 
-- 
2.19.1
