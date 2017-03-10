From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 1/4] f2fs: drop duplicate new_size assign in
	f2fs_zero_range
Date: Fri, 10 Mar 2017 17:54:03 +0800
Message-ID: <74a33c86-dfcf-9e37-4eb2-e57761e6a32c@gmail.com>
References: <504f870a-7012-fa63-c4c3-a9a8713d5a8a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cmHFY-0004iz-AN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:54:16 +0000
Received: from mail-io0-f194.google.com ([209.85.223.194])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cmHFX-0007qw-Ma
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:54:16 +0000
Received: by mail-io0-f194.google.com with SMTP id f103so6487477ioi.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 10 Mar 2017 01:54:15 -0800 (PST)
In-Reply-To: <504f870a-7012-fa63-c4c3-a9a8713d5a8a@gmail.com>
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

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8c7923f..5f8d600 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1189,8 +1189,6 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 		if (ret)
 			return ret;
 
-		if (offset + len > new_size)
-			new_size = offset + len;
 		new_size = max_t(loff_t, new_size, offset + len);
 	} else {
 		if (off_start) {
-- 
2.9.3


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
