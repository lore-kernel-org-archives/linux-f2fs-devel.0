From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 2/4] f2fs: avoid copy date to user-space if move
 file range fail
Date: Fri, 10 Mar 2017 17:54:26 +0800
Message-ID: <e86d08e6-ef2f-4afc-e3f4-c5d1ba0aa6a0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cmHFs-0007Ec-TL
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:54:36 +0000
Received: from mail-it0-f66.google.com ([209.85.214.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cmHFs-0001xl-96
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:54:36 +0000
Received: by mail-it0-f66.google.com with SMTP id r141so832376ita.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 10 Mar 2017 01:54:36 -0800 (PST)
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

If move file range return error, the data copied to user-space is duplicate.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5f8d600..88afe0f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2194,6 +2194,8 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 					range.pos_out, range.len);
 
 	mnt_drop_write_file(filp);
+	if (err)
+		goto err_out;
 
 	if (copy_to_user((struct f2fs_move_range __user *)arg,
 						&range, sizeof(range)))
-- 
2.9.3


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
