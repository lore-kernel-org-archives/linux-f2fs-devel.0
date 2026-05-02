Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBB0CD3423
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 May 2026 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NjlE4w3DwsezgkB9GEEZMg4HboiCQ7n7JwUO+6ksqZU=; b=ZY0b1e2NuP2OQY6JM3kT4BERjo
	08cFx4NJgvNUdZUMXBJwAF2MYD3JDVqk3xGmiLNnQNAr7OzPZmkuorc2Awcxx6ZbTAcjsloOff1Wu
	mEvFvWuzmE14+1W4YHS3BRwkV9UvHZc4PeaPMyA+9vWxisUmn9sP9i7xO0j5cChNmNc4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJBEs-0002lF-4K;
	Sat, 02 May 2026 14:22:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wJBEq-0002l7-CQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=okYb1rCy7YLX9Nhkr3j1SUVMKLgwaWS0nQ+ZigFK7g8=; b=Ip099ksFtmVEm/IKpWE8X0Qxhh
 qKvkP/XLXOV6AaxxL6Nfe0o7v1Cq24iONfK/c7oPG+wLL9JPamEOl3fkkkHvlA+oWBBLlBXlzOEw8
 mYPPMXL6Tf1SD39T6AHbN0hutv7vlkwBaapXJMUHyJuewSa/rv/U4zLx/upAFSGWC6ew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=okYb1rCy7YLX9Nhkr3j1SUVMKLgwaWS0nQ+ZigFK7g8=; b=XMp0FNpqv2jGa/rer3IiSI4IvR
 KudtdcJfHiHZdW2quqezQGYuLyAPKzw/EWqO/RwbAcsJvkqj6uw8R2ZEBIyQnM5xJjEhN37IqMvjc
 LQ3Wx2TluxFM0/woEX68iMqgpEWxMw5mto2iZkAsagVD8NQDk3tkytr9MQ5KqY8loSjo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJBEo-0000w9-Sd for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 96BDD40F59;
 Sat,  2 May 2026 14:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE902C19425;
 Sat,  2 May 2026 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777731744;
 bh=pwh6ZK7+DyUSteq+vdVu0HYuHs8P3NPOtCprGITxaEM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=V7gGtwXWvdc054nee6dm5o/oXbrStaF3jLaTBarlmfXlJ0D0UmzSSfweiMCZWtnoN
 96IS/Ow1rwMyUu69nV25/xpQZg+6WHEjpEABfSQIdF8sn1DHxB/5VenGgmGPaw1KnX
 r02ULa1af/nSXvUERFrMCsVcx0jQcXXSVmkxRf9osCqTJh9CG0/KXE7XbTt7WiA8g3
 uLNXlwHxmiX9tH3fOVCRWngmI9renhE9ufP7psv5VMvEe1G55nzBuHDHTcAru5G/R+
 1w/SvrnRoaTK6NiOvTgjDPFFxaN1Rhk9LAB3rGimaZ8IbgJb/yTlF3k5oLJt8dcmf0
 HTJkPXUNlyBxg==
Date: Sat, 02 May 2026 10:20:57 -0400
MIME-Version: 1.0
Message-Id: <20260502-case-sensitivity-v13-12-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=eE/CDF09GJkNn3nT+HwwWprfQOLLBRzGLyDUxw4X/sk=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghRmCEuePPe//SHQ502dQGkoxCxjuAHC/hRa
 fUBXU2YYumJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUQAKCRAzarMzb2Z/
 lxWnEACPaz1eUuja7jmdPVv0JQHyIuo1ugA0aXldtbzVmcSfI1X/R9iBPFT7lrP+ZPpjVDsCUYy
 bqKDSGPnPly4DFYUoAofKx1COpc7J/fxDdcV+zZyoP+sPBLVBw1seGdYmCDuFmBuVKFfcXsWDrH
 DaPQIf6NaLKNVLcTNTPccYfu3uCNwLtLFQfoL5jd46aD301fMKBspM9KnfqGRZ+sQ2wa79NImQY
 ckRcwwsqJAmOGZaq1+qNT6G/DHvEVfyYAjHivZDfMEtTbQg7HvcsOl47aJQ67WIC0Oh4k5jrip3
 peWH6RQdRzgpqQD63Ql1E1vJ7fYBVtxvmAfp+Zl7RpOI55APHqn5WaocktAW8WBJ5tDSLE2de5k
 dJUWq1y8Zjh194+280R0ZhI/v5qUNiCRZnD1WrxDMr4Fhwkb8PmHW922k/ozL7Jkn1IMxWcMcwv
 f793VW48j9v/+ZRAMdFmG5YJ49eVIPsTW8Y5VskBOEqp0sg7fAQQbSt+DtY4ELcGj3TduKS/Lg4
 M90PmHKaFbPWBlEyqxj5ALiWqw8A6/jqth90thXdYI8DuEtAWjoQVk1dwk6skwmA+Gv2lItW3Oa
 f1bFKMXN5Yh0iCnm/I/CvC2L2QR5Iqi/dFfmNT1lPk/jdfFIkTcG6c4XnZAi1ZAs/CekBIDpHq6
 iRgJpm7Ft4TL5aw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wJBEo-0000w9-Sd
