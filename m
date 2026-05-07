Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A64CD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TIwuif4fVhjb5JuIqNMgGYcBLCn3LizF4pnbov50uX0=; b=jJ+Vv9ssdA6hIN21YaZiPnVRUG
	K0yGbO7s9JpmH5S6x3gIS+bwayUyzywsEYmdkHzUMo3TTm662CZqM7HeDcL2lPfbBv3cpczByIGqC
	aXJYZkWcfZmg9DnGsTSqyEE9Y74cbDVlKZ0+YsbcOy0BHDoWg+4GWmsSFRNqZvAo+oQY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKuVV-0005db-E1;
	Thu, 07 May 2026 08:54:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wKuVU-0005dR-C6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 08:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NtuCkfQGGhqlt1epSApxJBO1doG5D1/s4LUnN0ZS5BE=; b=CZXL7AtqHFAj+t7EF1VKuCCWbR
 CLaMBpzIL+EjqQC+p+wzrS/ZvlQrJw1nCars0riwA6VcOw3J+6jCZeHvD+SGgL1KrZssAvEjEScf0
 OneaeGgFB+MpzV/5e+HBeJpQCENKgCp8chwZQ8R4lpqtTWbdJmoWUlrt/pZ6EFY4KvwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NtuCkfQGGhqlt1epSApxJBO1doG5D1/s4LUnN0ZS5BE=; b=NZe8WJXbYThM7LqJEmxpqIHgbd
 vAiSZ+eCUoph464/+xCxrbkSAqRy7Dy7hlEeA5meicalRU40SRW1NwOcZSLP+0KAFY5MHm45k5Lgw
 Ns3TKKfQRhM8+dMKl1JpxPNZqALllDwOAFftcsxE5rzrSJrICJXBUuifUU/ehvw15vy0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKuVS-0002Dm-Uu for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 08:54:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A1B0B440A8;
 Thu,  7 May 2026 08:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC06FC2BCC7;
 Thu,  7 May 2026 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778144084;
 bh=4PnVhA68/lwOR6kFOGBj/fhhmjpnw+nIMjeX3NeO8qI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WYXgodirbxefKqpestHuwlbBBe4448HkdLpBifR67nhRVEs/4/uK61+ODs6IWs58y
 vyHJOWjjw7Qr3U/TFyLFezQ23L3J4IozAZOALAR5cnjB8+mr4wJPfOLfod+OgR1BgQ
 Luz7nFXnAl2jKcx4DJ9vAj0cE/AK//WDcTzgyd1Hv0VBz1tztIO3+0OhJJH1wwmdjp
 6F6bmvDgVl9CgKZH8UAzd5QByy3cdbNzykPeKwcXE4qEZHB9EfMwILk4bCCFLqb+3z
 0gKcY4RRYEWxPzaWWZBtoZtsQVU4BI3hktF+YcDdoV9WLjuflSwRfI/pVMCzO9F+dS
 rn0vRlGf4TP4w==
Date: Thu, 07 May 2026 04:53:04 -0400
MIME-Version: 1.0
Message-Id: <20260507-case-sensitivity-v14-11-e62cc8200435@oracle.com>
References: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
In-Reply-To: <20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4902;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=IS91PG/gteNIi+mr5kWAFzEwamMgenFgJebFqDZEBwA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp/FL2ab7PO0GKPWwLDOzrkqopm7i/dKDsU6qf6
 l4ignMA/oSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafxS9gAKCRAzarMzb2Z/
 lzxBD/408mwuDJDVUZBkZAMASOWvU6NXrL/2A8iHqz00lAjlRautSzuCD+j/x9+z0m2sJ8km1rv
 e9VYln02Ou8YWZD/w3JkF1Qg9iskWdIQa5VTn29Ym1864I5xJaIibUxdkp/seGDxdt3YwVHs2xM
 vOaygocFKjpBrQ5lW8oFnj3oWZPOQDgej3bBuCOqtO4DOdKBtKzkU8lQSd/sMxqo4GiD2kKn+EX
 5TEwVdcH0JbPkdN3zwmzT1lfY0ytxNBw+GbcDphaXfBVZ7YAKQRTKY5OXe4HPq8eNVzhIGz4+WM
 QnNtj8hTyCryxoN9LOgiZU9tRtafKchk/CzwOn46bY8mI29lxqPxzyh7ovrjdECOp5eGLtgwCKo
 Bu7oU8Vo8WYUVz6wul/gcKm0p1ZAs7JzilmkfvXCc2bGpKr2Zai3CJKXlk4Zg1EQxoc7gbgn561
 MHu/VeAahMaRllCmsjnXi5PMaPkOW5J8+pIoxnlhL/Py9zDLRxvio5B/8tryY0dhT2sCYm2gy7H
 zNaK/sjUN7+/QO+Ku6DSfbludMvasx9yWcMDluTqVbYXBXaaUo2uqWkPK54UVV1QneznNEMbTSL
 pgVP/kkrxLcuLq9lboGb+HMYaa1uzmNoRENt/DHTnvrQUff8n4c2EkYzHIFLLYi6nSCtUGG49zc
 BcbNCXCS2MJA+NQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wKuVS-0002Dm-Uu
