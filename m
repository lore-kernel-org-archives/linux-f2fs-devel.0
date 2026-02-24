Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2564EEEC2B3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Feb 2026 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F5aOm1dZm7lcYVGr4FyqBY14hCZODJkcoRCqnG39Jr4=; b=aZIPYQdxNZ+tg/7N7qVv/YV/Fc
	1ZSItXYSDlOWqrBhnugIpAAKWdGRPzBefU5+Zx0b6xlHlDVKyeXmOnc8csRwWjR2S6kjFUTUfgXy+
	eQCTqU5nzcs7oaaqKJsy34ToN/xHDQew/nhF8e8wGV2DOeye1R2pzmBXSldYLnWGUiLs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vuh6Y-0008MK-Ua;
	Tue, 24 Feb 2026 01:20:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gregkh@linuxfoundation.org>) id 1vuh6U-0008MB-6e
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 01:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HyWCvYp44NcOFfmwVn5C5UaOSsviyQtAU927MvNIMKA=; b=ltfcqdp1btI5v86OdMr2ysB5cU
 v5YOKx044R4jflF5v663S2DH3QIk07BuW9sya2kU+wSiH6o+bwsx1P9nFLqSYzchQ8Q6F9EsJ2UQg
 yEfSmfcEimRyAQw8QSRwEuIr7oYiazuND7dnqztVIVtB/6Qztc/ze4XuWWb414srEbN8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HyWCvYp44NcOFfmwVn5C5UaOSsviyQtAU927MvNIMKA=; b=d
 AXjGFtNn5ezqKPRqTO89BPwbs6h6i1WLsCPCnMoflYUxvvSNEIVLU7BeR9CfLnxRXXS+LDrOnUZGD
 NREGngzuU+YcNEfaCWJ7KfneCEUvMRT84u3YmR2aM7rT9vkXOgZGCEeT/R3wqVu2Xi/ICKF3Q2Bx9
 M1eTTjn0ZlbvwnkY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vuh6Q-0000gz-NO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 01:20:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 84E35600AE;
 Tue, 24 Feb 2026 01:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D33C116C6;
 Tue, 24 Feb 2026 01:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1771895068;
 bh=VRIBaptd13pTbEXa9jFV/M19Q0Di6cd9WUTWdMZl3PQ=;
 h=From:To:Cc:Subject:Date:From;
 b=aM/lIIt0gCE38crZFgTU3hNDXr2PbSWHif1cZantMtCgjgtTtWZQrmvsLSGsGPAoo
 5aXoQ9ZBh6l0rHcKi1P0EV529zYAlRY2C0esXnF4sggK0vF6I9A6hi1Ir02/PWiVT3
 gEm3m8hoLx4GUeYqycX00s/ZobQc0dPTZ39wPCWM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 24 Feb 2026 02:04:23 +0100
Message-ID: <2026022422-robotics-conform-9b68@gregkh>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=VRIBaptd13pTbEXa9jFV/M19Q0Di6cd9WUTWdMZl3PQ=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDJlzfoptb+M8FKEUXRJha75zEefmVw5LNEp1lsot/Mnbm
 MUjEWTWEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABNx0mdYsNyNY8IUEYd7NWyp
 LV827wy6MmOuEMM8XdH+L52tV584NArHHr4YeULwtdERAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
X-Headers-End: 1vuh6Q-0000gz-NO
Subject: [f2fs-dev] [PATCH] f2fs: fix potential deadlock in
 f2fs_convert_inline_inode
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_convert_inline_inode() holds the page lock of the inline data page
and then calls f2fs_lock_op(), which acquires cp_rwsem in read mode.
At the same time, f2fs_write_checkpoint() can acquire cp_rwsem in write
mode and then will wait for page locks, like during
f2fs_write_node_pages() or data flushing, leading to a deadlock.

Fix this by acquiring the lock_op before locking the page. This ensures
the correct lock ordering, op before page, and avoids the deadlock.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

This issue was found by running a tool to compare a past kernel CVE to
try to find any potential places in the existing codebase that was
missed with the original fix.  I do not know if this patch or text
really is correct, but the code paths seems sane.

Note that the majority of the changelog text came from an untrusted and
experimental LLM model that is known for making crap up.  So it might be
totally lying here, and if so, I am very sorry for wasting anyone's time
and I'll just go back to running this on code that I actually understand
and know how to verify myself, but I figured it was worth at least
asking you all about it.

fs/f2fs/inline.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0a1052d5ee62..98bc920a4f35 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -232,12 +232,14 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	if (err)
 		return err;
 
-	folio = f2fs_grab_cache_folio(inode->i_mapping, 0, false);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
-
 	f2fs_lock_op(sbi, &lc);
 
+	folio = f2fs_grab_cache_folio(inode->i_mapping, 0, false);
+	if (IS_ERR(folio)) {
+		f2fs_unlock_op(sbi, &lc);
+		return PTR_ERR(folio);
+	}
+
 	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
 	if (IS_ERR(ifolio)) {
 		err = PTR_ERR(ifolio);
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
