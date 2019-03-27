From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 005/262] f2fs: fix to adapt small inline xattr space in __find_inline_xattr()
Date: Wed, 27 Mar 2019 13:57:40 -0400
Message-ID: <20190327180158.10245-5-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

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
index 18d5ffbc5e8c..73b92985198b 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -224,11 +224,11 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
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
@@ -239,6 +239,13 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
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
