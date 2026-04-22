Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A684FAD3E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tn6n/oADx1AWU2ZYo2oLGyRh0trfk3yWgY1zJoQqACs=; b=RH8NZLpsrRyudRBBOmF/rNsQJF
	wK5C/DMrkLEsvd8PU2BbEv6LCA64FZa74/UzoEccju91BzGMCvlcg6Cg8yIodOqx6FNI16MGJWnHB
	NBBArzM87EUpXlHmPMU+YAyfoVX/GfQNM6au8Oug3KjYE0cZj1svtOhKhQmtlN1HRlTk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh25-0001Bd-8A;
	Wed, 22 Apr 2026 23:31:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFh23-0001BG-UL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ggka5slnQSuyrX8QAr4ZGJ/LgY/WXK9SfSsq1RqeDgw=; b=LznCQXifYTH+2QGrpmpVktf0Cv
 eMm3s1zEEzMMxFc9y2L+z05Eo8m6WY3rT/IvFsEOdXBt0zWSRyztiANLyhBpHZHYPryKUnSRjLoOk
 ivysbIopPPGbii4gfmX5orv8Fx4iWZVIi59VLHbGq2CVkjZ52P2Vv5gCLgM14hBR7s2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ggka5slnQSuyrX8QAr4ZGJ/LgY/WXK9SfSsq1RqeDgw=; b=VT+bRlGdR0xFq08qk3ZEV/qm24
 SEgCiCop8iErHX6MHvkzzgz20mntgkFzZKRzeo1+WsWnUzRNpDOwDfoZf/4d4FTl4pxSLAiEQHoSR
 nrgUrHoWB0+LoYlZT24ZSLDrUFiSw+NKPLBruKmLcnK3nc2yH58+9yW8kczdSd3LgJcE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh22-0006f0-Us for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 57C0761876;
 Wed, 22 Apr 2026 23:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF43C2BCAF;
 Wed, 22 Apr 2026 23:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900653;
 bh=kogJebrFlXeNEaaiyzZqWiRUiPJLTYLv2RGdABWdzqk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dz44fPydwfHrrFKNZqkeSajhjwE/hjf38HdjoW3MLLJ3jkMwJQMHPi/I/GgeIleDZ
 ZbKXj33JLqNBCMenx0xVS39NMMaoPrsSgKuul5ef/56vyme3XWcpK3BjIXjmN4NUbl
 hEcUscvWl8ThMFVtEHRkQhOYVK5bu2KTHh6JdcXuxaFgNOpayEI/1Sbku0AIXraDMk
 AmenpzG+YqCJSoAmbNV4ex9uuTBjebuLR1mefYRZVf29DPXWB2dhcWad+bTJPwhVdv
 KRODLulkkjSeiA/kf298Tn/wkiRZH0/OTy+b5quyzoY/soivurGhYabfPI1Ew6aTQS
 +zTT3naHw/Epg==
Date: Wed, 22 Apr 2026 19:30:09 -0400
MIME-Version: 1.0
Message-Id: <20260422-case-sensitivity-v9-15-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3878;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=juRp4blv9ojCU/MUyMkY2Fl5PBdoFDwowaxo1HD05lg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoG+JawwK9p290E0a7LBrlInfJFhlzdK770B
 Hv5TvUc9U6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBgAKCRAzarMzb2Z/
 l98ED/9KVHvUdvOxjuHj6eDXGDXOukMyQMBqYd/4nVgR9WICjcEx0OaPehufMGGvHqVhjo0PHyW
 1n4HwrECBDqNWHfSpno/7kTB9V44NzjHRWL8QMnkTtCVR7Bh9xAaviPQq+HFBIjFOrT1aO3yQ3C
 DT4pJPcfuBqwuq55DhC5mLlSsN3uFi1guka+zh2hR9xtPYkp9CNXDcWgCT2b7dF/XOuyAWXUIw+
 nrJMwUeIFlDg3F5HSoo+5GbMS0DZC0vCmFAYloBE1NikFeYcpFi4IkI/jy1gGzrETEgP5R4vuyE
 Io6PXt9UKUv5yPrwnOltKme9Rak0ZnvFIdfNy3jAQ1FKC+VZrBxW9xZ8lEocWpmAGWGtkDAgj5b
 H3SOsStX4iVb5cEJtSsg/OooEelOemSdxhbHkh6Dh4LOAyp8D223d7FxdYLITpAB3ZINiK7yyDh
 rnso15tIxahku3B1cVam9RUbrQSsbKCp3Q5gua7ifkkssx8K9uarn7utKh/I/7PadhGbwkDSiQU
 QFuNHgwbwm5QEBzOu1053LWfMX6kPqNlCKmrewWf/cpLr/l44X8mcYUimNtNd7/sf3DnVQSpEjc
 qvzFpQn4cNds1MslDXz9RRzRCCoMXGzjp7IGKmR73FrZ2ur15SMzTtcuWoWOVcCX5v9RjB601U/
 BUYdhIb430ZE3Uw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFh22-0006f0-Us
