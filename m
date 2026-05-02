Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A92CD3423
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 May 2026 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L1qd9FSZtk9MYJV2oZY0SUVwNkQeQuebHVzHY6hkPkw=; b=HVrKj99/fZKYIH3B0OtxYmR8nX
	si/q9Xyc0VyI0WkI1x6DtJ1qHFEgT0L5C4t56+bXfYCV/SxySmw5eV3Gw28jGNnQXHqnKLMD8StWZ
	lWwsfKzbogkrdTqcsDQcyywxAVHdb7INUWN7CL9kLFLWfoEtvQdeBQAUvXZSOKw4W/+0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJBEx-0002FI-2k;
	Sat, 02 May 2026 14:22:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wJBEv-0002F0-5O
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bkon7F/rzxoOAZBNFBA1eM71zLTqUZ+EOsZvweT+aoU=; b=ZjdG7mzs3dLKlbiCK71SxL9KWc
 2At+Y61W8Y73qt488tH4ScP78xrFyhAv1d2FddwDNRt3ngnpg0kZUzMUR27FxugxhK/Xjb23ZH9At
 da7MdmYshy62692gRuDZ6oh31iliiQrJNNbJCYkVAohOjsgn+F72f7DDpvpeKuWTT6JI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bkon7F/rzxoOAZBNFBA1eM71zLTqUZ+EOsZvweT+aoU=; b=AO/uwFt0zY34MdqD32kTyxJJzb
 L5ZpgcH8ca5N+N7Wm8TzilWb+sBTwYKktVSF0XIlIz16HqSAqntoMzRf8hYUXu96uQMZKFDNeG6jv
 dVMEEX+ipR9hLGuwSQGx/6o+qEWNdgszJfEg12WU727qu9etkNJPXO/u3DpQ62saiBoM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJBEu-0000wd-Rc for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EFF441943;
 Sat,  2 May 2026 14:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E2C2BCC7;
 Sat,  2 May 2026 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777731750;
 bh=sdRAbA0hLtQN2RnAbozuOhOqbFqQox7bou91/njDoms=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FNZllbqzVoBbR0NGwnoBBjRU7xSequIG890TkXVb1EEiRLncFALEZe7JrhiR3J8e/
 cF1wqx1GS/EqMtVt3utsN9hY6yEE8XbSgJ6sQBgyx7Uw4OuL5jhTY1G7M/du+02oSe
 OCWHkHLG+erjA4/ggppUs6auQIvRTknjYqzFCZOxhXqMGCi/yi39DVM+u9grnXiOF+
 U/sRlcZX9iNagm9qlUL7amDa8glHU99q6SPpfTMMPCTfYGanAZkwlw7ia7BOzpvn5z
 nqdKBMXcXDFuOVVB1gmWmLOrJOcfdBq4zv0ltqACLoA8xozbu2NmPUCkGttcEybf0v
 9CKsfOQHGkt5w==
Date: Sat, 02 May 2026 10:20:58 -0400
MIME-Version: 1.0
Message-Id: <20260502-case-sensitivity-v13-13-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8016;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=gPgHxk6J/l08HbE/ArroIs8LMtbWr6iWpYFW4djvm3Q=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghRQxUjJJQkvR+X7w7b6YrZQNg3OE28iDeC6
 mUj9RPXpwmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUQAKCRAzarMzb2Z/
 lxOxEACBWOesoo4+9RI1Cg2aP3tI9x6cOs/Zj6Ez6E85J1/5y+dXj9NnJJKO4/0VgsSSqogI6CZ
 nR35sTkyP/JvKojGnCj4qN9i1T+wSd/IYzdXH0SwgcjNhrmSys5LajScny0DTkLr8gIc91WQE+0
 GOE9ToI1jKW4GpM2PfZISNNATU79nepS/CgRUYaUZWBHfgYSJfg2cS/0xEFZhlY9BusmyrKzN2x
 MVmh4MLWkrD1Sq8V7hdfpwsjAholAjf7Dykk6ojNDbBhv2rsLRAOx/MSek+/mXzp38qR+Oc5nJ3
 12Lm0YpYoCSCB48YPf5m8Ud4grsAEliKfhTKD5QUWOMO4OrTVPMLsKtXh1OBpd7XMbIfq2ni+1G
 vr6PWmie4yozJejru+TXS4+m21iIwI1e0asi3eA1JmGcoKnCSSaZQBSi4Wc7D8/q+WJszKb/jaX
 clZZblUEukmqNZfev1Bx+KhwFzmfZDnJUw7Oxom+i+fOqm9BRuUqfFfExvaqid1GO7eMz4yu7wn
 ejRVSRhhB1/5dcw6yqscukyMdOrw0oDwG0emMcmYRWRwiCf5C2eB0s/8GE+23d0bjZVQCfBkeQI
 P7hxi+Ble1sDnSesQT8/iyvk0hw0rTkFuq6n7lKa/2/dWgGKccUiel5sR2wJae4CQKSdVTkwgL9
 vXZg0c5a5WyhnNA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wJBEu-0000wd-Rc
