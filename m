Return-Path: <SRS0=CR9S=BQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF2C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:44:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9443D2177B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="NeHPd1qt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jRjAmPTH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dH6aWNxg";
	dkim=neutral (0-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="kCaG4tMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9443D2177B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7v3/73/1FA4WTrgWMPdn0vH2ikonbwoylB6SYI0YT20=; b=NeHPd1qtbkU8Aps2qSDDvItW6b
	g9PSnSUjJqpz7inNh77ee1aru9C4mBXCI8ixMx1g34/Gnwepx3cne+g/igv6PS+rGIdK7shVYedZn
	AJn1dS7CcxXwDQwOV8aVlcGcmatijNP3TqWP8gbyFDQjQVRSEnr3Nl6WJl/72fuUPuWc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k3i4C-0004qV-3Z; Thu, 06 Aug 2020 15:44:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fishland@aliyun.com>) id 1k3i49-0004qI-RR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Aug 2020 15:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mq0PLdHuUhsdLPy84DKhxWUpdkOd9pLaT9kDHiohl1g=; b=jRjAmPTH5Ej43UaPwVc3Glw/3v
 nrThI7swedtdThK9PHjU0L4+jq2queOO5iN/6C303+V83HvruQp7UQAXUxYn8sUGDJv+LnQ5kXtPv
 q6Yh+oickC3mikR6ceyFmXYm/d7hGfawjOQ7P8c9RPdeeRwBJpkAukcYQSAOVqsEwbdw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mq0PLdHuUhsdLPy84DKhxWUpdkOd9pLaT9kDHiohl1g=; b=d
 H6aWNxgX1Hs7B00bcoeXqqkZNJWBMBL6fRmH3w/K1OzEvEDqwWlgwvTy1LAX48vNavMkxRLKtA3IU
 gGOAY85f6djsP+DT2MUfjDi7AqLRNcwt2vPp8YWd14u6vF6RPC3cQYQW0ydz+XffZEO9odlXGf3nd
 IMEGosvQedSh2ZP4=;
Received: from out30-17.freemail.mail.aliyun.com ([115.124.30.17])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k3i47-00011F-N0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Aug 2020 15:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1596728655; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=mq0PLdHuUhsdLPy84DKhxWUpdkOd9pLaT9kDHiohl1g=;
 b=kCaG4tMDCWgH6Q3TTFdJCimttDWO/BGMBKTJt37BNu1NIJs7xhmwy5lO/IHojI6HkoKKbSoKzg3X4kXbDi2qVWKsoAvcfzW9M1CcyyDDqMviTAf/tM77aQRRrkJctAkOMd9ltoOKtlOsJKw/F8fbKP42ND3yHEDGGAG4YKk5NnE=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09460482|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0594221-0.000428066-0.94015;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e01422; MF=fishland@aliyun.com; NM=1; PH=DS; RN=5;
 RT=5; SR=0; TI=SMTPD_---0U4ws2.C_1596726201; 
Received: from localhost.localdomain(mailfrom:fishland@aliyun.com
 fp:SMTPD_---0U4ws2.C_1596726201) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 06 Aug 2020 23:03:31 +0800
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  6 Aug 2020 23:03:17 +0800
Message-Id: <20200806150317.34618-1-fishland@aliyun.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Headers-End: 1k3i47-00011F-N0
Subject: [f2fs-dev] [PATCH] f2fs: remove unnecessary judgment in
 f2fs_drop_inode
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

Inode hash has been removed in "make_bad_inode". If inode_unhashed
is false, it must not be a bad inode.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 20e56b0fa46a..ee01d15effe3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1043,7 +1043,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	 *       - inode_wait_for_writeback(inode)
 	 */
 	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
-		if (!inode->i_nlink && !is_bad_inode(inode)) {
+		if (!inode->i_nlink) {
 			/* to avoid evict_inode call simultaneously */
 			atomic_inc(&inode->i_count);
 			spin_unlock(&inode->i_lock);
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
