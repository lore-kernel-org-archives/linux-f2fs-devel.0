Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E40DCD3445
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 08:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6QakDEtvKhKL8ZSceh2bFCCWvxXhSehH28/DvHlbL88=; b=UeGtDeFDhQuq8PPtYoiirJALiN
	fAs141jZ+wsP2ZLmcdKqjpLixQZjLcGopBjtxYVr7iJuNY6Or5k1PmESUuYvdJiVBe2jJMZNotzcb
	fTTyrKAwcXBdibIG/9c3VtiE/rsuhwMr8bj4MAkfdBmSHcUetuG3IMaoCBIxAw7eTj2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKuVC-0005bo-Pw;
	Thu, 07 May 2026 08:54:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wKuVB-0005bh-3o
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 08:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=upQbDyPCapuLEzP3PoQWvgoflBXdyKCbEBVflnTTW2w=; b=iULA3/AkV02eOEG0vV4WW5ErGy
 rEcLx1iXfv9qp+eYjx4+8zglC29z251z0eqb72EJ2K1HFBZCMwcdeCAIYVeW9b1+raV0fvry25eEm
 czf1ayp3RLR+DQ/reBANl+dWVPqLHC64qsbBWxkR+Su6eVPzlZ3Jf/saaJEl+AVOaWk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=upQbDyPCapuLEzP3PoQWvgoflBXdyKCbEBVflnTTW2w=; b=JFMYCS1LOYTnVtWk0x2iOboT99
 Dvfl8+sWEF3nfNobvzpGRa1qziENjAv7hdnASDyzYtnC55Jqx0HaoYUEboHImyEfmgqema8LCmfa0
 JFVxxKJn7rwC/x8bmkIwqHbG/DvJ2zOTiNmb8ruW6IHuijbW1SWvWs4KIa1IpUgL67yg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKuV9-0002Bz-KE for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 08:54:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EEA260583;
 Thu,  7 May 2026 08:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05E4C2BCB2;
 Thu,  7 May 2026 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778144069;
 bh=Q5XtOKwPgaYRn0bnMc3D1rhUvCUILOZDILxVZdxu/kg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lUDtlQTXmlzxOQ/X0FohKbKIh1xULRrnTE/cngGXTlrkSIBP8aZ8meLOpNeAgzA3W
 H3/fHoPbllum6rqob/+R+ki/Dw7qUuXFvtJEWsIa2bddHy8IjQZ9PZwzfCQ5nFV6vt
 EUpczYOInPaO03V0ZJGObZurU5XA3+enNACY2skjX2ktBvbfOsW4LGSUGMRsUZM+9K
 PZrlsIvcUBA+KJOT/nYYIMibb8oNJs1oNX7qsyA8DI4T9yi1LVT4izOi4skOCEOg7L
 DOckiUsMHjd7JTAf/u3yYScqKQfQ0EhVrZJuhOCPHzO2KLlPsJsWO/AjAiaxB6rWj5
 sWZ3FSzw2VZfg==
Date: Thu, 07 May 2026 04:53:02 -0400
MIME-Version: 1.0
Message-Id: <20260507-case-sensitivity-v14-9-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6455;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AfMflhnl0Iaj4k4wi0ePcL6AtlSGx4FShDTRVk3BfzM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL2d8kJb1tOYvHXz+fH7V18IdYgTFiCNbaC8
 2KZ27PclnOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9gAKCRAzarMzb2Z/
 l6FkEACnPvUtZsjNyLaXe2wADKnIca3RrsMW5dR1xeapQh/SEO4frwIkxhl5nkun0GlnbmvpOVY
 W8vFlUw2DI+ElmjAGkzj9u3hOgD0V1t9bs1O8Qsfy2QJWK9910cmrL6MNuaWCw2L+W2kE3i7+CU
 K43Csiu5JEpbGuBXOXD9GMa6WIY2UmTp+5Llox6T1FnV8hIRs/8mSz5Dgv4TS5Eq6lZLPtgm1W6
 xcS+boGn9wtMqQDptBj56jasIdAbq3eYw9oeR2nmJ8zUxL5mX8KM2cRVLGT087xeAkOriYbDdTB
 R2cys4CYC2ieTbHAkNgqTnml4S4XKa4WYwxWbue55VoRf0pekIhCgyH8CBdaS1r8k2egI2g+yoH
 c9Mtu3BjUH2uH6ocotJ9VdeQQwilmwSFUdtosX8LZnRm8Oxv/jbzVGqtboRsHSqay+YvdITL+JT
 E0tIsV4dZJC8ujJ8pJ8dYLhoxIVREyfPf/ncF+mK1hNLRqjXfxfieK8yrdSnuHvXCulI+LIjhYc
 01L6WSyD9LwNU+YklJRlaq/XrHBk78Bbyr3l016mjEwYU6w8M+aqcpgtiCpVC6LZ1MUDmAmPs9y
 ewLStSyqsG3EIrxTMzK/r7z0mH8naL7pQ09RAz5eq53ke4X8j+GcMoO4erLSAszBy/Y3M9v+wzS
 4V6sCBtLvidKClA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wKuV9-0002Bz-KE
Subject: [f2fs-dev] [PATCH v14 09/15] cifs: Implement fileattr_get for case
 sensitivity
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
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 Steve French <stfrench@microsoft.com>, sprasad@microsoft.com,
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

Upper layers such as NFSD need a way to query whether a filesystem
handles filenames in a case-sensitive manner. Report CIFS/SMB case
handling behavior via FS_XFLAG_CASEFOLD and
FS_XFLAG_CASENONPRESERVING.

