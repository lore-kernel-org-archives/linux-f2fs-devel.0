Return-Path: <SRS0=4iVE=XW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC3C4360C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Sep 2019 01:36:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FB4207FF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Sep 2019 01:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="NVguMN7k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="KEZ8nHvK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="d7vGtkxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FB4207FF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:Message-ID:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RUaHTGCdHZvL/AgAwgBPNi1qhpleq+CqnO6IsvfFj60=; b=NVguMN7ka0E4MA9MoweoOPnJ8H
	9UNGFALsIY/RWUaE+oSYCX0o+Y3cpcqss6LZZ5rQvFSyqxcxUunRe0iNG+DCPOqWE/EqZVmPm4NyU
	7MvN5csv9U29shk3UPkiZzEzlp7hAzX/S8ShjOHap48W7Z1NXbRlS5gP8uS+DuONF5CQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iDfBV-0005wX-Sp; Fri, 27 Sep 2019 01:36:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@zoho.com.cn>) id 1iDfBV-0005wQ-5S
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Sep 2019 01:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Date:Subject:Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PB3i99zUQXrbOUPJpGvsowcV1U24yefnhfuBNuZx51w=; b=KEZ8nHvKN4gLrYIY+iiOmapVBt
 VdmZCsEXoruqLvpDVW4HwwpbkonYDfP1Ps16qJPH3paOtioNuGxMnBOGko13OKrMi8Qw8AiSavqIq
 xDdRa/XHEU74ft5pic1fB43ZKkUOyV2z4jTs3vpscyjflIvPqsohOEX9a9G5frCdsQS0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Subject:
 Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PB3i99zUQXrbOUPJpGvsowcV1U24yefnhfuBNuZx51w=; b=d7vGtkxu1z2fYnu3Av4JHXFAw1
 eujq4Fb3IoWW0XBLD0d+y57Ke5U8zaU3PK8DhaJJ03GPTgmtt+tePUuB6oBO0TXyQ8T2JQ3bCYAgj
 SoRpiJ0mg1GqbN4N13HSnR4lLJCiQmyWuWf1v4+L0QcN8digwaXl9+HEi0EsRNYCy22E=;
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.92.2)
 id 1iDfBR-00AaSi-Qo
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Sep 2019 01:36:37 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1569548175; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=mGeBsVeL+qTk6PL+k3Oi6Hq+2h+2dCCfgbdKK47SWtCjpjSMi1xwbpTztopdXGD0gU2E6rdxACGKJ9Ly2HA4V73cqOnKrLmBY5Zlj9e1YS6Cz7BW1XqaJli5HWqqjhN2VztfjSbiuFuLnFu2/UMhVtqQGMK76zF8e6+DwZIetjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1569548175;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results;
 bh=PB3i99zUQXrbOUPJpGvsowcV1U24yefnhfuBNuZx51w=; 
 b=kKQsp2N2DcGHaBXUOU1ThH1zmXIAbwslWgzRKpMJpO1ilEuQzFnV5NENwmYCXxPdcbhnvUTeFidtqkA6tvHnX8qILi+4b6luVlc0jzQaDBYpL8ZQa3be6U/YqWYNS7G2OWCwrWy3HWfYsKnOChrJyhkHkK8dh9yFdf1Et1yju+U=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=zoho.com.cn;
 spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
 dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by
 mx.zoho.com.cn with SMTPS id 15695481736894.927260112143813;
 Fri, 27 Sep 2019 09:36:13 +0800 (CST)
To: jaegeuk@kernel.org,
	chao@kernel.org
Message-ID: <20190927013548.14843-1-cgxu519@zoho.com.cn>
Date: Fri, 27 Sep 2019 09:35:48 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-ZohoCNMailClient: External
X-Headers-End: 1iDfBR-00AaSi-Qo
Subject: [f2fs-dev] [PATCH] f2fs: mark recovery flag correctly in
 read_raw_super_block()
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
From: Chengguang Xu via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chengguang Xu <cgxu519@zoho.com.cn>
Cc: Chengguang Xu <cgxu519@zoho.com.cn>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On the combination of first fail and second success,
we will miss to mark recovery flag because currently
we reuse err variable in the loop.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/f2fs/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1443cee15863..f3a68af3b43a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2951,6 +2951,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 			f2fs_err(sbi, "Unable to read %dth superblock",
 				 block + 1);
 			err = -EIO;
+			*recovery = 1;
 			continue;
 		}
 
@@ -2960,6 +2961,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
 				 block + 1);
 			brelse(bh);
+			*recovery = 1;
 			continue;
 		}
 
@@ -2972,10 +2974,6 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 		brelse(bh);
 	}
 
-	/* Fail to read any one of the superblocks*/
-	if (err < 0)
-		*recovery = 1;
-
 	/* No valid superblock */
 	if (!*raw_super)
 		kvfree(super);
-- 
2.20.1





_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
