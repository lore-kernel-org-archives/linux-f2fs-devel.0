From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] mkfs.f2fs: don't need to limit MIN_VOLUME
	SIZE
Date: Mon, 10 Aug 2015 18:23:48 -0700
Message-ID: <1439256228-8982-3-git-send-email-jaegeuk@kernel.org>
References: <1439256228-8982-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZOyIW-0001dD-7d
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 01:24:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZOyIU-0003ki-Ez for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Aug 2015 01:24:12 +0000
In-Reply-To: <1439256228-8982-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The minimum volume size is determined while preparing superblock.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h | 1 -
 lib/libf2fs.c     | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 59cc0d1..38a774c 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -209,7 +209,6 @@ static inline uint64_t bswap_64(uint64_t val)
 #define CHECKSUM_OFFSET		4092
 
 /* for mkfs */
-#define F2FS_MIN_VOLUME_SIZE	104857600
 #define	F2FS_NUMBER_OF_CHECKPOINT_PACK	2
 #define	DEFAULT_SECTOR_SIZE		512
 #define	DEFAULT_SECTORS_PER_BLOCK	8
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index e8f4d47..83d1296 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -499,13 +499,6 @@ int f2fs_get_device_info(struct f2fs_configuration *c)
 	MSG(0, "Info: sector size = %u\n", c->sector_size);
 	MSG(0, "Info: total sectors = %"PRIu64" (%"PRIu64" MB)\n",
 				c->total_sectors, c->total_sectors >> 11);
-	if (c->total_sectors <
-			(F2FS_MIN_VOLUME_SIZE / c->sector_size)) {
-		MSG(0, "Error: Min volume size supported is %d\n",
-				F2FS_MIN_VOLUME_SIZE);
-		return -1;
-	}
-
 	return 0;
 }
 
-- 
2.1.1


------------------------------------------------------------------------------
