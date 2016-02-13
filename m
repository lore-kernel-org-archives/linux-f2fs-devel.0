From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: avoid garbage lenghs in dentries
Date: Fri, 12 Feb 2016 18:56:35 -0800
Message-ID: <1455332195-76333-3-git-send-email-jaegeuk@kernel.org>
References: <1455332195-76333-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aUQO7-0000jg-RF
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 13 Feb 2016 02:56:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aUQO7-0001oP-3v
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 13 Feb 2016 02:56:47 +0000
In-Reply-To: <1455332195-76333-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes to eliminate garbage name lengths in dentries in order
to provide correct answers of readdir.

For example, if a valid dentry consists of:
 bitmap : 1   1 1 1
 len    : 32  0 x 0,

readdir can start with second bit_pos having len = 0.
Or, it can start with third bit_pos having garbage.

In both of cases, we should avoid to try filling dentries.
So, this patch not only removes any garbage length, but also avoid entering
zero length case in readdir.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8950fc3..ca41b2a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -511,8 +511,12 @@ void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 	memcpy(d->filename[bit_pos], name->name, name->len);
 	de->ino = cpu_to_le32(ino);
 	set_de_type(de, mode);
-	for (i = 0; i < slots; i++)
+	for (i = 0; i < slots; i++) {
 		test_and_set_bit_le(bit_pos + i, (void *)d->bitmap);
+		/* avoid wrong garbage data for readdir */
+		if (i)
+			(de + i)->name_len = 0;
+	}
 }
 
 /*
@@ -792,6 +796,12 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			break;
 
 		de = &d->dentry[bit_pos];
+		if (de->name_len == 0) {
+			bit_pos++;
+			ctx->pos = start_pos + bit_pos;
+			continue;
+		}
+
 		if (de->file_type < F2FS_FT_MAX)
 			d_type = f2fs_filetype_table[de->file_type];
 		else
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
