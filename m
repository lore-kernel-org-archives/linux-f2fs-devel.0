Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E7BD2ED0F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=27JwMUCbfLSIIXSjuFQs06t+QO8yt5e48H6stZuNCjQ=; b=kylHSkaHTxAJ+vRBnwhLGJeIfq
	2NFuQ4z61teujbANkXzCpk83jes6L9ojFhLZZ929mSWxHm5PcaoDSamKcdID5GhTIX8g6ODmf2H04
	XClGVL9EdavKkk1dfzErjGXflLkkkdCWY2hQ8+C5SJoZG9lG4wDSMkzyW5U5LDK/DFBY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viCfc-0000FC-Lt;
	Tue, 20 Jan 2026 14:25:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1viCfb-0000F2-M4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 14:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oE80BR4403DnLt9e/wNDDPLvFT7BQ11D39uuNm+mrqA=; b=YUjoiJFPWpu+lSBtUSdIGVHxQp
 BbBxzWP4LrWYT4Zzu9eFfltAp4wlJKqo/XXnLY4tB4qqnz60ZXLAAyaswPZPGS5WdAz5ite2BtWDY
 gm1pWurQimwOXKTT14lfaERhWtP4iLpmWW0jz8bXzCQrG7adx9oOjSL5Z9thljh3qvTE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oE80BR4403DnLt9e/wNDDPLvFT7BQ11D39uuNm+mrqA=; b=Q9J5hhSlhse25u2gq25ybvqJ4F
 4y0+WGqiF3vv46oEaxpYR7femZYi9EuoHsqd2VWW5HGwaw6lgecWVs87hEaUyKL+2bNFotnEAo+SZ
 aLvpcyPGfdy54BEz8BmCfn109nlHe3zI4qBRlbSPCkckxE2ZwflQoPYBmnpinIsVI9j4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viCfb-00086v-14 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 14:25:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 717626011F;
 Tue, 20 Jan 2026 14:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87E8C16AAE;
 Tue, 20 Jan 2026 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768919117;
 bh=QGf1BV7NtAHTRnEj7iUjWHiVLjWFPtu0yuapA0D8lsU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZVXh/e5gxRQst+fuFgsxu8vqZLt6AAzLacgHzqPXWK+0hZXbRRRVqY7V6BXx9TTLi
 4WsH06hjS7O3mv/kH1kHLsOpPBHNqMXOwr6NgppJjeGqKQr/JBqLFkQUGy3RTv0AoH
 X0IOtBtmKH0e0Hk/YmNlR3I8rvCxrYvotrRRulRLv5BYnG/MEPNpUd5FIKwGsf4quH
 q4DXQfOcMqVl1hEnOaRQHBmT42F9CNVrie8+BX5cB3E3RRByN4ldh6Z3o0iUijUXOT
 fJZJHHXdubMpeys7xYmdGFYLAWdcATKZ55JZmwHmeOd7JUJuCBWAdsFGLF2z3dS8JE
 aDPKsV7oyuixQ==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Tue, 20 Jan 2026 09:24:37 -0500
Message-ID: <20260120142439.1821554-15-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120142439.1821554-1-cel@kernel.org>
References: <20260120142439.1821554-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1viCfb-00086v-14
Subject: [f2fs-dev] [PATCH v6 14/16] nfsd: Report export case-folding via
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
 tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
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

This change assumes the ("fat: Implement fileattr_get for case
sensitivity") has been applied, which ensures FAT filesystems
report their case behavior correctly via the fileattr interface.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 18 ++++++++++--------
 fs/nfsd/vfs.c      | 25 +++++++++++++++++++++++++
 fs/nfsd/vfs.h      |  2 ++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..9be0aca01de0 100644
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
+		resp->status = nfsd_get_case_info(&argp->fh,
+						  &case_insensitive,
+						  &case_preserving);
+		if (resp->status == nfs_ok) {
+			resp->p_case_insensitive = case_insensitive;
+			resp->p_case_preserving = case_preserving;
 		}
 	}
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 168d3ccc8155..55cf0c0165c9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/fileattr.h>
 
 #include "xdr3.h"
 
@@ -2871,3 +2872,27 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+/**
+ * nfsd_get_case_info - get case sensitivity info for a file handle
+ * @fhp: file handle that has already been verified
+ * @case_insensitive: output, true if the filesystem is case-insensitive
+ * @case_preserving: output, true if the filesystem preserves case
+ *
+ * Returns nfs_ok on success, or an nfserr on failure.
+ */
+__be32
+nfsd_get_case_info(struct svc_fh *fhp, bool *case_insensitive,
+		   bool *case_preserving)
+{
+	struct file_kattr fa = {};
+	int err;
+
+	err = vfs_fileattr_get(fhp->fh_dentry, &fa);
+	if (err && err != -ENOIOCTLCMD)
+		return nfserrno(err);
+
+	*case_insensitive = fa.fsx_xflags & FS_XFLAG_CASEFOLD;
+	*case_preserving = !(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING);
+	return nfs_ok;
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index e192dca4a679..1ff62eecec09 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -155,6 +155,8 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 			     loff_t *, struct readdir_cd *, nfsd_filldir_t);
 __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *, int access);
+__be32		nfsd_get_case_info(struct svc_fh *fhp, bool *case_insensitive,
+				   bool *case_preserving);
 
 __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 				struct dentry *dentry, int acc);
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
