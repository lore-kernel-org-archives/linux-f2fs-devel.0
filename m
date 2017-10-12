From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: return error number for quota_write
Date: Thu, 12 Oct 2017 16:15:00 -0700
Message-ID: <20171012231500.19489-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1e2mh1-0002Sv-S2
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Oct 2017 23:15:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e2mh1-0005PZ-5A
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Oct 2017 23:15:07 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch returns an error number to quota_write in order for quota to handle
it correctly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2feecf5e7f4c..840a0876005b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1397,8 +1397,11 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
 		err = a_ops->write_begin(NULL, mapping, off, tocopy, 0,
 							&page, NULL);
-		if (unlikely(err))
+		if (unlikely(err)) {
+			if (len == towrite)
+				return err;
 			break;
+		}
 
 		kaddr = kmap_atomic(page);
 		memcpy(kaddr + offset, data, tocopy);
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
