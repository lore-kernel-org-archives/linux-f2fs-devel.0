From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH 3/3] f2fs: always assume that the device is idle
 under gc_urgent
Date: Tue, 14 May 2019 15:36:23 +0900
Message-ID: <20190514063623.57162-3-qkrwngud825@gmail.com>
References: <20190514063623.57162-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hQR3Q-0006lR-0a
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 06:36:48 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hQR3M-0034TW-El
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 May 2019 06:36:47 +0000
Received: by mail-pf1-f196.google.com with SMTP id z26so8569943pfg.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 May 2019 23:36:44 -0700 (PDT)
In-Reply-To: <20190514063623.57162-1-qkrwngud825@gmail.com>
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

This allows more aggressive discards and balancing job to be done
under gc_urgent.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 fs/f2fs/f2fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 533fafca68f4..14c95116cd3d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2192,6 +2192,9 @@ static inline struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi,
 
 static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
+	if (sbi->gc_mode == GC_URGENT)
+		return true;
+
 	if (get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_RD_NODE) ||
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
 		get_pages(sbi, F2FS_WB_CP_DATA) ||
-- 
2.21.0