Subject: [f2fs-dev] [PATCH v14 11/15] vboxsf: Implement fileattr_get for
 case sensitivity
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

Upper layers such as NFSD need a way to query whether a
filesystem handles filenames in a case-sensitive manner. Report
VirtualBox shared folder case handling behavior via the
FS_XFLAG_CASEFOLD flag.

The case sensitivity property is queried from the VirtualBox host
service at mount time and cached in struct vboxsf_sbi. The host
determines case sensitivity based on the underlying host filesystem
(for example, Windows NTFS is case-insensitive while Linux ext4 is
case-sensitive).

VirtualBox shared folders always preserve filename case exactly
as provided by the guest. The host interface does not expose a
separate case-preserving property; leaving
FS_XFLAG_CASENONPRESERVING unset reports the POSIX-default
case-preserving behavior, which matches vboxsf semantics.

The callback is registered in all three inode_operations
structures (directory, file, and symlink) to ensure consistent
reporting across all inode types.

Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/vboxsf/dir.c    |  1 +
 fs/vboxsf/file.c   |  6 ++++--
 fs/vboxsf/super.c  |  7 +++++++
 fs/vboxsf/utils.c  | 30 ++++++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h |  6 ++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af..c5bd3271aa96 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -477,4 +477,5 @@ const struct inode_operations vboxsf_dir_iops = {
 	.symlink = vboxsf_dir_symlink,
 	.getattr = vboxsf_getattr,
 	.setattr = vboxsf_setattr,
+	.fileattr_get = vboxsf_fileattr_get,
 };
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 7a7a3fbb2651..943953867e18 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -222,7 +222,8 @@ const struct file_operations vboxsf_reg_fops = {
 
 const struct inode_operations vboxsf_reg_iops = {
 	.getattr = vboxsf_getattr,
-	.setattr = vboxsf_setattr
+	.setattr = vboxsf_setattr,
+	.fileattr_get = vboxsf_fileattr_get,
 };
 
 static int vboxsf_read_folio(struct file *file, struct folio *folio)
@@ -389,5 +390,6 @@ static const char *vboxsf_get_link(struct dentry *dentry, struct inode *inode,
 }
 
 const struct inode_operations vboxsf_lnk_iops = {
-	.get_link = vboxsf_get_link
+	.get_link = vboxsf_get_link,
+	.fileattr_get = vboxsf_fileattr_get,
 };
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index a618cb093e00..a61fbab51d37 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -185,6 +185,13 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto fail_unmap;
 
+	/*
+	 * A failed query leaves sbi->case_insensitive false, so the
+	 * mount defaults to reporting case-sensitive behavior. Do not
+	 * fail the mount over an advisory attribute.
+	 */
+	vboxsf_query_case_sensitive(sbi);
+
 	sb->s_magic = VBOXSF_SUPER_MAGIC;
 	sb->s_blocksize = 1024;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 440e8c50629d..298bfc93255c 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -11,6 +11,7 @@
 #include <linux/sizes.h>
 #include <linux/pagemap.h>
 #include <linux/vfs.h>
+#include <linux/fileattr.h>
 #include "vfsmod.h"
 
 struct inode *vboxsf_new_inode(struct super_block *sb)
@@ -567,3 +568,32 @@ int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *sf_d,
 
 	return err;
 }
+
+int vboxsf_query_case_sensitive(struct vboxsf_sbi *sbi)
+{
+	struct shfl_volinfo volinfo = {};
+	u32 buf_len;
+	int err;
+
+	buf_len = sizeof(volinfo);
+	err = vboxsf_fsinfo(sbi->root, 0, SHFL_INFO_GET | SHFL_INFO_VOLUME,
+			    &buf_len, &volinfo);
+	if (err)
+		return err;
+	if (buf_len < sizeof(volinfo))
+		return 0;
+
+	sbi->case_insensitive = !volinfo.properties.case_sensitive;
+	return 0;
+}
+
+int vboxsf_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct vboxsf_sbi *sbi = VBOXSF_SBI(dentry->d_sb);
+
+	if (sbi->case_insensitive) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	return 0;
+}
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 05973eb89d52..b61afd0ce842 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -47,6 +47,7 @@ struct vboxsf_sbi {
 	u32 next_generation;
 	u32 root;
 	int bdi_id;
+	bool case_insensitive;
 };
 
 /* per-inode information */
@@ -111,6 +112,11 @@ void vboxsf_dir_info_free(struct vboxsf_dir_info *p);
 int vboxsf_dir_read_all(struct vboxsf_sbi *sbi, struct vboxsf_dir_info *sf_d,
 			u64 handle);
 
+int vboxsf_query_case_sensitive(struct vboxsf_sbi *sbi);
+
+struct file_kattr;
+int vboxsf_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 /* from vboxsf_wrappers.c */
 int vboxsf_connect(void);
 void vboxsf_disconnect(void);

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
