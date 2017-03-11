From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: le32_to_cpu for
	ckpt->cp_pack_total_block_count
Date: Sat, 11 Mar 2017 21:18:01 +0800
Message-ID: <1c205f52-5e3f-c5c7-80e6-8a3a0dd91482@gmail.com>
References: <c73faa3e-07c8-0bc0-f22a-64f912030369@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cmguW-0005E3-Ve
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Mar 2017 13:18:16 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cmguW-0000DF-8A
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Mar 2017 13:18:16 +0000
Received: by mail-it0-f68.google.com with SMTP id w185so1938395ita.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 11 Mar 2017 05:18:16 -0800 (PST)
In-Reply-To: <c73faa3e-07c8-0bc0-f22a-64f912030369@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Fixes: 22ad0b6ab4 ("f2fs: add bitmaps for empty or full NAT blocks")
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/checkpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4db995c..41f6a42 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1025,7 +1025,8 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	spin_lock(&sbi->cp_lock);
 
-	if (cpc->reason == CP_UMOUNT && ckpt->cp_pack_total_block_count >
+	if (cpc->reason == CP_UMOUNT &&
+	    le32_to_cpu(ckpt->cp_pack_total_block_count) >
 			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
 		disable_nat_bits(sbi, false);
 
-- 
2.9.3


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