Subject: [f2fs-dev] [PATCH v13 13/15] nfsd: Report export case-folding via
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
 Roland Mainz <roland.mainz@nrubsig.org>,
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

This change depends on the earlier "fat: Implement fileattr_get
for case sensitivity" patch in this series, which ensures FAT
filesystems report their case behavior correctly via the
fileattr interface.

Case-folding is a per-directory property, so
nfsd_get_case_info() queries the parent dentry for
non-directory filehandles. Three inherent corner cases follow:
a single-file export's parent lies outside the exported
subtree, so the LSM hook evaluates against an unexported
directory; a disconnected dentry from fh_verify() has
d_parent == itself, so the file's own attributes are reported
until the dentry connects; and a hardlinked file resolves
through the alias the dcache currently holds, so when the
inode is linked into both case-folded and case-sensitive
directories the reported value tracks whichever parent is
active. These limitations are not addressable without
redefining the protocol attribute as per-parent rather than
per-object.

RFC 1813 restricts PATHCONF errors to NFS3ERR_STALE,
NFS3ERR_BADHANDLE, and NFS3ERR_SERVERFAULT. When an LSM hook
denies the case-folding query on the parent, NFS3ERR_STALE is
the only correct mapping: NFS3ERR_SERVERFAULT misrepresents a
working server as broken, and NFS3ERR_BADHANDLE implies a
decoding failure that did not occur. A client purging the
filehandle on receipt is the desired outcome, since the server
has refused to read attributes through it. Substituting POSIX
defaults instead would let the same handle report
casefold=false now and casefold=true once policy permits,
opening a silent name-collision window on case-insensitive
exports.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 36 +++++++++++++++++++++------
 fs/nfsd/vfs.c      | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h      |  3 +++
 fs/nfsd/xdr3.h     |  4 +--
 4 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 42adc5461db0..62ebc65b8af2 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -710,23 +710,43 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	resp->p_name_max = 255;		/* at least */
 	resp->p_no_trunc = 0;
 	resp->p_chown_restricted = 1;
