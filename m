Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4F0D2ECE9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZvPGztjH1nm2Lq2I93ByPnBI3X/F7vME8ib3u7rbcQ=; b=Pb9aYHGeRYi7QqNRtrG3Cp2ET/
	O73qwPG9i2ViPwiKfFMGCS6kfUvxV9y27WQfAXWAc65nmTtor3exFG/55I4j/LPpo+/jXp1sHSWz0
	190lBTj1PDcK3XNVfV1ebx9Z1YocFhESQnGzxm2+csog7T0yPLv5iTkk8PsdbuTtQ5Cc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viCfc-0004CF-BT;
	Tue, 20 Jan 2026 14:25:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1viCfa-0004C1-Bd
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 14:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/sYfse2O7Z6KZXgJ1jKyn7oaEzvmj/SL/3tg2YQ47s0=; b=HsgAd+Qzm+8b36wtFhy4hnOyCN
 bQoU6V/6ni5GBoQeTDWe2Co29jebvteY01ckDCykr3jIv8t/rhW2sOezE4UdhCMmFv+ir35bL3nBm
 FxFVYFo7CbQG6JPqtDAGQcBqXlGIz7ik/aTN4chbfb1Fq/Ikc/OI6Mf0NK71yvF277wY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/sYfse2O7Z6KZXgJ1jKyn7oaEzvmj/SL/3tg2YQ47s0=; b=kzqd+rfiGjQzh5gGRYpQ+7qw7J
 GKt/oCPNGHmaSYSp1pg+5lekC25LUw5+LvUgaz5q8jOHWsQxFrwiFtHLPU3jacoCcVtFvATec4E+H
 6VdzZTKpYSh50bsTUV8msFp+OU6tbpywTSVfbvSQYvEWWTj4YMxaBS8zfENg0Yo82EAA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viCfa-00086j-GZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 14:25:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 531D460008;
 Tue, 20 Jan 2026 14:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD91BC16AAE;
 Tue, 20 Jan 2026 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768919122;
 bh=cWXqjiYSCBw218vhYxZFFr2kBXjHfrbsfjhWPCfq4hM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iJ6Fblv2qO5UvJg1OEulK5ftXItW8uXaGc2NMLqyGH1Wl4uYXjDvIzxIyCIW34me7
 roQstI1W1kQzW7f/voI3HkNp5c05XXFXyur1WMkblF2oh3xGAffuaMQ4PfJ03mmw6I
 CanZVoQGsc6x6BFOz2JYbeUSIo/rXcSpghB+BeevOvHclZMR89pammzN7/rQfpJROY
 /SkpwKqF+5NzyeSMMOL83xhvsVaezUhewsHQTjtEDC3KX+R84zoOKZZEjAE302tvMU
 GQMdObB2scsDnVC8URrNofXM3cMi3DTl4stLNOiueoVuFKJmOTTonWRRkN8kgUS9vu
 QFPTMmm8c5+rw==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Tue, 20 Jan 2026 09:24:39 -0500
Message-ID: <20260120142439.1821554-17-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120142439.1821554-1-cel@kernel.org>
References: <20260120142439.1821554-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1viCfa-00086j-GZ
Subject: [f2fs-dev] [PATCH v6 16/16] ksmbd: Report filesystem case
 sensitivity via FS_ATTRIBUTE_INFORMATION
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

ksmbd hard-codes FILE_CASE_SENSITIVE_SEARCH and
FILE_CASE_PRESERVED_NAMES in FS_ATTRIBUTE_INFORMATION responses,
incorrectly indicating all exports are case-sensitive. This breaks
clients accessing case-insensitive filesystems like exFAT or
ext4/f2fs directories with casefold enabled.

Query actual case behavior via vfs_fileattr_get() and report accurate
attributes to SMB clients. Filesystems without ->fileattr_get continue
reporting default POSIX behavior (case-sensitive, case-preserving).

SMB's FS_ATTRIBUTE_INFORMATION reports per-share attributes from the
share root, not per-file. Shares mixing casefold and non-casefold
directories report the root directory's behavior.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/server/smb2pdu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2fcd0d4d1fb0..257da9282bcf 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -13,6 +13,7 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fileattr.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
@@ -5486,16 +5487,28 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	case FS_ATTRIBUTE_INFORMATION:
 	{
 		FILE_SYSTEM_ATTRIBUTE_INFO *info;
+		struct file_kattr fa = {};
 		size_t sz;
+		u32 attrs;
+		int err;
 
 		info = (FILE_SYSTEM_ATTRIBUTE_INFO *)rsp->Buffer;
-		info->Attributes = cpu_to_le32(FILE_SUPPORTS_OBJECT_IDS |
-					       FILE_PERSISTENT_ACLS |
-					       FILE_UNICODE_ON_DISK |
-					       FILE_CASE_PRESERVED_NAMES |
-					       FILE_CASE_SENSITIVE_SEARCH |
-					       FILE_SUPPORTS_BLOCK_REFCOUNTING);
+		attrs = FILE_SUPPORTS_OBJECT_IDS |
+			FILE_PERSISTENT_ACLS |
+			FILE_UNICODE_ON_DISK |
+			FILE_SUPPORTS_BLOCK_REFCOUNTING;
 
+		err = vfs_fileattr_get(path.dentry, &fa);
+		if (err && err != -ENOIOCTLCMD) {
+			path_put(&path);
+			return err;
+		}
+		if (!(fa.fsx_xflags & FS_XFLAG_CASEFOLD))
+			attrs |= FILE_CASE_SENSITIVE_SEARCH;
+		if (!(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING))
+			attrs |= FILE_CASE_PRESERVED_NAMES;
+
+		info->Attributes = cpu_to_le32(attrs);
 		info->Attributes |= cpu_to_le32(server_conf.share_fake_fscaps);
 
 		if (test_share_config_flag(work->tcon->share_conf,
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
