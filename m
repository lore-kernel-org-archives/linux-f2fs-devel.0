From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix wrong casting for dentry name
Date: Fri, 29 Aug 2014 09:55:52 -0700
Message-ID: <1409331352-36388-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNPT2-0004sX-FC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 16:56:04 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNPT1-0003SQ-Fp for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 29 Aug 2014 16:56:04 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The dentry name type is unsigned char *.
If we don't match this type, some character codes can be changed by signed bit.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/hash.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index 948d17bf..a844fcf 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -42,7 +42,8 @@ static void TEA_transform(unsigned int buf[4], unsigned int const in[])
 	buf[1] += b1;
 }
 
-static void str2hashbuf(const char *msg, size_t len, unsigned int *buf, int num)
+static void str2hashbuf(const unsigned char *msg, size_t len,
+				unsigned int *buf, int num)
 {
 	unsigned pad, val;
 	int i;
@@ -73,9 +74,9 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info)
 {
 	__u32 hash;
 	f2fs_hash_t f2fs_hash;
-	const char *p;
+	const unsigned char *p;
 	__u32 in[8], buf[4];
-	const char *name = name_info->name;
+	const unsigned char *name = name_info->name;
 	size_t len = name_info->len;
 
 	if ((len <= 2) && (name[0] == '.') &&
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
