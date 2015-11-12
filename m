From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: optimize __find_rev_next_bit
Date: Thu, 12 Nov 2015 08:43:04 +0800
Message-ID: <000001d11ce3$2f947f30$8ebd7d90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1ZwfzX-0005nW-95
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Nov 2015 00:43:55 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZwfzV-0001VT-35
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Nov 2015 00:43:55 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NXO00X28FCQGI60@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Nov 2015 09:43:45 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

1. Skip __reverse_ulong if the bitmap is empty.
2. Reduce branches and codes.
According to my test, the performance of this new version is 5% higher on 
an empty bitmap of 64bytes, and remains about the same in the worst scenario.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/segment.c |   46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f77b325..efbf6b5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -86,6 +86,7 @@ static inline unsigned long __reverse_ffs(unsigned long word)
 /*
  * __find_rev_next(_zero)_bit is copied from lib/find_next_bit.c because
  * f2fs_set_bit makes MSB and LSB reversed in a byte.
+ * @size must be integral times of unsigned long.
  * Example:
  *                             MSB <--> LSB
  *   f2fs_set_bit(0, bitmap) => 1000 0000
@@ -95,47 +96,36 @@ static unsigned long __find_rev_next_bit(const unsigned long *addr,
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
 
-	tmp = __reverse_ulong((unsigned char *)p);
-	tmp &= ~0UL >> offset;
-
-	if (size < BITS_PER_LONG)
-		goto found_first;
-	if (tmp)
-		goto found_middle;
+	while (1) {
+		if (*p == 0)
+			goto pass;
 
-	size -= BITS_PER_LONG;
-	result += BITS_PER_LONG;
-	p++;
-aligned:
-	while (size & ~(BITS_PER_LONG-1)) {
 		tmp = __reverse_ulong((unsigned char *)p);
+
+		tmp &= ~0UL >> offset;
+		if (size < BITS_PER_LONG)
+			tmp &= (~0UL << (BITS_PER_LONG - size));
 		if (tmp)
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
-	tmp &= (~0UL << (BITS_PER_LONG - size));
-	if (!tmp)		/* Are any bits set? */
-		return result + size;   /* Nope. */
-found_middle:
-	return result + __reverse_ffs(tmp);
+	return result;
+found:
+	return result - size + __reverse_ffs(tmp);
 }
 
 static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
-- 
1.7.9.5


------------------------------------------------------------------------------
