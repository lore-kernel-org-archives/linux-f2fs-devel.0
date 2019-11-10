Return-Path: <SRS0=wBWF=ZC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504FFC17440
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 Nov 2019 02:42:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D6A214E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 Nov 2019 02:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jbe20aqL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="gOrstXMq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvB5/bTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D6A214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iTdBY-0006ST-84; Sun, 10 Nov 2019 02:42:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1iTdBX-0006SM-BJ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 10 Nov 2019 02:42:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HT1zS/wDlNYMQxu7fKXvvsAccZ4t+FzY3FQ5fz3HdUc=; b=jbe20aqL0JwDtx2PDEOLkJECqW
 4j/n2bk8d1Cf1E0snUeK1vAlb2G7MUKWe0eCgbZtIqTfUdpcSvOH2Q6k+rCgS10HZUsjsrjbcGtjM
 6BvzndYNcTJoczkWnsP+EQzwTeEKGtLAHDtvUvfJmbMdZ+ceV8fimp5bayPJ+8Cky/Hk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HT1zS/wDlNYMQxu7fKXvvsAccZ4t+FzY3FQ5fz3HdUc=; b=gOrstXMq6T2zzgGxTrncCoITgs
 apuxSuLCdyQ7CV0WKlBrKItJLeQXQ8SrjOpVcI3ElpFucxGigWB/vnzyGeD0IIPDv7eONBNM67cjd
 dmCcRjxfEaxo+0lhbFSCbxEyMUjF/+2RzETMI/NhGadzjPTq41V4/fsfuoHkA0SzX3KI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iTdBT-00A5DF-6X
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 10 Nov 2019 02:42:39 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C57F21924;
 Sun, 10 Nov 2019 02:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573353748;
 bh=WcxXUNBUSv0CfufluOGxMfubxgccM0aLRAa4a4l2zR8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AvB5/bTFEJ3NIita8ZjU2u9T9mu2E9GbSjLsePvGDk1+gxxTG8DNHUoGkvz5mrYep
 9EgskcdnVWjU75doBiIX4IMvcvxh2ouMzWJjyyJxPyMjdQEX5ZWCD3I9JzNUBysyqw
 FXuprZF4kizDI5fXKp6VN/kcEahlU8W1337u8mOg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Sat,  9 Nov 2019 21:38:06 -0500
Message-Id: <20191110024013.29782-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1iTdBT-00A5DF-6X
Subject: [f2fs-dev] [PATCH AUTOSEL 4.19 064/191] f2fs: avoid infinite loop
 in f2fs_alloc_nid
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit f84262b0862d43b71b3e80a036cdd9d82e620367 ]

If we have an error in f2fs_build_free_nids, we're able to fall into a loop
to find free nids.

Suggested-by: Chao Yu <chao@kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index aa8f19e1bdb3d..e5d474681471c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2367,8 +2367,9 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	spin_unlock(&nm_i->nid_list_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
-	f2fs_build_free_nids(sbi, true, false);
-	goto retry;
+	if (!f2fs_build_free_nids(sbi, true, false))
+		goto retry;
+	return false;
 }
 
 /*
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
