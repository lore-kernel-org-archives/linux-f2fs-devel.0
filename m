From: Kelly Anderson <kelly@xilka.com>
Subject: [PATCH]: remount - don't error on xattr and acl options
Date: Tue, 24 Sep 2013 16:41:45 -0600
Message-ID: <2098899.Kj1kDSIWdu@comer>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart11524138.g4E6JgEJo6"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kelly@xilka.com>) id 1VObrS-0001qm-Dm
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Sep 2013 23:17:42 +0000
Received: from ar100.montanavision.com ([216.146.103.100] helo=xilka.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VObrQ-0005sq-OE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Sep 2013 23:17:42 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk.kim@samsung.com

This is a multi-part message in MIME format.

--nextPart11524138.g4E6JgEJo6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

The current f2fs code errors if the xattr or acl options are passed when 
remounting.  This is important in a typical scenario where f2fs is mounted
as a "ro" root file-system by the boot loader and then the init process wants
to remount it "rw" with the "remount,rw" option.

The attached patch fixes the problem.

Included here for review.

--- ./fs/f2fs/super.c.orig	2013-09-22 19:17:07.713293098 -0600
+++ ./fs/f2fs/super.c	2013-09-22 19:27:59.604265911 -0600
@@ -43,7 +43,9 @@ enum {
 	Opt_disable_roll_forward,
 	Opt_discard,
 	Opt_noheap,
+	Opt_user_xattr,
 	Opt_nouser_xattr,
+	Opt_acl,
 	Opt_noacl,
 	Opt_active_logs,
 	Opt_disable_ext_identify,
@@ -56,7 +58,9 @@ static match_table_t f2fs_tokens = {
 	{Opt_disable_roll_forward, "disable_roll_forward"},
 	{Opt_discard, "discard"},
 	{Opt_noheap, "no_heap"},
+	{Opt_user_xattr, "user_xattr"},
 	{Opt_nouser_xattr, "nouser_xattr"},
+	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
 	{Opt_active_logs, "active_logs=%u"},
 	{Opt_disable_ext_identify, "disable_ext_identify"},
@@ -237,6 +241,9 @@ static int parse_options(struct super_bl
 			set_opt(sbi, NOHEAP);
 			break;
 #ifdef CONFIG_F2FS_FS_XATTR
+		case Opt_user_xattr:
+			set_opt(sbi, XATTR_USER);
+			break;
 		case Opt_nouser_xattr:
 			clear_opt(sbi, XATTR_USER);
 			break;
@@ -244,6 +251,10 @@ static int parse_options(struct super_bl
 			set_opt(sbi, INLINE_XATTR);
 			break;
 #else
+		case Opt_user_xattr:
+			f2fs_msg(sb, KERN_INFO,
+				"user_xattr options not supported");
+			break;
 		case Opt_nouser_xattr:
 			f2fs_msg(sb, KERN_INFO,
 				"nouser_xattr options not supported");
@@ -254,10 +265,16 @@ static int parse_options(struct super_bl
 			break;
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
+		case Opt_acl:
+			set_opt(sbi, POSIX_ACL);
+			break;
 		case Opt_noacl:
 			clear_opt(sbi, POSIX_ACL);
 			break;
 #else
+		case Opt_acl:
+			f2fs_msg(sb, KERN_INFO, "acl options not supported");
+			break;
 		case Opt_noacl:
 			f2fs_msg(sb, KERN_INFO, "noacl options not supported");
 			break;

--nextPart11524138.g4E6JgEJo6
Content-Disposition: attachment;
	filename="Kernel-3.12+-f2fs-dont-error-on-xattr-and-acl-options.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8";
	name="Kernel-3.12+-f2fs-dont-error-on-xattr-and-acl-options.patch"

--- ./fs/f2fs/super.c.orig	2013-09-22 19:17:07.713293098 -0600
+++ ./fs/f2fs/super.c	2013-09-22 19:27:59.604265911 -0600
@@ -43,7 +43,9 @@ enum {
 	Opt_disable_roll_forward,
 	Opt_discard,
 	Opt_noheap,
+	Opt_user_xattr,
 	Opt_nouser_xattr,
+	Opt_acl,
 	Opt_noacl,
 	Opt_active_logs,
 	Opt_disable_ext_identify,
@@ -56,7 +58,9 @@ static match_table_t f2fs_tokens = {
 	{Opt_disable_roll_forward, "disable_roll_forward"},
 	{Opt_discard, "discard"},
 	{Opt_noheap, "no_heap"},
+	{Opt_user_xattr, "user_xattr"},
 	{Opt_nouser_xattr, "nouser_xattr"},
+	{Opt_acl, "acl"},
 	{Opt_noacl, "noacl"},
 	{Opt_active_logs, "active_logs=%u"},
 	{Opt_disable_ext_identify, "disable_ext_identify"},
@@ -237,6 +241,9 @@ static int parse_options(struct super_bl
 			set_opt(sbi, NOHEAP);
 			break;
 #ifdef CONFIG_F2FS_FS_XATTR
+		case Opt_user_xattr:
+			set_opt(sbi, XATTR_USER);
+			break;
 		case Opt_nouser_xattr:
 			clear_opt(sbi, XATTR_USER);
 			break;
@@ -244,6 +251,10 @@ static int parse_options(struct super_bl
 			set_opt(sbi, INLINE_XATTR);
 			break;
 #else
+		case Opt_user_xattr:
+			f2fs_msg(sb, KERN_INFO,
+				"user_xattr options not supported");
+			break;
 		case Opt_nouser_xattr:
 			f2fs_msg(sb, KERN_INFO,
 				"nouser_xattr options not supported");
@@ -254,10 +265,16 @@ static int parse_options(struct super_bl
 			break;
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
+		case Opt_acl:
+			set_opt(sbi, POSIX_ACL);
+			break;
 		case Opt_noacl:
 			clear_opt(sbi, POSIX_ACL);
 			break;
 #else
+		case Opt_acl:
+			f2fs_msg(sb, KERN_INFO, "acl options not supported");
+			break;
 		case Opt_noacl:
 			f2fs_msg(sb, KERN_INFO, "noacl options not supported");
 			break;

--nextPart11524138.g4E6JgEJo6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
--nextPart11524138.g4E6JgEJo6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--nextPart11524138.g4E6JgEJo6--
