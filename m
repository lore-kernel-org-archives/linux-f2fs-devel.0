From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 4/7] mkfs.f2fs: Check options for zoned block
	devices
Date: Fri, 28 Oct 2016 16:57:01 +0900
Message-ID: <1477641424-12367-6-git-send-email-damien.lemoal@wdc.com>
References: <1477641424-12367-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02H8-0006QY-KR
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:30 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02H7-0000bd-M6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:12:30 +0000
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

Trim must not be disabled with zoned mode.
For host-managed zoned block devices, the zoned mode is mandatory.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 mkfs/f2fs_format_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index c417829..26308fc 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -151,6 +151,22 @@ int main(int argc, char *argv[])
 	if (f2fs_get_device_info(&config) < 0)
 		return -1;
 
+	/*
+	 * Some options are mandatory for host-managed
+	 * zoned block devices.
+	 */
+	if (config.zoned_model == F2FS_ZONED_HM &&
+	    !config.zoned_mode) {
+		MSG(0, "\tError: zoned block device feature is required\n");
+		return -1;
+	}
+
+	if (config.zoned_mode &&
+	    !config.trim) {
+		MSG(0, "\tError: Trim is required for zoned block devices\n");
+		return -1;
+	}
+
 	if (f2fs_format_device() < 0)
 		return -1;
 
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
