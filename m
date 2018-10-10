From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: do not hard-code encrypted filename
 length to avoid heap buffer overflow
Date: Tue,  9 Oct 2018 17:46:47 -0700
Message-ID: <20181010004647.21630-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gA2eP-0005hf-TW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Oct 2018 00:46:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gA2eO-00FXye-I9
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Oct 2018 00:46:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

From: Randall Huang <huangrandall@google.com>

If the len is less than 24, heap buffer overflow is reported.

Signed-off-by: Randall Huang <huangrandall@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 85d9823..1fc168f 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1170,10 +1170,12 @@ int convert_encrypted_name(unsigned char *name, u32 len,
 		memcpy(new, name, len);
 		new[len] = 0;
 		return len;
+	} else if (len != 24) {
+		ASSERT_MSG("len: %d, encrypted name must be 24\n", len);
 	}
 
 	*new = '_';
-	return digest_encode((const char *)name, 24, (char *)new + 1);
+	return digest_encode((const char *)name, len, (char *)new + 1);
 }
 
 static void print_dentry(__u32 depth, __u8 *name,
-- 
2.19.0.605.g01d371f741-goog