-	resp->p_case_insensitive = 0;
-	resp->p_case_preserving = 1;
+	resp->p_case_insensitive = false;
+	resp->p_case_preserving = true;
 
 	resp->status = fh_verify(rqstp, &argp->fh, 0, NFSD_MAY_NOP);
 
 	if (resp->status == nfs_ok) {
 		struct super_block *sb = argp->fh.fh_dentry->d_sb;
+		int err;
 
-		/* Note that we don't care for remote fs's here */
-		switch (sb->s_magic) {
-		case EXT2_SUPER_MAGIC:
+		if (sb->s_magic == EXT2_SUPER_MAGIC) {
 			resp->p_link_max = EXT2_LINK_MAX;
 			resp->p_name_max = EXT2_NAME_LEN;
+		}
+
+		err = nfsd_get_case_info(argp->fh.fh_dentry,
+					 &resp->p_case_insensitive,
+					 &resp->p_case_preserving);
+		/*  
+		 * RFC 1813 lists NFS3ERR_STALE, NFS3ERR_BADHANDLE, and
+		 * NFS3ERR_SERVERFAULT as the only PATHCONF errors.
+		 */
+		switch (err) {
+		case 0:
+		case -EOPNOTSUPP:
+			/* Both arms leave the output booleans valid. */
 			break;
-		case MSDOS_SUPER_MAGIC:
-			resp->p_case_insensitive = 1;
-			resp->p_case_preserving  = 0;
+		case -EACCES:
+		case -EPERM:
+			/*
+			 * Policy denied the query. Report STALE so the
+			 * handle is unusable without implying a server
+			 * malfunction.
+			 */
+			resp->status = nfserr_stale;
+			break;
+		default:
+			resp->status = nfserr_serverfault;
 			break;
 		}
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eafdf7b7890f..4bd63d8efbf7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/fileattr.h>
 
 #include "xdr3.h"
 
@@ -2891,3 +2892,74 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+/**
+ * nfsd_get_case_info - get case sensitivity info for a dentry
+ * @dentry: dentry to query
+ * @case_insensitive: set to true if the filesystem is case-insensitive
+ * @case_preserving: set to true if the filesystem preserves case
+ *
+ * On casefold-capable filesystems the flag lives on the directory,
+ * not on its entries, so for a non-directory @dentry the parent is
+ * queried instead. A directory (including an export root, whose
+ * parent lies outside the export) is queried as-is so its own
+ * contents' lookup behavior is reported.
+ *
+ * When the filesystem does not expose case-folding state (no
+ * ->fileattr_get, or the callback returns -EOPNOTSUPP /
+ * -ENOIOCTLCMD / -ENOTTY / -EINVAL), the outputs are filled with
+ * POSIX defaults (case-sensitive, case-preserving) on the premise
+ * that a filesystem with case-folding support wires up
+ * fileattr_get.
+ *
+ * Other errors propagate unmodified (-EACCES, -EPERM from LSM
+ * hooks; -EIO, -ESTALE, ... from the filesystem). Case-folding
+ * behavior is a property of the exported filesystem, not of the
+ * caller's credentials, so silently substituting defaults would
+ * let the same dentry report POSIX while LSM denies and report
+ * casefolding once LSM allows -- a client could race against
+ * silent name collisions on a case-insensitive export.
+ *
+ * Return: 0 with outputs filled, -EOPNOTSUPP with outputs filled
+ *         to POSIX defaults, or a negative errno with outputs
+ *         unmodified.
+ */
+int
+nfsd_get_case_info(struct dentry *dentry, bool *case_insensitive,
+		   bool *case_preserving)
+{
+	struct file_kattr fa = {};
+	struct dentry *cd;
+	bool put = false;
+	int err;
+
+	if (d_is_dir(dentry)) {
+		cd = dentry;
+	} else {
+		cd = dget_parent(dentry);
+		put = true;
+	}
+	err = vfs_fileattr_get(cd, &fa);
+	if (put)
+		dput(cd);
+	switch (err) {
+	case 0:
+		*case_insensitive = fa.fsx_xflags & FS_XFLAG_CASEFOLD;
+		*case_preserving =
+			!(fa.fsx_xflags & FS_XFLAG_CASENONPRESERVING);
+		return 0;
+	case -EINVAL:
+	case -ENOTTY:
+	case -ENOIOCTLCMD:
+	case -EOPNOTSUPP:
+		/*
+		 * Filesystem does not expose case state.
+		 * Report POSIX defaults.
+		 */
+		*case_insensitive = false;
+		*case_preserving = true;
+		return -EOPNOTSUPP;
+	default:
+		return err;
+	}
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 702a844f2106..e09ea04a51b9 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -156,6 +156,9 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 			     loff_t *, struct readdir_cd *, nfsd_filldir_t);
 __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *, int access);
+int		nfsd_get_case_info(struct dentry *dentry,
+				   bool *case_insensitive,
+				   bool *case_preserving);
 
 __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 				struct dentry *dentry, int acc);
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 522067b7fd75..a7c9714b0b0e 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -209,8 +209,8 @@ struct nfsd3_pathconfres {
 	__u32			p_name_max;
 	__u32			p_no_trunc;
 	__u32			p_chown_restricted;
-	__u32			p_case_insensitive;
-	__u32			p_case_preserving;
+	bool			p_case_insensitive;
+	bool			p_case_preserving;
 };
 
 struct nfsd3_commitres {

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
