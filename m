From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: use strncasecmp() simplify the string comparison
Date: Thu, 22 Aug 2013 18:11:25 +0800
Message-ID: <5215E3CD.5000903@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, fsdevel <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/namei.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 4e47518..106c0b4 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -83,21 +83,11 @@ static int is_multimedia_file(const unsigned char *s, const char *sub)
 {
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
-	int ret;
 
 	if (sublen > slen)
 		return 0;
 
-	ret = memcmp(s + slen - sublen, sub, sublen);
-	if (ret) {	/* compare upper case */
-		int i;
-		char upper_sub[8];
-		for (i = 0; i < sublen && i < sizeof(upper_sub); i++)
-			upper_sub[i] = toupper(sub[i]);
-		return !memcmp(s + slen - sublen, upper_sub, sublen);
-	}
-
-	return !ret;
+	return !strncasecmp(s + slen - sublen, sub, sublen);
 }
 
 /*
-- 
1.7.7
