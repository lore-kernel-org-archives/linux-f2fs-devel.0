From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 3/9] f2fs: Check zoned block feature for
	host-managed zoned block devices
Date: Fri, 28 Oct 2016 17:45:01 +0900
Message-ID: <1477644307-30115-4-git-send-email-damien.lemoal@wdc.com>
References: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02o6-0004Z7-88
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:34 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02o5-0003fN-BH
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:34 +0000
In-Reply-To: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Le Moal <damien.lemoal@wdc.com>, Damien, linux-f2fs-devel@lists.sourceforge.net, Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-fsdevel@vger.kernel.org

The F2FS_FEATURE_BLKZONED feature indicates that the drive was formatted
 with zone alignment optimization. This is optional for host-aware
devices, but mandatory for host-managed zoned block devices.
So check that the feature is set in this latter case.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/super.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a83df29..c6e9b94 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1642,6 +1642,26 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
 
+	/*
+	 * The BLKZONED feature indicates that the drive was formatted with
+	 * zone alignment optimization. This is optional for host-aware
+	 * devices, but mandatory for host-managed zoned block devices.
+	 */
+#ifndef CONFIG_BLK_DEV_ZONED
+	if (f2fs_sb_mounted_blkzoned(sb)) {
+		f2fs_msg(sb, KERN_ERR,
+			 "Zoned block device support is not enabled\n");
+		goto free_sb_buf;
+	}
+#else
+	if (bdev_zoned_model(sb->s_bdev) == BLK_ZONED_HM &&
+	    !f2fs_sb_mounted_blkzoned(sb)) {
+		f2fs_msg(sb, KERN_ERR,
+			 "Zoned block device feature not enabled\n");
+		goto free_sb_buf;
+	}
+#endif
+
 	default_options(sbi);
 	/* parse mount options */
 	options = kstrdup((const char *)data, GFP_KERNEL);
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.


------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik
