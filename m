Return-Path: <SRS0=L0OP=GM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F75C433E6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 Jan 2021 08:00:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EB923A5A;
	Sat,  9 Jan 2021 08:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EB923A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ky9Am-0002Od-8C; Sat, 09 Jan 2021 08:00:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1ky9AS-0002K6-2n
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Jan 2021 08:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E9RZGHJ3iRzLVgflzlgZdLefnE9lEKxMIUC8T/dWH40=; b=X+Dx7sFMiEqXWSH6Eyup/UjkbA
 43AX8/oI7HVLoLid1RI78kefQwaKsMP/uhdOZfS1RLqXW+UxFdwHyREAdf0B/UtxzPnJrdTDm01g7
 e7BBM7dht+h6iToddRXvmVJJYTbYZ++LG+mOfGByUAHBGUln9lpc36Lu3ZWfV0lOhmAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E9RZGHJ3iRzLVgflzlgZdLefnE9lEKxMIUC8T/dWH40=; b=WfM94tjUWPEuCX9BeNAwQsMnW0
 uMk7Ooku7zV5isN3RlXUCfef6e+u1+w+mNE/RsJB4VgZ07SfQnSxQkH5BRNRbfsG79wBfuYeb22A4
 p4vnKHxnD2jDhkZOzdHn3dvDHBvmcXROlTK5bkzU+SiIHjBu7F3Z0FGMh/m5KFeXsITc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ky9AP-00DnEg-CU
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 09 Jan 2021 08:00:12 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48D5023A79;
 Sat,  9 Jan 2021 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610179186;
 bh=HlkfW2Zd+8gbGgRYWpPKUKO7Wsu0D0Ym2jm7ngGDK6s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TiFXWSyfmbsN3BDcG7PKa2lenBUufiTlI+s5eLmHeooUDodCaYvgbrC0t8ZxpN/zN
 JbsWlpl0uq3xkj5uqtZv+Bo4odDb3qTVPjpPtDmhmn5Wd7nmW3THFhIGqFy82BMiGx
 tp9i8kbwvNKQviYzrZG0WbLWcr5XJbqWSAXXjQI5TJr7DmZT9dJgYsscxWr94zZu1U
 29llfMrMr/uxGRdZ2bUSuC0QnTZLXzMy4tbITGOnHX9r67IwEncVqVlvh887GdAWF9
 1Joi3ciGc+t2Xqd3h4Ez1iZELXUZYaXEfHjEQS13fBBYIrW/L91+G0qYr3wVEK2oYu
 c0nd4I5Kgqq7A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Fri,  8 Jan 2021 23:58:59 -0800
Message-Id: <20210109075903.208222-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210109075903.208222-1-ebiggers@kernel.org>
References: <20210109075903.208222-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1ky9AP-00DnEg-CU
Subject: [f2fs-dev] [PATCH v2 08/12] fs: drop redundant check from
 __writeback_single_inode()
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

wbc->for_sync implies wbc->sync_mode == WB_SYNC_ALL, so there's no need
to check for both.  Just check for WB_SYNC_ALL.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 80ee9816d9df5..cee1df6e3bd43 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1479,7 +1479,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * change I_DIRTY_TIME into I_DIRTY_SYNC.
 	 */
 	if ((inode->i_state & I_DIRTY_TIME) &&
-	    (wbc->sync_mode == WB_SYNC_ALL || wbc->for_sync ||
+	    (wbc->sync_mode == WB_SYNC_ALL ||
 	     time_after(jiffies, inode->dirtied_time_when +
 			dirtytime_expire_interval * HZ))) {
 		trace_writeback_lazytime(inode);
-- 
2.30.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
