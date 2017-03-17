From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 1/2] fsck.f2fs: fix bad notice of missing device
Date: Fri, 17 Mar 2017 21:55:50 +0800
Message-ID: <5dab8657-2e51-3096-ac6c-3b033e13c19b@gmail.com>
References: <e1f0d651-9e81-2030-5d76-de17bac2b188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cosMV-0003Xt-LJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 13:56:11 +0000
Received: from mail-it0-f66.google.com ([209.85.214.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cosMT-0006MO-IU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 13:56:11 +0000
Received: by mail-it0-f66.google.com with SMTP id y18so4125664itc.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 06:56:09 -0700 (PDT)
In-Reply-To: <e1f0d651-9e81-2030-5d76-de17bac2b188@gmail.com>
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

The following messages is better than before.

Before,
# fsck.f2fs -d 1
    Error: Need argument for -d

Now,
# fsck.f2fs -d 1
Info: Debug level = 1
        Error: Device not specified

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fsck/main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index cf1e8af..88fe5f8 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -114,8 +114,6 @@ void f2fs_parse_options(int argc, char *argv[])
 		MSG(0, "\tError: Device not specified\n");
 		error_out(prog);
 	}
-	c.devices[0].path = strdup(argv[argc - 1]);
-	argv[argc-- - 1] = 0;
 
 	if (!strcmp("fsck.f2fs", prog)) {
 		const char *option_string = ":ad:fp:t";
@@ -372,7 +370,14 @@ void f2fs_parse_options(int argc, char *argv[])
 				break;
 		}
 	}
-	if (argc > optind) {
+
+	if (optind >= argc) {
+		MSG(0, "\tError: Device not specified\n");
+		error_out(prog);
+	}
+
+	c.devices[0].path = strdup(argv[optind]);
+	if (argc > (optind + 1)) {
 		c.dbg_lv = 0;
 		err = EUNKNOWN_ARG;
 	}
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
