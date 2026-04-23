Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCB2F589CD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HK7rX8vSE8Wy9uRboT62LvrHbnSd4dFe1yrwFh3BMaE=; b=XjswHzsW95st85jlRq3f+D5KKN
	de8R4lNemqbzYVrciIzid9rB5HSKScOtzqU9rA6OaygWEIFE+3kuc+ipLQOckkWJ8dYk19Bx6u7NE
	6wefZYzIyjoUKgUWxQ2fp7VFHeyBnf87U28Od21o0KZGQMbUQ9H8uuHnEZWDksgZsHe4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFtrU-0005KR-Ad;
	Thu, 23 Apr 2026 13:12:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wFtrS-0005KC-NA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JhxbOvG2k4fgYgI60mGqDgkb8IOcCWtA7jQRHRmgKwM=; b=WPdlIlrrdFtaGN35QDMd3eABZ6
 FL8U3fXQ0doMZi70+teeznkkFZD9L3wC3fcXnc5vGf4QCq7oJ3GmoWqb0DdWZxRslkpGUsXHy+I8X
 pJ/1RiYUKzh9wdGhpyWpvfMyPU98WtaG9jtHqwONG/dyc9Kufyj1mSBnpyn+P/sZGb/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JhxbOvG2k4fgYgI60mGqDgkb8IOcCWtA7jQRHRmgKwM=; b=RS9ZoRieNrytyzKua31bKTY6Vr
 MTnjcO1kc8+QkIscbo0MH4ZK7/19rqDrI5YyZ+PP4aHLTliNvKpgoUGsqqFvYK9lhAcFvVnVHmRfV
 66PzEhReBVxKVLMZ9oMakNgOtejBu0oGJMCIBSJ0JDC8Y6aCSU/vL/K9a4YRq34Pyrws=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFtrO-0006op-ET for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 13:12:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BD4440691;
 Thu, 23 Apr 2026 13:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6368C2BCB3;
 Thu, 23 Apr 2026 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776949960;
 bh=PcroO5CweiTdfrAbvYqaLqKDeO9OE61yEag4vDGPG8Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=U+BrX7Kpru1Z5vLLQGmNkrh0X+a/0S2y1SxgkwTj8x7IqYZH84nwgjrAgws+s34y0
 uMXR/osBApQcJN0TxLJOrsbt9cEcIXETBXSYPmX3AgZzJoiPdVbr5AnnyfprQQnq4l
 q+0+tgrPmJ+f/OM+TXc+LeujetMf87cAlKqTlueJqDmsomwCoppVHN08Z1lIwL31eh
 Jh4I7cKU2fdfXJfCSOKPiLMSLZGE3/2OVoYLgA/8Nqg90L2ly7qW8Kxl3DQu36S9LM
 Ph15NzQqClaJmKDFccVzy6gudH/6DfXnqHCOz4PU8A04iXXKnA6/EdNnWJi2dINxJW
 Kkb9XZR6cMCww==
Date: Thu, 23 Apr 2026 09:12:10 -0400
MIME-Version: 1.0
Message-Id: <20260423-case-sensitivity-v10-7-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=DsH9Ul/eRW+1BLm1emwHx7xWw9r+GnxZnlKzlLXX6Ts=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqzledoq5XU2wz0+X3f+duTtSNUJibxmcFar
 OSNbaZOMQOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaswAKCRAzarMzb2Z/
 l/7uEACLjPNxrxqT92fHYGwoeDC62hHSmHNtL5PA/eDaGqYBX+8ikTmCRtH1IHbD8Y2GQcvRMkj
 6scugmG/j9aoOyA92lSo5qApBHdsdLthvIroO2meGzBVl5Q7EpCUsumNOuePGwvEE5h4WyG/y6s
 BAc+Yc18V3INM+F3mskeafT5/N1CyV058tQ0S1tqO6KYdNz6lPXihvR298D/h3PxduB3XMmYEdC
 nIpYULJxPA/p4fdqcWZ24T/xh4n4zLj63/42dhtMOXLM4MNYz0QjO8WIF1AsZtb8XUzTA6KaAO7
 b+GnKK0UIJCriuO932xLUs0vTJUUgdLpvSG34lfqc+jQitJvPd6HIol+g14JHfYcTBnXB62CIoX
 Mvs7oUSAjbpdbJjaMpMRfU2Shn7Z1iO0eFXR/KXXM9geiRk/vBowbBnbHbL55AkTuIvd/1gVbL3
 ETpkIPi96Vt0STINJKeOLfmqt5yr2nzV4Y3ZEVJylzwIWGplGwWemPUK6Nr/7ZOlYqxDj8kyhSu
 Kbsm95yz+hAxXwAFbdgoXeGnZoZiMHar34U6TieCNDlY7yrpc8Sjlx52904s3afWaDye+m2n+Yj
 HzLRXXhZlRL606EVDdTsw/NwWkxOA99uN2YmLU+mIC29r4Qwv6lO1v8gzqQqPyQf64ksnftrl4y
 WQsqhWziknVseNg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wFtrO-0006op-ET
Subject: [f2fs-dev] [PATCH v10 07/17] hfsplus: Report case sensitivity in
 fileattr_get
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

Add case sensitivity reporting to the existing hfsplus_fileattr_get()
function via the FS_XFLAG_CASEFOLD flag. HFS+ always preserves case
at rest.

Case sensitivity depends on how the volume was formatted: HFSX
volumes may be either case-sensitive or case-insensitive, indicated
by the HFSPLUS_SB_CASEFOLD superblock flag.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index d05891ec492e..ffbb57493d7b 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -740,6 +740,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -751,6 +752,15 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 
 	fileattr_fill_flags(fa, flags);
 
+	/*
+	 * HFS+ always preserves case at rest. Standard HFS+ volumes
+	 * are case-insensitive; HFSX volumes may be either
+	 * case-sensitive or case-insensitive depending on how they
+	 * were formatted. HFSPLUS_SB_CASEFOLD is set in both
+	 * case-insensitive variants.
+	 */
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
