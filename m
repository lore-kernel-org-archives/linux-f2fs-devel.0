From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: do not hard-code encrypted
 filename length to avoid heap buffer overflow
Date: Mon, 15 Oct 2018 16:05:47 -0700
Message-ID: <20181015230547.GB1296@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181010004647.21630-1-jaegeuk@kernel.org>
 <5897b733-2b8e-f9d0-9312-2cf3b0f6224a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gCBvw-0005e6-9r
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Oct 2018 23:05:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCBvv-004LMa-0I
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Oct 2018 23:05:56 +0000
Content-Disposition: inline
In-Reply-To: <5897b733-2b8e-f9d0-9312-2cf3b0f6224a@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 10/15, Chao Yu wrote:
> On 2018/10/10 8:46, Jaegeuk Kim wrote:
> > From: Randall Huang <huangrandall@google.com>
> > 
> > If the len is less than 24, heap buffer overflow is reported.
> > 
> > Signed-off-by: Randall Huang <huangrandall@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,

The correct one should be this.

>From e78b033dea8ec556b9b4c216426150317a8e5640 Mon Sep 17 00:00:00 2001
From: Randall Huang <huangrandall@google.com>
Date: Tue, 9 Oct 2018 17:38:01 -0700
Subject: [PATCH] fsck.f2fs: do not hard-code encrypted filename length to
 avoid heap buffer overflow

If the len is less than 24, heap buffer overflow is reported.

Signed-off-by: Randall Huang <huangrandall@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 85d9823..366ba13 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1145,7 +1145,7 @@ static int digest_encode(const char *src, int len, char *dst)
 	int i = 0, bits = 0, ac = 0;
 	char *cp = dst;
 
-	while (i < len) {
+	while (i < len && i < 24) {
 		ac += (((unsigned char) src[i]) << bits);
 		bits += 8;
 		do {
@@ -1173,7 +1173,7 @@ int convert_encrypted_name(unsigned char *name, u32 len,
 	}
 
 	*new = '_';
-	return digest_encode((const char *)name, 24, (char *)new + 1);
+	return digest_encode((const char *)name, len, (char *)new + 1);
 }
 
 static void print_dentry(__u32 depth, __u8 *name,
-- 
2.19.0.605.g01d371f741-goog
