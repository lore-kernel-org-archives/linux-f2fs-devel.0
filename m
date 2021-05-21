Return-Path: <SRS0=X3cT=KQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60A3C4707A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 May 2021 19:02:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1534613B6;
	Fri, 21 May 2021 19:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1534613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lkAQ0-0006KU-Bi; Fri, 21 May 2021 19:02:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lkAPz-0006KL-17
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 May 2021 19:02:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+n895/c/46BH4yndA70M3g8EXU06Bxj196JGwXNPNPA=; b=Je1UbklOFLn6t0wdHG6St9lkC+
 mPfIWYgBsqM6iW5j6K01bBJJWxmtbC+QCvrHe2/zO2+u0pWTHV/W8eQvz5bDRTrJ7DSTz+8dFTaiS
 wQBctk2mnFbU9Da84eyGeWxtQrrFpNqrowwaBaMudhBSN9r6uiDvrgijLRknODDUtG5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+n895/c/46BH4yndA70M3g8EXU06Bxj196JGwXNPNPA=; b=e
 f/S/mXgqQST2hqhrTAIySL30W8gNcbmeSYQsJ2EHeSLyYKMNGfd94JCFCtEwqVYSC8FR2qAH4gr7F
 LsejR43TUzPWcdqBVrM4TOmXaC3BRFWmp8UdaLLTYjDEr9b1fgRII28F/ju3IApL5ai4/QaMw5nZv
 vIlOBRv4dHKe9VY4=;
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lkAPt-0006KH-R1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 May 2021 19:02:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D98D613AD;
 Fri, 21 May 2021 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621623743;
 bh=PwYVEBdAYioTg9dJDanRYBbNY1d6VzNe8pGxwNgHwts=;
 h=From:To:Cc:Subject:Date:From;
 b=Z6pBlx9PqRwpvhLSpS84t22o70Jagai7OtGqHdaPV+fIYO5XMz1N/8T7Y09nXFFpg
 9Xe5GPyKesQTFirhUtEyFp9Npa+tHN0GMPSt7EenGDbQQHnqdziXFuFisgd6Y80mPd
 B4je9HWSH56F2nC/Y0A26eeB/lnq93i2W13D55snJP0FdJkX5L+32CcFJlNm2HvDn8
 iDlr191ukjmJm70oPL+tERx5bJdf+WHDklvTUbY6ur8+zYQ5ISdjaLfeTQUOncryiN
 Zb+yuh9HETAuuTca0yIUZS8OoJvCMQ4r3awG/SqYztbThqjVNubiKub4axbdq4xH3C
 ZNNCtxofktY3Q==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 21 May 2021 12:02:16 -0700
Message-Id: <20210521190217.2484099-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
X-Headers-End: 1lkAPt-0006KH-R1
Subject: [f2fs-dev] [PATCH 1/2] f2fs: immutable file can have null address
 in compressed chunk
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

If we released compressed blocks having an immutable bit, we can see less
number of compressed block addresses. Let's fix wrong BUG_ON.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d4f7371fb0d8..1189740aa141 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -927,7 +927,8 @@ static int __f2fs_cluster_blocks(struct inode *inode,
 			}
 		}
 
-		f2fs_bug_on(F2FS_I_SB(inode), !compr && ret != cluster_size);
+		f2fs_bug_on(F2FS_I_SB(inode),
+			!compr && ret != cluster_size && !IS_IMMUTABLE(inode));
 	}
 fail:
 	f2fs_put_dnode(&dn);
-- 
2.31.1.818.g46aad6cb9e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
