From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/3] f2fs: remove costly bit operations for
	f2fs_find_entry
Date: Thu, 27 Feb 2014 20:38:37 +0900
Message-ID: <1393501119-12976-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WIzKF-00047x-Af
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 11:40:27 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WIzKD-00043G-EG
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 11:40:27 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N1N006VEKF6WL90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 20:40:18 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

It turns out that a bit operation like find_next_bit is not always fast enough
for f2fs_find_entry.
Instead, it is pretty much simple and fast to traverse each dentries.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index d5a2c9e..c3ea8f8 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -93,16 +93,20 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 			f2fs_hash_t namehash, struct page **res_page)
 {
 	struct f2fs_dir_entry *de;
-	unsigned long bit_pos, end_pos, next_pos;
+	unsigned long bit_pos = 0;
 	struct f2fs_dentry_block *dentry_blk = kmap(dentry_page);
-	int slots;
+	int max_len = 0;
 
-	bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
-					NR_DENTRY_IN_BLOCK, 0);
 	while (bit_pos < NR_DENTRY_IN_BLOCK) {
 		de = &dentry_blk->dentry[bit_pos];
-		slots = GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
-
+		if (!test_bit_le(bit_pos, &dentry_blk->dentry_bitmap)) {
+			if (bit_pos == 0)
+				max_len = 1;
+			else if (!test_bit_le(bit_pos - 1, &dentry_blk->dentry_bitmap))
+				max_len++;
+			bit_pos++;
+			continue;
+		}
 		if (early_match_name(name, namelen, namehash, de)) {
 			if (!memcmp(dentry_blk->filename[bit_pos],
 							name, namelen)) {
@@ -110,20 +114,18 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 				goto found;
 			}
 		}
-		next_pos = bit_pos + slots;
-		bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
-				NR_DENTRY_IN_BLOCK, next_pos);
-		if (bit_pos >= NR_DENTRY_IN_BLOCK)
-			end_pos = NR_DENTRY_IN_BLOCK;
-		else
-			end_pos = bit_pos;
-		if (*max_slots < end_pos - next_pos)
-			*max_slots = end_pos - next_pos;
+		if (max_len > *max_slots) {
+			*max_slots = max_len;
+			max_len = 0;
+		}
+		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 	}
 
 	de = NULL;
 	kunmap(dentry_page);
 found:
+	if (max_len > *max_slots)
+		*max_slots = max_len;
 	return de;
 }
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
