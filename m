From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 7/7] fsck.f2fs: Check BLKZONED feature on mount
Date: Fri, 28 Oct 2016 16:57:04 +0900
Message-ID: <1477641424-12367-9-git-send-email-damien.lemoal@wdc.com>
References: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02Gl-00036t-UP
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:08 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02Gj-0007AL-Le
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:07 +0000
In-Reply-To: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
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
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-f2fs-devel@lists.sourceforge.net

The BLKZONED feature is mandatory for host-managed zoned block
devices. So check that it is set.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fsck/mount.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index dead207..6e27a5b 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -394,6 +394,13 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
 					get_sb(root_ino) != 3)
 		return -1;
 
+	/* Check zoned block device feature */
+	if (config.zoned_model == F2FS_ZONED_HM &&
+	    (!(sb->feature & cpu_to_le32(F2FS_FEATURE_BLKZONED)))) {
+		MSG(0, "\tMissing zoned block device feature\n");
+		return -1;
+	}
+
 	if (sanity_check_area_boundary(sb, offset))
 		return -1;
 	return 0;
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
