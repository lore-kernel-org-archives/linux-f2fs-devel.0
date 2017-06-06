From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] mkfs.f2fs: drop initial spaces for feature
 string
Date: Mon,  5 Jun 2017 18:34:57 -0700
Message-ID: <20170606013457.67454-2-jaegeuk@kernel.org>
References: <20170606013457.67454-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dI3Om-0006dV-0Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jun 2017 01:35:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dI3Ok-0008Uc-3G
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jun 2017 01:35:07 +0000
In-Reply-To: <20170606013457.67454-1-jaegeuk@kernel.org>
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

This patch removes initial spaces to detect correct feature string.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index e645ccb..a3652a9 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -70,6 +70,8 @@ static void f2fs_show_info()
 
 static void parse_feature(const char *features)
 {
+	while (*features == ' ')
+		features++;
 	if (!strcmp(features, "encrypt")) {
 		c.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
 	} else {
-- 
2.13.0.rc1.294.g07d810a77f-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
