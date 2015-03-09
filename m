From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to calculate max length of contiguous free slots
 correctly
Date: Mon, 09 Mar 2015 17:33:16 +0800
Message-ID: <000701d05a4c$2fa0b520$8ee21f60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When lookuping for creating, we will try to record the level of current dentry
hash table if current dentry has enough contiguous slots for storing name of new
file which will be created later, this can save our lookup time when add a link
into parent dir.

But currently in find_target_dentry, our current length of contiguous free slots
is not calculated correctly. This make us leaving some holes in dentry block
occasionally, it wastes our space of dentry block.

Let's refactor the lookup flow for max slots as following to fix this issue:
a) increase max_len if current slot is free;
b) update max_slots with max_len if max_len is larger than max_slots;
c) reset max_len to zero if current slot is not free.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 1f1a1bc..6189e57 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -127,22 +127,19 @@ struct f2fs_dir_entry *find_target_dentry(struct qstr *name, int *max_slots,
 		*max_slots = 0;
 	while (bit_pos < d->max) {
 		if (!test_bit_le(bit_pos, d->bitmap)) {
-			if (bit_pos == 0)
-				max_len = 1;
-			else if (!test_bit_le(bit_pos - 1, d->bitmap))
-				max_len++;
 			bit_pos++;
+			max_len++;
 			continue;
 		}
+
 		de = &d->dentry[bit_pos];
 		if (early_match_name(name->len, namehash, de) &&
 			!memcmp(d->filename[bit_pos], name->name, name->len))
 			goto found;
 
-		if (max_slots && max_len > *max_slots) {
+		if (max_slots && max_len > *max_slots)
 			*max_slots = max_len;
-			max_len = 0;
-		}
+		max_len = 0;
 
 		/* remain bug on condition */
 		if (unlikely(!de->name_len))
-- 
2.3.1
