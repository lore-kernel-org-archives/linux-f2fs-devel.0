Return-Path: <SRS0=YSGX=AH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FA3C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:39:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE92E2075D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="F0x/w/4y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="La7Cw8bl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LJvHKVtP";
	dkim=neutral (0-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="LBHT4NzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE92E2075D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YVYfH90piCFWUcDvWuIIm+U7kBDPo/Lt5+u1ADol+54=; b=F0x/w/4yBB5qFgKjy0N0BeSQpj
	ovZKo4uy6fx73hVU/Xi/kKk4x5XXsH6Ryb3jQ6KIWenUxERcnEYc0MRDWo3uFZ2/otkU+fm5UCC4t
	HXTUUHP8kcJ5YKC7ULVvVUA++QBQ1sEJJvjX/9+L5wNezbQhkCMDe3McMOLh6mt2ak5A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jopW8-0007tz-HP; Fri, 26 Jun 2020 14:39:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fishland@aliyun.com>) id 1jopW6-0007ts-Rq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Jun 2020 14:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CT51BNPHR7AExuryFXvB/HGhM5ULYsSHt/sn9ZNPtZ8=; b=La7Cw8blO6lhGvoy//4qRihI4p
 2bBcesZ4sJpD4bTXyTeiW1MEG2WynwbYS1JwvFCp2zeHm4zYTTzfTaZtW00ZH+IwYcZIJrjuD/AoP
 5o9psOcq6kFYA5PFGJ+yPmhLgyu3TuHkYNWjRsCrN7ESrnX2YHSMd/hh3g90IWthVWXI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CT51BNPHR7AExuryFXvB/HGhM5ULYsSHt/sn9ZNPtZ8=; b=L
 JvHKVtP497op2reB6957GZKVE+QvFEQDuNvMJkaXWIUvCeZ6pIy0SCjdVwTrcLUIpCdvwtmB3iVbL
 Rz7s27/u5SouYDEjKEduJyEQLETesTEIzRA/xwwj2KNDkTba4kP3D/31WdfCwdxl6EzPmhzamHUD0
 uGJt5mNn2Av/4jP8=;
Received: from out30-41.freemail.mail.aliyun.com ([115.124.30.41])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jopW3-00GScx-P4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Jun 2020 14:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1593182375; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=CT51BNPHR7AExuryFXvB/HGhM5ULYsSHt/sn9ZNPtZ8=;
 b=LBHT4NzFhRlSPO4z5CdJu9V8GIwjQEu+uNMvKV0o3veRh8kqgiBKY7PfUTlf2G+PjZiFTR71YNftMzjc3SR9NbKURCDZZGY3sEIJUkE9PgKTgNCxLeXkpRa9ume/J0Eq0FsWap3/1PU+AWiK9vqY0ufAqpLQxDpm80w1RqVg7uA=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4542479|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0307415-0.0160484-0.95321;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04357; MF=fishland@aliyun.com; NM=1; PH=DS; RN=5;
 RT=5; SR=0; TI=SMTPD_---0U0lxSCP_1593182369; 
Received: from localhost.localdomain(mailfrom:fishland@aliyun.com
 fp:SMTPD_---0U0lxSCP_1593182369) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 26 Jun 2020 22:39:34 +0800
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 26 Jun 2020 22:39:27 +0800
Message-Id: <20200626143927.2792-1-fishland@aliyun.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Headers-End: 1jopW3-00GScx-P4
Subject: [f2fs-dev] [PATCH] f2fs: remove unnecessary judgments in
 __insert_free_nid()
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
From: Liu Song via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Liu Song <fishland@aliyun.com>
Cc: liu.song11@zte.com.cn, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Liu Song <liu.song11@zte.com.cn>

The value of state must be equal to FREE_NID, so the if
condition judgment can be removed.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
---
 fs/f2fs/node.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 03e24df1c84f..0adeb20f19c9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2118,8 +2118,7 @@ static int __insert_free_nid(struct f2fs_sb_info *sbi,
 
 	f2fs_bug_on(sbi, state != i->state);
 	nm_i->nid_cnt[state]++;
-	if (state == FREE_NID)
-		list_add_tail(&i->list, &nm_i->free_nid_list);
+	list_add_tail(&i->list, &nm_i->free_nid_list);
 	return 0;
 }
 
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
