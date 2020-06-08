Return-Path: <SRS0=UwVw=7V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC24C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:38:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762282063A;
	Mon,  8 Jun 2020 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NTGlPCUI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fgC/pQtP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdqJ7Mp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762282063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jiMff-0005vw-4V; Mon, 08 Jun 2020 18:38:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jiMfU-0005v3-5s
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jun 2020 18:38:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8UE6zHIyhh1HBSml7kocH5TDGAr9Bp+Wz7R3SpfOtac=; b=NTGlPCUIq0n0NcOcd43kquawO4
 t8rEPqxFZ8Ys+7Xdfj0HTsQRs/pfCaUoWMosshYTmN1/5snIR5Nxfdkl1oSgbgaaD8yPl/emSHmVu
 OnhLDutkH9tlGA/sxYiI3cRdIAwP61yeMGpViJdGXQ2iNiNH4A72Ove6w0TmsRBERqog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8UE6zHIyhh1HBSml7kocH5TDGAr9Bp+Wz7R3SpfOtac=; b=f
 gC/pQtPvNjzCMGaVl6GJowlLcwMN8lxS1/7R9hhKj8GPMldjfDu+vhGMfKwWe1pELoEpCQskGdnPg
 iAWaTV9zGzVd9qyV/bFqKInAd2/9cREwB0B9YpqgD8FTO+ftPlMjoJjkoJ+iNbGQP2+XaUTMw573X
 cgGGWRnXFxEpuYAk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jiMfN-00Gk65-Dh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jun 2020 18:38:38 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C9362063A;
 Mon,  8 Jun 2020 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591641507;
 bh=Yf1T1NI6ub4rhTNen17865pgWVOc8wVByFUMuVSwFjo=;
 h=From:To:Cc:Subject:Date:From;
 b=LdqJ7Mp50wkV5uqE55KuNFlkSD5AR5WkWOUoVzpzAhNVzDlqre0nRlPmu4+kq+8sQ
 bNy7ovc401szZ9pQ60GU+gEL17UJo2vzW5SPBnAIxhxkfrWRDOtZBpMlRoomjMoTo9
 SYvR2A81aNuwfFXk1QVZXuAGQoRDv+JfSt+yldFE=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2020 11:38:25 -0700
Message-Id: <20200608183825.126749-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
X-Headers-End: 1jiMfN-00Gk65-Dh
Subject: [f2fs-dev] [PATCH] libf2fs: fix build error on Windows
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Windows doesn't support S_ISREG, so let's avoid depedency.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h | 4 ++++
 lib/libf2fs.c     | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 265f50c..709bfd8 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1178,6 +1178,10 @@ enum FILE_TYPE {
 	F2FS_FT_LAST_FILE_TYPE = F2FS_FT_XATTR,
 };
 
+#define LINUX_S_IFMT  00170000
+#define LINUX_S_IFREG  0100000
+#define LINUX_S_ISREG(m)	(((m) & LINUX_S_IFMT) == LINUX_S_IFREG)
+
 /* from f2fs/segment.h */
 enum {
 	LFS = 0,
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index c2960fd..55d3a5c 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -504,7 +504,7 @@ unsigned int addrs_per_inode(struct f2fs_inode *i)
 {
 	unsigned int addrs = CUR_ADDRS_PER_INODE(i) - get_inline_xattr_addrs(i);
 
-	if (!S_ISREG(le16_to_cpu(i->i_mode)) ||
+	if (!LINUX_S_ISREG(le16_to_cpu(i->i_mode)) ||
 			!(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
 		return addrs;
 	return ALIGN_DOWN(addrs, 1 << i->i_log_cluster_size);
@@ -512,7 +512,7 @@ unsigned int addrs_per_inode(struct f2fs_inode *i)
 
 unsigned int addrs_per_block(struct f2fs_inode *i)
 {
-	if (!S_ISREG(le16_to_cpu(i->i_mode)) ||
+	if (!LINUX_S_ISREG(le16_to_cpu(i->i_mode)) ||
 			!(le32_to_cpu(i->i_flags) & F2FS_COMPR_FL))
 		return DEF_ADDRS_PER_BLOCK;
 	return ALIGN_DOWN(DEF_ADDRS_PER_BLOCK, 1 << i->i_log_cluster_size);
-- 
2.27.0.278.ge193c7cf3a9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
