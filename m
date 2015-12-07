From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: enhance the bit operation for SSR
Date: Mon,  7 Dec 2015 14:53:23 -0800
Message-ID: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch enhances the existing bit operation when f2fs allocates SSR
blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 74c4748..5fa519f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -132,47 +132,37 @@ static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
 			unsigned long size, unsigned long offset)
 {
 	const unsigned long *p = addr + BIT_WORD(offset);
-	unsigned long result = offset & ~(BITS_PER_LONG - 1);
+	unsigned long result = size;
 	unsigned long tmp;
 
 	if (offset >= size)
 		return size;
 
-	size -= result;
+	size -= (offset & ~(BITS_PER_LONG - 1));
 	offset %= BITS_PER_LONG;
-	if (!offset)
-		goto aligned;
-
-	tmp = __reverse_ulong((unsigned char *)p);
-	tmp |= ~((~0UL << offset) >> offset);
-
-	if (size < BITS_PER_LONG)
-		goto found_first;
-	if (tmp != ~0UL)
-		goto found_middle;
-
-	size -= BITS_PER_LONG;
-	result += BITS_PER_LONG;
-	p++;
-aligned:
-	while (size & ~(BITS_PER_LONG - 1)) {
+
+	while (1) {
+		if (*p == ~0UL)
+			goto pass;
+
 		tmp = __reverse_ulong((unsigned char *)p);
+
+		if (offset)
+			tmp |= ~0UL << (BITS_PER_LONG - offset);
+		if (size < BITS_PER_LONG)
+			tmp |= ~0UL >> size;
 		if (tmp != ~0UL)
-			goto found_middle;
-		result += BITS_PER_LONG;
+			goto found;
+pass:
+		if (size <= BITS_PER_LONG)
+			break;
 		size -= BITS_PER_LONG;
+		offset = 0;
 		p++;
 	}
-	if (!size)
-		return result;
-
-	tmp = __reverse_ulong((unsigned char *)p);
-found_first:
-	tmp |= ~(~0UL << (BITS_PER_LONG - size));
-	if (tmp == ~0UL)	/* Are any bits zero? */
-		return result + size;   /* Nope. */
-found_middle:
-	return result + __reverse_ffz(tmp);
+	return result;
+found:
+	return result - size + __reverse_ffz(tmp);
 }
 
 void register_inmem_page(struct inode *inode, struct page *page)
-- 
2.4.9 (Apple Git-60)
