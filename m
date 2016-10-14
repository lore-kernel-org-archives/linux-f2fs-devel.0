From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] libf2fs: avoid garbage printout
Date: Thu, 13 Oct 2016 17:02:28 -0700
Message-ID: <20161014000230.59232-3-jaegeuk@kernel.org>
References: <20161014000230.59232-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bupxg-0005Cn-A7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:02:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bupxf-0003NT-LS
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 14 Oct 2016 00:02:56 +0000
In-Reply-To: <20161014000230.59232-1-jaegeuk@kernel.org>
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

This patch avoids to print garbage data.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index d3311ca..63cf6d4 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -658,7 +658,7 @@ int f2fs_get_device_info(void)
 	struct hd_geometry geom;
 #ifndef WITH_ANDROID
 	sg_io_hdr_t io_hdr;
-	unsigned char reply_buffer[96];
+	unsigned char reply_buffer[96] = {0};
 	unsigned char model_inq[6] = {MODELINQUIRY};
 #endif
 	u_int64_t wanted_total_sectors = c.total_sectors;
@@ -725,7 +725,7 @@ int f2fs_get_device_info(void)
 			int i = 16;
 
 			MSG(0, "Info: Disk Model: ");
-			while (reply_buffer[i] != '`')
+			while (reply_buffer[i] != '`' && i < 80)
 				printf("%c", reply_buffer[i++]);
 			printf("\n");
 		}
-- 
2.8.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