Subject: [f2fs-dev] [PATCH v13 12/15] isofs: Implement fileattr_get for case
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
filesystem handles filenames in a case-sensitive manner so
they can provide correct semantics to remote clients. Without
this information, NFS exports of ISO 9660 filesystems cannot
advertise their filename case behavior.

Implement isofs_fileattr_get() to report ISO 9660 case handling
behavior. The 'check=r' (relaxed) mount option enables
case-insensitive lookups and is reported via FS_XFLAG_CASEFOLD.
By default, Joliet extensions operate in relaxed mode while
plain ISO 9660 uses strict (case-sensitive) mode.

Plain ISO 9660 names on the medium are uppercase. When neither
Rock Ridge nor Joliet is in effect, the default 'map=n' option
(and 'map=a') routes lookup and readdir through
isofs_name_translate(), which forces A-Z to a-z. The names
visible to userspace then differ in case from the on-disc form,
so report FS_XFLAG_CASENONPRESERVING in that configuration. Rock
Ridge and Joliet both deliver names as authored, and 'map=o'
emits the raw on-disc name unchanged, so those configurations
remain case-preserving.

Casefolding is a directory property, and the in-tree consumers
(NFSD, ksmbd) issue the query against a directory: NFSD walks
to the parent for non-directory dentries before calling
vfs_fileattr_get(), and ksmbd reports per-share attributes from
the share root. Wire .fileattr_get only on
isofs_dir_inode_operations. The CASEFOLD flag is set in both
fa->fsx_xflags and fa->flags so FS_IOC_FSGETXATTR and
FS_IOC_GETFLAGS agree.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/isofs/dir.c   | 16 ++++++++++++++++
 fs/isofs/isofs.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 2fd9948d606e..55385a72a4ce 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/filelock.h>
 #include "isofs.h"
+#include <linux/fileattr.h>
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
 {
@@ -267,6 +268,20 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	return result;
 }
 
+int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct isofs_sb_info *sbi = ISOFS_SB(dentry->d_sb);
+
+	if (sbi->s_check == 'r') {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
+	if (!sbi->s_joliet_level && !sbi->s_rock &&
+	    (sbi->s_mapping == 'n' || sbi->s_mapping == 'a'))
+		fa->fsx_xflags |= FS_XFLAG_CASENONPRESERVING;
+	return 0;
+}
+
 const struct file_operations isofs_dir_operations =
 {
 	.llseek = generic_file_llseek,
@@ -281,6 +296,7 @@ const struct file_operations isofs_dir_operations =
 const struct inode_operations isofs_dir_inode_operations =
 {
 	.lookup = isofs_lookup,
+	.fileattr_get = isofs_fileattr_get,
 };
 
 
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 506555837533..0ec8b24a42ed 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -197,6 +197,9 @@ isofs_normalize_block_and_offset(struct iso_directory_record* de,
 	}
 }
 
+struct file_kattr;
+int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
+
 extern const struct inode_operations isofs_dir_inode_operations;
 extern const struct file_operations isofs_dir_operations;
 extern const struct address_space_operations isofs_symlink_aops;

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
