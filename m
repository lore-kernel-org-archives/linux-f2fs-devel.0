From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] mkfs.f2fs: show the info of volume label only
 when specify it
Date: Mon, 8 Oct 2018 20:39:07 +0800 (CST)
Message-ID: <7d9354b8.ca7b.16653b02e86.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <kernelpatch@126.com>) id 1g9Uoo-00064B-I3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Oct 2018 12:39:26 +0000
Received: from m15-33.126.com ([220.181.15.33])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1g9Uog-003Bmf-Ga
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Oct 2018 12:39:26 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Currently, when format disk used with mkfs.f2fs, even if the volume label
is not specified, it still shows the info of volume label with no content
due to the check condition is always true, this patch fixes it.

[root@localhost home]# mkfs.f2fs -f /dev/sdb1

	F2FS-tools: mkfs.f2fs Ver: 1.12.0 (2018-10-08)

Info: Disable heap-based policy
Info: Debug level = 0
Info: Label = 
Info: Trim is enabled

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 mkfs/f2fs_format_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 1424cc3..6ea8068 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -81,7 +81,7 @@ static void f2fs_show_info()
 	if (c.extension_list[1])
 		MSG(0, "Info: Add new hot file extension list\n");
 
-	if (c.vol_label)
+	if (strlen(c.vol_label))
 		MSG(0, "Info: Label = %s\n", c.vol_label);
 	MSG(0, "Info: Trim is %s\n", c.trim ? "enabled": "disabled");
 
-- 
1.8.3.1
