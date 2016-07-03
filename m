From: Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: add nodiscard mount option
Date: Sun,  3 Jul 2016 22:05:14 +0800
Message-ID: <1467554714-5125-4-git-send-email-chao@kernel.org>
References: <1467554714-5125-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bJi3b-0007lB-Lq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jul 2016 14:07:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bJi3a-00012g-UP
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jul 2016 14:07:35 +0000
In-Reply-To: <1467554714-5125-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds 'nodiscard' mount option.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt | 4 +++-
 fs/f2fs/super.c                    | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 3a5ce24..ecd8080 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -109,7 +109,9 @@ background_gc=%s       Turn on/off cleaning operations, namely garbage
 disable_roll_forward   Disable the roll-forward recovery routine
 norecovery             Disable the roll-forward recovery routine, mounted read-
                        only (i.e., -o ro,disable_roll_forward)
-discard                Issue discard/TRIM commands when a segment is cleaned.
+discard/nodiscard      Enable/disable real-time discard in f2fs, if discard is
+                       enabled, f2fs will issue discard/TRIM commands when a
+		       segment is cleaned.
 no_heap                Disable heap-style segment allocation which finds free
                        segments for data from the beginning of main area, while
 		       for node from the end of main area.
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 512bbb4..7b9b0c9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -76,6 +76,7 @@ enum {
 	Opt_disable_roll_forward,
 	Opt_norecovery,
 	Opt_discard,
+	Opt_nodiscard,
 	Opt_noheap,
 	Opt_user_xattr,
 	Opt_nouser_xattr,
@@ -106,6 +107,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_disable_roll_forward, "disable_roll_forward"},
 	{Opt_norecovery, "norecovery"},
 	{Opt_discard, "discard"},
+	{Opt_nodiscard, "nodiscard"},
 	{Opt_noheap, "no_heap"},
 	{Opt_user_xattr, "user_xattr"},
 	{Opt_nouser_xattr, "nouser_xattr"},
@@ -426,6 +428,8 @@ static int parse_options(struct super_block *sb, char *options)
 					"the device does not support discard");
 			}
 			break;
+		case Opt_nodiscard:
+			clear_opt(sbi, DISCARD);
 		case Opt_noheap:
 			set_opt(sbi, NOHEAP);
 			break;
-- 
2.7.2


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