The authoritative source is the server itself: at mount time CIFS
issues QueryFSInfo(FS_ATTRIBUTE_INFORMATION) and caches the reply
on the tcon. That reply carries FILE_CASE_SENSITIVE_SEARCH and
FILE_CASE_PRESERVED_NAMES, which reflect whatever case handling
the share actually implements after SMB3.1.1 POSIX extensions
negotiation. Translating those two bits into the VFS flags lets
cifs_fileattr_get report what the server advertises rather than
what the client was asked to pretend.

QueryFSInfo is best-effort; the mount completes even if the server
does not answer. MaxPathNameComponentLength is zero in that case
and is used as the "no reply received" sentinel. When no reply is
available, fall back to the nocase mount option so that the reported
behavior agrees with the dentry comparison operations installed on
the superblock.

The callback is registered on cifs_dir_inode_ops so that NFSD,
ksmbd, and other consumers querying case handling against a
directory get a definitive answer, and on cifs_file_inode_ops to
preserve FS_COMPR_FL reporting on regular files. cifs_set_ops()
also installs cifs_namespace_inode_operations on DFS referral
directories that carry IS_AUTOMOUNT; register the same callback
there so the answer does not depend on whether the directory is
a referral point.

Registering fileattr_get routes FS_IOC_GETFLAGS through
vfs_fileattr_get() and short-circuits the syscall's fallback to
cifs_ioctl(). That fallback invoked CIFSGetExtAttr() under
CONFIG_CIFS_POSIX and CONFIG_CIFS_ALLOW_INSECURE_LEGACY on servers
advertising CIFS_UNIX_EXTATTR_CAP, surfacing the SMB1 Unix-extension
immutable, append, and nodump bits. cifs_fileattr_get carries over
only FS_COMPR_FL from cached cifsAttrs; the SMB1 extattr fetch is
not reproduced. SMB1 is deprecated, and acquiring a netfid from
within a dentry-only callback is not worth preserving a path tied
to an insecure legacy dialect.

Acked-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/client/cifsfs.c    | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/smb/client/cifsfs.h    |  3 +++
 fs/smb/client/namespace.c |  1 +
 3 files changed, 57 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2025739f070a..6c113ae7fdd3 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -30,6 +30,7 @@
 #include <linux/xattr.h>
 #include <linux/mm.h>
 #include <linux/key-type.h>
+#include <linux/fileattr.h>
 #include <uapi/linux/magic.h>
 #include <net/ipv6.h>
 #include "cifsfs.h"
@@ -1199,6 +1200,56 @@ struct file_system_type smb3_fs_type = {
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
 
+int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+	struct inode *inode = d_inode(dentry);
+	u32 attrs;
+
+	/* Preserve FS_COMPR_FL previously reported by cifs_ioctl(). */
+	if (CIFS_I(inode)->cifsAttrs & ATTR_COMPRESSED)
+		fa->flags |= FS_COMPR_FL;
+
+	/*
+	 * FS_CASEFOLD_FL is defined by UAPI as a folder attribute,
+	 * and userspace tools (e.g., lsattr) display it only on
+	 * directories. Confine the case-handling bits to directories
+	 * to match that convention; for non-directories the share's
+	 * case semantics are still discoverable through the parent.
+	 */
+	if (!S_ISDIR(inode->i_mode))
+		return 0;
+
+	/*
+	 * The server's FS_ATTRIBUTE_INFORMATION response, cached on
+	 * the tcon at mount, reflects the share's case-handling
+	 * semantics after any POSIX extensions negotiation. Prefer
+	 * it over the client-local nocase mount option, which only
+	 * governs dentry comparison on this superblock.
+	 *
+	 * QueryFSInfo is best-effort at mount; when it did not
+	 * populate fsAttrInfo, MaxPathNameComponentLength remains
+	 * zero. In that case fall back to nocase so the reporting
+	 * matches the comparison behavior installed on the sb.
+	 */
+	if (le32_to_cpu(tcon->fsAttrInfo.MaxPathNameComponentLength) == 0) {
+		if (tcon->nocase) {
+			fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+			fa->flags |= FS_CASEFOLD_FL;
+		}
+		return 0;
+	}
+	attrs = le32_to_cpu(tcon->fsAttrInfo.Attributes);
+	if (!(attrs & FILE_CASE_SENSITIVE_SEARCH)) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	if (!(attrs & FILE_CASE_PRESERVED_NAMES))
+		fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
+	return 0;
+}
+
 const struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
 	.atomic_open = cifs_atomic_open,
@@ -1217,6 +1268,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1227,6 +1279,7 @@ const struct inode_operations cifs_file_inode_ops = {
 	.fiemap = cifs_fiemap,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 7370b38da938..5f0d459d1a89 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -89,6 +89,9 @@ extern const struct inode_operations cifs_file_inode_ops;
 extern const struct inode_operations cifs_symlink_inode_ops;
 extern const struct inode_operations cifs_namespace_inode_operations;
 
+struct file_kattr;
+int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 
 /* Functions related to files and directories */
 extern const struct netfs_request_ops cifs_req_ops;
diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
index 52a520349cb7..52a51b032fae 100644
--- a/fs/smb/client/namespace.c
+++ b/fs/smb/client/namespace.c
@@ -294,4 +294,5 @@ struct vfsmount *cifs_d_automount(struct path *path)
 }
 
 const struct inode_operations cifs_namespace_inode_operations = {
+	.fileattr_get	= cifs_fileattr_get,
 };

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
