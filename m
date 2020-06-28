Return-Path: <SRS0=FBYq=AJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1AAC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 Jun 2020 13:48:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3031520772
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 Jun 2020 13:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="d3BUIbWf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CGD7EaW0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="isU0dO55";
	dkim=neutral (0-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="Fzoe6nc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3031520772
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0ziCJCMzwbVv6VYcavbeRC5F4UehD3OglNlJT1m3RQ8=; b=d3BUIbWfxk4k68zzEHxTyI66X2
	vC0KwEElYnbjYBlhJ2+624UCm6KSbCREIhLvhEUgPLeaKCs1ahKNMDsuLzfbHPkepVUX0kYHDwm0Z
	M8YuwxVctMuUY0YQu3J9Rjh2dYM3bF3/K3it2XQXPrpx/Rd4bOh9FGfFb3u9kVx1QEyQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jpXff-00017t-Nf; Sun, 28 Jun 2020 13:48:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fishland@aliyun.com>) id 1jpXfd-00017Z-GQ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Jun 2020 13:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vUd1Urr5SCdKrWuo7iGRoOZztI0gqlKxcRxR5QYZ0Yk=; b=CGD7EaW06DfQAH7HRXtNFylqdC
 JmlzVIqPqAL1aBq3xfFG/uUu9GNwgaVqtbJb9gVwhW4sAgrEYk7nzXja4hflg6R4eYZ7YU3/7zZxn
 bFxtLGQIs5zqZP6XzowJ5N5z/IHv+5NecwWLPmbei6mtAg5UuGJD1nMZrXs7AfSXbPVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vUd1Urr5SCdKrWuo7iGRoOZztI0gqlKxcRxR5QYZ0Yk=; b=i
 sU0dO55h0aZK1uQHB/bU7ubnsrQQVXsuBXd4IpeedAIVtfzj9zOq75dBzRKUP2PpoGGmYIZwaUTVB
 e15n7YlIBdePHZ0o4X1hgGoLtFLLIrvCMKpDvPWYkSslxputxFtMiNyHRVo5CgCZ2Bv/tYjnZfPP/
 mN/jI142QlZyVwyc=;
Received: from out30-15.freemail.mail.aliyun.com ([115.124.30.15])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jpXfZ-003gsv-JB
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 28 Jun 2020 13:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1593352101; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=vUd1Urr5SCdKrWuo7iGRoOZztI0gqlKxcRxR5QYZ0Yk=;
 b=Fzoe6nc8vpa9mQto4MO892WAvoTQXtUn9jkehYNbkvZEiBNeue7DQwJ2KF4tXyvHsDb5KgHDjVoFNg8twtiDFFKVfRYhc/gB9++S4CIAR3ywpB/QUcFz141imKDXrGrva2cSJFBRt8iyFsL1alzZt681gzd4BLuhmOLASCeHrVU=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1520324|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0867451-0.0754844-0.83777;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01f04397; MF=fishland@aliyun.com; NM=1; PH=DS; RN=5;
 RT=5; SR=0; TI=SMTPD_---0U0vTucv_1593352095; 
Received: from localhost.localdomain(mailfrom:fishland@aliyun.com
 fp:SMTPD_---0U0vTucv_1593352095) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 28 Jun 2020 21:48:20 +0800
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 28 Jun 2020 21:48:13 +0800
Message-Id: <20200628134813.37192-1-fishland@aliyun.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Headers-End: 1jpXfZ-003gsv-JB
Subject: [f2fs-dev] [PATCH] f2fs: remove useless parameter of
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

In current version, @state will only be FREE_NID. This parameter
has no real effect so remove it to keep clean.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
---
 fs/f2fs/node.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 03e24df1c84f..b4f4b0d77553 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2108,7 +2108,7 @@ static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
 }
 
 static int __insert_free_nid(struct f2fs_sb_info *sbi,
-			struct free_nid *i, enum nid_state state)
+				struct free_nid *i)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
@@ -2116,10 +2116,8 @@ static int __insert_free_nid(struct f2fs_sb_info *sbi,
 	if (err)
 		return err;
 
-	f2fs_bug_on(sbi, state != i->state);
-	nm_i->nid_cnt[state]++;
-	if (state == FREE_NID)
-		list_add_tail(&i->list, &nm_i->free_nid_list);
+	nm_i->nid_cnt[FREE_NID]++;
+	list_add_tail(&i->list, &nm_i->free_nid_list);
 	return 0;
 }
 
@@ -2241,7 +2239,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
 		}
 	}
 	ret = true;
-	err = __insert_free_nid(sbi, i, FREE_NID);
+	err = __insert_free_nid(sbi, i);
 err_out:
 	if (update) {
 		update_free_nid_bitmap(sbi, nid, ret, build);
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
