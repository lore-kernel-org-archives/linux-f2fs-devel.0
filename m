Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4F8F589CD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/zwVA85kYeL2BbzESwRBo8p6eObKP0+j/env0/MF3J8=; b=UjR4079hSEJDIxGYRLLRtpUG9O
	y4RMjKoQMOe73x37Vpe+pLqvLqaT9wXVx3qvICj706QhRgBQbVnhHntb6zGrHvGfXKVDD7FnRuQpK
	dC2shfQgXf/pHrU0+Q67eV3b+rW+0ucbumTAVVFs7aGfQmFz9jZ0QUskXoJ841hNBgdA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFtra-0003fr-U0;
	Thu, 23 Apr 2026 13:13:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFtrX-0003fe-T3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UGi3yWrLaG8S9qBfXN5ybF3vdReeDfgoHSxb/0Qom0U=; b=HEKdYFX3Rt7o9upEJVcx31EPUs
 Q3xlqnyeKctB0ZoQBbdjQQn5e3hyDhDoJxfFdT9uq18D3O+P4txFOPqeb5JIcwidjS4HjuUy5Gguv
 ODK6jb961seaN0LcUXPYSTKIb1wCGJEhgm/A5pODG1hDapJSwwhWHaRVICho1iOKIruU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UGi3yWrLaG8S9qBfXN5ybF3vdReeDfgoHSxb/0Qom0U=; b=GR+RanpfYbq1kVUzrs51EQXQnp
 AnVK9lnZfH//7zbYB6MrMZ9pQmO0k36WO3jk89dKOgD0njo2eAe2J8hJ6oL8+RPBaXfcWQX3WJY3F
 OCbiYgyznop8nO260XjucHDKAy085gju4bkhQa0r0EtstsDxmLX/5iJZBPI5N7WjED5M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFtrR-0006p1-35 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D2936013B;
 Thu, 23 Apr 2026 13:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7ACC2BCB3;
 Thu, 23 Apr 2026 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776949967;
 bh=7+KkoL3tT74ISbeLjawhJGX0pW4ZmQxGjH85QN72LoE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mXLpsyswAnbg9YRnbdDz5iilJiJtO5A5NQKk4LLzYeYItugpZscHoMirsrTqdZklw
 uRtkt78P0tF2usiCD+AzS4DxtaFn09xWma60+OGMZDGC2z4KLuqlsVgVocBnT7pLN3
 fc64IaGd2c1zVnDMRXRPz8Yy3toUI4J6tXtIgz6oc9OeYAFmoWvWPJRtVRyijJdoZV
 q0sD8aHG6YvDLotHaXuFyr0SPfx/7edOwTyfUiI21xIqb/RDDQlbcOb7OFnCwpf2qi
 Er0QIXU00YmycTsOCInxKPdy5CSClVcIkivfVV+dtzWSu+NEuNvT8HtwfZ4/hcePzt
 fHCr2rk40/L+g==
Date: Thu, 23 Apr 2026 09:12:13 -0400
MIME-Version: 1.0
Message-Id: <20260423-case-sensitivity-v10-10-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2890;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=x1bL8ZBB5Twab/6NumFLSBXEoTJcokaVZadIWFYQ2n4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq0DXYznTMLZfGDAShXh1kvv0fNjsbzn9DLA
 4AHx4CpQRGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l54FD/9J8IzDKD52G1HUWHY/FdLPMd/d+7cKv1E+H3pyAxYHbbvkBHQTOo20aZ4/jcIsKgebJk7
 9O4KuEmRZdd1a7qxwEMwfae4Vdu5dwkZMKH340nVkskS4IV+ebV6VfpbRH5M8jmqXwmbE8x5x11
 CeQryqSIHtAB2vKyul0bDADKJVUABgdwcsVL3adw2OsR4isefIEmaok0e9pyKI0aQWmCK23daJp
 1uGzMw11Z/kKLNhyexCnbFwzKnhvBEO4u+DruN3WfawsoZ3sR8D2/eekZIYTfaZMj8kr8BhTQ4z
 TgXOgXQOP8u4vmsPSG7qmVyABySAHuLYy/vMWGMnnBK/Bz6h8sZBZuIirGTrIVmC7Kw/9D0tiI/
 WZ3BmTYhsj2D9HGff+17Rpt4TCWRmiBI+IEccebG8+/fWJRTwjdAxr1dGbDmjZNEFoGakPKfrPy
 KVjK5LhJ/s7r6wnHVgcI7bnJ3vVjNA8YByiewwHEm33OVRyAFYCOym7imTZT4hAOx6S2IEmDl7P
 920UVfYLeUU/KnNTPuXXv5W2237g8G90GpKuslHpUxCP+pMK1jD2qS3vGpGIky/BdpfnFZ697UP
 baZKfK7peDX96Z44E065p6B1U7ijJ7txWBmXNElNsgKhs+7vUaiN1cjvdKIj6SA1ySOYcURyUdQ
 IKLvYStt3oWHO8A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFtrR-0006p1-35
Subject: [f2fs-dev] [PATCH v10 10/17] cifs: Implement fileattr_get for case
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
handling behavior via the FS_XFLAG_CASEFOLD flag.

CIFS servers (typically Windows or Samba) are usually case-insensitive
but case-preserving, meaning they ignore case during lookups but store
filenames exactly as provided.

The implementation reports case sensitivity based on the nocase mount
option, which reflects whether the client expects the server to perform
case-insensitive comparisons. When nocase is set, the mount is reported
as case-insensitive.

The callback is registered in all three inode_operations structures
(directory, file, and symlink) to ensure consistent reporting across
all inode types.

Acked-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/client/cifsfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2025739f070a..9b70ffa3e01d 100644
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
@@ -1199,6 +1200,22 @@ struct file_system_type smb3_fs_type = {
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
 
+static int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+
+	/*
+	 * The nocase mount option installs case-insensitive dentry
+	 * operations on this superblock. SMB preserves case on the
+	 * wire and at rest, so the mount matches FS_XFLAG_CASEFOLD
+	 * semantics: case-folded lookup, verbatim storage.
+	 */
+	if (tcon->nocase)
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	return 0;
+}
+
 const struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
 	.atomic_open = cifs_atomic_open,
@@ -1217,6 +1234,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1227,6 +1245,7 @@ const struct inode_operations cifs_file_inode_ops = {
 	.fiemap = cifs_fiemap,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
@@ -1261,6 +1280,7 @@ const struct inode_operations cifs_symlink_inode_ops = {
 	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 /*

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
