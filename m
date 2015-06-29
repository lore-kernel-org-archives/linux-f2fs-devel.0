From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 11/12] f2fs: add noextent_cache mount option
Date: Mon, 29 Jun 2015 11:39:35 -0700
Message-ID: <1435603176-63219-11-git-send-email-jaegeuk@kernel.org>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z9dyl-00031o-Gw
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z9dyi-0004fz-OY for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 18:40:27 +0000
In-Reply-To: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds noextent_cache mount option.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2e8645e..a9db896 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -65,6 +65,7 @@ enum {
 	Opt_nobarrier,
 	Opt_fastboot,
 	Opt_extent_cache,
+	Opt_noextent_cache,
 	Opt_noinline_data,
 	Opt_err,
 };
@@ -88,6 +89,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_nobarrier, "nobarrier"},
 	{Opt_fastboot, "fastboot"},
 	{Opt_extent_cache, "extent_cache"},
+	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_err, NULL},
 };
@@ -389,6 +391,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_extent_cache:
 			set_opt(sbi, EXTENT_CACHE);
 			break;
+		case Opt_noextent_cache:
+			clear_opt(sbi, EXTENT_CACHE);
+			break;
 		case Opt_noinline_data:
 			clear_opt(sbi, INLINE_DATA);
 			break;
-- 
2.1.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