Subject: [f2fs-dev] [PATCH v9 15/17] nfsd: Report export case-folding via
 NFSv3 PATHCONF
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
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

The hard-coded MSDOS_SUPER_MAGIC check in nfsd3_proc_pathconf()
only recognizes FAT filesystems as case-insensitive. Modern
filesystems like F2FS, exFAT, and CIFS support case-insensitive
directories, but NFSv3 clients cannot discover this capability.

Query the export's actual case behavior through ->fileattr_get
instead. This allows NFSv3 clients to correctly handle case
sensitivity for any filesystem that implements the fileattr
interface. Filesystems without ->fileattr_get continue to report
the default POSIX behavior (case-sensitive, case-preserving).

This change depends on commit ("fat: Implement fileattr_get for
case sensitivity"), which ensures FAT filesystems report their
case behavior correctly via the fileattr interface.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 18 ++++++++++--------
 fs/nfsd/vfs.c      | 29 +++++++++++++++++++++++++++++
 fs/nfsd/vfs.h      |  3 +++
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..7b094c5908f1 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -717,17 +717,19 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 
 	if (resp->status == nfs_ok) {
 		struct super_block *sb = argp->fh.fh_dentry->d_sb;
+		bool case_insensitive, case_preserving;
 
-		/* Note that we don't care for remote fs's here */
-		switch (sb->s_magic) {
-		case EXT2_SUPER_MAGIC:
+		if (sb->s_magic == EXT2_SUPER_MAGIC) {
 			resp->p_link_max = EXT2_LINK_MAX;
 			resp->p_name_max = EXT2_NAME_LEN;
-			break;
-		case MSDOS_SUPER_MAGIC:
-			resp->p_case_insensitive = 1;
-			resp->p_case_preserving  = 0;
-			break;
+		}
+
+		resp->status = nfsd_get_case_info(argp->fh.fh_dentry,
+						  &case_insensitive,
+						  &case_preserving);
+		if (resp->status == nfs_ok) {
+			resp->p_case_insensitive = case_insensitive;
+			resp->p_case_preserving = case_preserving;
 		}
 	}
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eafdf7b7890f..6a7c6a691f2a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/fileattr.h>
 
 #include "xdr3.h"
 
@@ -2891,3 +2892,31 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+/**
+ * nfsd_get_case_info - get case sensitivity info for a dentry
+ * @dentry: dentry to query
+ * @case_insensitive: output, true if the filesystem is case-insensitive
+ * @case_preserving: output, true if the filesystem preserves case
+ *
+ * Filesystems without ->fileattr_get report POSIX defaults
+ * (case-sensitive, case-preserving). Outputs are unmodified on
+ * failure.
+ *
+ * Returns nfs_ok on success, or an nfserr on failure.
+ */
+__be32
+nfsd_get_case_info(struct dentry *dentry, bool *case_insensitive,
+		   bool *case_preserving)
+{
+	struct file_kattr fa = {};
+	int err;
+
+	err = vfs_fileattr_get(dentry, &fa);
+	if (err && err != -ENOIOCTLCMD)
+		return nfserrno(err);
+
+	*case_insensitive = fa.fsx_xflags & FS_XFLAG_CASEFOLD;
+	*case_preserving = !(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING);
+	return nfs_ok;
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 702a844f2106..abf33389ee81 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -156,6 +156,9 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 			     loff_t *, struct readdir_cd *, nfsd_filldir_t);
 __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *, int access);
+__be32		nfsd_get_case_info(struct dentry *dentry,
+				   bool *case_insensitive,
+				   bool *case_preserving);
 
 __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 				struct dentry *dentry, int acc);

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
