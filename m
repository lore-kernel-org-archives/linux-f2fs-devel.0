Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B514DFAD3E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUuKAzWbbfQuXWVWkKR/CmZQeglzNKfdPEWBo0nuuv4=; b=UxXPyIWjDSZ+YDdjJ5XcCHIdGP
	ww/OsK+zK3SwnGcfYZT53Gi+Yw6oeIxbT1GuvoxvfPafIMlm7QiHqNK7dkKsEWhvDQHVEYTIhBRo8
	aRMfcnxJJ6Yqebbd76W7yU+tAX5HAQBiL/1aPqUdh2PIZiZbVI6wENLRbM1squPoiby0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh24-0001sT-TU;
	Wed, 22 Apr 2026 23:30:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFh23-0001sD-Rl
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z5jmxzr/QkA88IM2AeBIh0VM25QEN1QMOFQtcMI5kkw=; b=jFBrKSgcohwAC1zJla3hdv9AD1
 J4tSwCrTcaaVFfBZn8u92OzZrnyJ3HeLUnZw1v0lBYA4btwO0LYbAl962eTzLzfSwPzBtzW6w3R6N
 BcdFzSFJ8jUaAVCpuUBW2GYIec6NY92itakja2VnwiZU2Z8TGpNWCAsSpI7FXRSrxoPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z5jmxzr/QkA88IM2AeBIh0VM25QEN1QMOFQtcMI5kkw=; b=AIXNeRLK8kLEVz8pQa6KnspHEa
 pfy2TRfCwovDstvjla65o8qTA7elVrx85eqmbo06n9J25LRIFspSp1J/ZVHETP/eOhc4LWWYdiUO9
 /Ju6dVvzmfMgpXmLh6fkEhrob6GltXm9zHrrM+6KJOtUGIj6yq5KTcSAZW9lv4vjYrzQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh20-0006er-Hn for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:30:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EEF1461879;
 Wed, 22 Apr 2026 23:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3F4C19425;
 Wed, 22 Apr 2026 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776900650;
 bh=01dn7VPhZ7IaECyyXD1nCwqLHm0UbGEoyqWSLe5m9tM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iRNQhzJYPp4pw6bkhzG2kUISBPMGKc4r5mJxYotWGT5thxubI08DIk5qa70n7X0nY
 CYDqijAUz5SXcuIjTHS/w/olMp10tbWDVokPkI/h5WY6sSOdeTfVFcboNB+vfKVAym
 YxGHw6Alx3nlv0kxzSbcU4rCHOQ3nADshR94hgCa5jfYK8hRc0q8Ja9poCWP5pdMpS
 C4dSDm2n7dxqztAzBn7yRDS2HXwHfxLHIxZisqeRvVD8vgrtZ17cSubMtJoPWWP6E+
 fo3YKqNJbjvjW5UPFIpZEsevm9BIHx2PHGVF8MRP8XmtQ5EL8VQTP8ciJ7RKvX6+rT
 PXQWv8V7CXURg==
Date: Wed, 22 Apr 2026 19:30:08 -0400
MIME-Version: 1.0
Message-Id: <20260422-case-sensitivity-v9-14-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=kh4Mo9qHXj56Vn2bJA48n97L5gwCBfFYkAAOr9+sl3U=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoGZQsJtBMnjFwQhTw/zhXJZoWoDCubwoAGM
 lTtdNYJPkOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBgAKCRAzarMzb2Z/
 lxzWD/0bbswcNfCXfd/LYYdUB74Xza+PwZJwxaDAGntT1IS5sExaDkbfrHAXTmF1nkPwamWJkbO
 yl9Q0T592fxKKKziwcQvsXlvCcuqmSXq6XVE3rhiZdqde9rLCu48w0654vAQk0wyMtYlGE0Z/jU
 XWpIKL409vVghaZOhdSGZbYaFiEFhX7rKxVSOJ/6I4U3WP0akIFTxpDGURYrsU4HgDInaRjKRgq
 csMnwabRNaJhLZ8z5t62oFNX2DeInB4XJ0MvpZpJI0dvjGujXHnMremOVktTDPE798M00/+Mxmf
 cSfTNnT1Jhm0clTMM6Kcyax+oQOhHkWO2Ck1RbUpNzha03TLchUEIl9RpBgyktRfNsV1fwmWr8V
 apCOmV+A7w7GwTL0i5FEglWpJpuMDfrIHImr5j/Z+9tG1FRGMh8vbQjJNymcdE9OWdBGTJ6hbzS
 4mysifqeP/8YprQhTzY4MFfF2Jh3seJHly1XIgVRUXjfn4Je0NB5NP6nBYql+cvQhy73sW4iTF4
 W7N8EM+w3ptzQJ8AnExQubTxWEw+DKgS5fT0tAs83RxqViFUo+Dj8v6e5ZL0eJVQvXIv6uEaUBr
 MtiNr1hGDgdGOQcuAZBEtAOPrHvLRuVq4tRQwB6lqNRiyPrRdpFAjX6U9v3PgpRubE4yiRfqDNd
 vcMxASGa88CRasA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFh20-0006er-Hn
Subject: [f2fs-dev] [PATCH v9 14/17] isofs: Implement fileattr_get for case
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
behavior via the FS_XFLAG_CASEFOLD flag. The 'check=r' (relaxed)
mount option enables case-insensitive lookups, and this setting
determines the value reported. By default, Joliet extensions
operate in relaxed mode while plain ISO 9660 uses strict
(case-sensitive) mode. All ISO 9660 variants are case-preserving,
meaning filenames are stored exactly as they appear on the disc.

The callback is registered only on isofs_dir_inode_operations
because isofs has no custom inode_operations for regular
files, and symlinks use the generic page_symlink_inode_operations.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/isofs/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 2fd9948d606e..bca3de5a235d 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/filelock.h>
 #include "isofs.h"
+#include <linux/fileattr.h>
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
 {
@@ -267,6 +268,15 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	return result;
 }
 
+static int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct isofs_sb_info *sbi = ISOFS_SB(dentry->d_sb);
+
+	if (sbi->s_check == 'r')
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+	return 0;
+}
+
 const struct file_operations isofs_dir_operations =
 {
 	.llseek = generic_file_llseek,
@@ -281,6 +291,7 @@ const struct file_operations isofs_dir_operations =
 const struct inode_operations isofs_dir_inode_operations =
 {
 	.lookup = isofs_lookup,
+	.fileattr_get = isofs_fileattr_get,
 };
 
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
