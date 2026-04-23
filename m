Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6B9F589CF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yUuKAzWbbfQuXWVWkKR/CmZQeglzNKfdPEWBo0nuuv4=; b=OIHOJopUsxkGj1g8HXqO9PlpXt
	FK6M1j9vuscFTTK30pr12dU9JiTZCNdDRkKcPLhXb7sgobcyszs1gpHcusdHXS5a0+OMr1ZwTzcJu
	za2Qbe4FdnDiTkN6dald51COfVVCQU25yi722mS8a8PcauYFlxS91dRFEKYJs+YOZCiA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFtri-0002go-BJ;
	Thu, 23 Apr 2026 13:13:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFtrf-0002gP-6l
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z5jmxzr/QkA88IM2AeBIh0VM25QEN1QMOFQtcMI5kkw=; b=JNrzsZ+pRhvyaV/VSV2WKvPZix
 tm7ail+1EP/0FUikUz67HpW1LcLGRAG9KqSCf1OfrhInqMdORRdGESk7dUFkQpS9qu2T2AaceT1tg
 doKNFxSzVv/dFHf9vlZn8NlLmoPo+egN5Br6Ofxpl3GeH4wDCh6lZJPBiF1WCG+S+ebs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z5jmxzr/QkA88IM2AeBIh0VM25QEN1QMOFQtcMI5kkw=; b=Sp4rEMReZDB7qx843I2dBfGJNt
 S5+DGpAC0plTmRG76oL94e4WGo383kgMaRTN1iIy5vqxQEROO7NMxR5wEW2bXp1qvFp9v7HGsy0fU
 cYqEsBgs0X+nJ5iahbwLUhcJDRjNoKI9q1z47v7rwKWboo7w0LOVeqf4ElbiT3fpD2ow=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFtra-0006pn-SO for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:13:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C89FE418CC;
 Thu, 23 Apr 2026 13:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D18DC2BCB3;
 Thu, 23 Apr 2026 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776949976;
 bh=01dn7VPhZ7IaECyyXD1nCwqLHm0UbGEoyqWSLe5m9tM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=b16TdICr9mZe60kFhLdeV6cmaDGNpfEikcnOLDeDMJQaI50PMYJ71SyZVynZC8kiL
 AV1QLGVMlgt6HwMfbeFabkL6Y+SN+LBBGg6qX/tlVtV+u05nW5VAC8ZOQESOXIyszj
 84pqe2SvG62KTSfPha1KhHSE6T9VQCz+MvgcXa0VMB1b+W0dY0KzW+a/4mi35X3SGw
 Q7D7BnK3q0aX9whLuq+knJl0jPHkYwvluDxHMYnS2X0FsMxf0Ndl5upRjY+tH4qADo
 70V+o6eBQ2/Pff74JQ6znYpd23LcrqWPJXaS6s/glYbhQeGb6ETkDiG538HQ/hNS5E
 7okz82vlQMJtg==
Date: Thu, 23 Apr 2026 09:12:17 -0400
MIME-Version: 1.0
Message-Id: <20260423-case-sensitivity-v10-14-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=kh4Mo9qHXj56Vn2bJA48n97L5gwCBfFYkAAOr9+sl3U=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq0A+HVhmB7vI2F2Wlqq9NFQfEtQyqUXWu+o
 +K1syaw55CJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l3wCD/0Q0GwJCTMg1VCavAps86ODA+BZ5Sf+KZI3WsJhfi2Q6VEwF2nE3f68CAKD2qEFpQNJTjZ
 p8CXuvaXF50nUleUavJovdk1Ml64Z285yMMMC/BddkYYlI8svFlX5otSLfer7YdS43KsqZ9LmFx
 rslu71Ht6Ih/pLG1yF+C7nVVfSAwRZOfe/1dWWkzUEkbb0Kl8OppNiil5kKyC8SpQ1JnwDlH3k8
 x21yKTb1OQJ0juDNBSnGi8exnrtW41fFwc6BGFmn4aJ623MUFrdpZvcM5rz3ZoLdLDItLGbkXOq
 /Ik6XeetDOYWsniur/T72bGu1Zl+L5LmSjlXRL2yTQnM0W3pEwYchxCq6rCbccvVfLNht0TASAc
 Rq0Z1/fSFvEJ7gbsEM5Kod3pxFtb1hF3rjOYD4hrZTZf9mPcWMVpNIwbnBci4x0tqJ0m/QuoJlm
 lebV5vx9y1Gv/2Ofz0kuJzn4bC3DFfAVqnLH7+CmYDgeJhFWvBnPjwbALsQl/nbvexmc8zEKoU6
 9+xr5X3TUoXH2P/OiH2Un3rJPPA0r/dUU07y5Xxv20Z3Kq124f+KfCxhF75Mkp0O9q1J1DqRsnd
 X42RnlWOnseNgKD/pWK+0g0gnw1eU02tEGLhyyMVtCqTWaEcAwPIFaJItnNz0Ufem7750QiY3kU
 xKhp7ACxhq+whDg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFtra-0006pn-SO
Subject: [f2fs-dev] [PATCH v10 14/17] isofs: Implement fileattr_get for case
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
