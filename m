Return-Path: <SRS0=+7CQ=U6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A6C0650E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:39:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB8F2146E;
	Mon,  1 Jul 2019 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="k8zLXuJq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="SwQsDWff";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="MPNJ0scu";
	dkim=neutral (0-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="iGkXFe8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB8F2146E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YVK3AVRgxoaEywVame1dRO3bHt5OoyB0w9fHvpxORp0=; b=k8zLXuJq8gNPtCvQm1R8lcI7uP
	4WXTtlejpGOMUYHVMXahjunLY4jwyHvjQOfMbLpz4LwAOnJoMdeijNhcGyEO9D8hAQF8Fyelj5uzV
	6QFxykMUZHgYEooM1F7HCcOqoHylg1jPzifohQWEJwWrQEUsfe6IqsozeMh+0ELgRzh8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hhwWM-0003CA-Cd; Mon, 01 Jul 2019 13:39:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fishland@aliyun.com>) id 1hhwWK-0003Bt-6N
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 13:39:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NhDBj+IJzduC2sRoVUB7MO8fTo6rarQ0gf6B15149yc=; b=SwQsDWfflvUeOmwvuPbswyL3zu
 kFKgCdY5iypFOClWMJAjcuuNTWZJYhbwScFxCcaLCfNFm/5Zzs7PtKEOqca0Drlm+dxlhIq/xSUra
 x9rs4/2miUpFDHh7H6hMco/Q3d3sEWhVMusAVPgr7wVZygZ+FRQ2WPpQX3OWMPL5LCs8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NhDBj+IJzduC2sRoVUB7MO8fTo6rarQ0gf6B15149yc=; b=M
 PNJ0scuShsptwWS6+IXGftTLHJVBMPu5VobL2pwyfFDQFao2XzlKCNOpem6yufo15BzB6UJjbMiZJ
 C0ZO4iI0n0kTIiKB8eaxU8zEjS4n1xgaRy8jj55WnmI4S2nFC4LsJr/vqJPVG9r+Hu8BmQmeFjefL
 01dRF5XeGXuhcuAc=;
Received: from out30-38.freemail.mail.aliyun.com ([115.124.30.38])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hhwWP-0039Zy-7a
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 13:39:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1561988337; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=NhDBj+IJzduC2sRoVUB7MO8fTo6rarQ0gf6B15149yc=;
 b=iGkXFe8ktZtXy0e96YwM790ul2ajVDSvb2Xh77TNto/5Ro2d8rZN6RfsUdKkBQdhqG8gfKfggS0jYfcFsbAC2vWpWC7VoUk7NZOdPzutwLoWIQFWHtERuHkDN+EFiLDaLcDWwmTJQwGfN2OIPMY4AkYPPiS/bpjKOc+jlHMRFQo=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2725081|-1; CH=green; DM=||false|;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e04426; MF=fishland@aliyun.com; NM=1; PH=DS; RN=5;
 RT=5; SR=0; TI=SMTPD_---0TVmzCoM_1561988324; 
Received: from 192.168.42.134(mailfrom:fishland@aliyun.com
 fp:SMTPD_---0TVmzCoM_1561988324) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 01 Jul 2019 21:38:55 +0800
To: jaegeuk@kernel.org,
	yuchao0@huawei.com
Date: Mon,  1 Jul 2019 21:38:41 +0800
Message-Id: <20190701133841.3201-1-fishland@aliyun.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Headers-End: 1hhwWP-0039Zy-7a
Subject: [f2fs-dev] [PATCH] f2fs: use multiplication instead of division in
 sanity_check_raw_super
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

Use multiplication instead of division and be more
consistent with f2fs_msg output information.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2cc21b8..eba4c0f9c347 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2489,7 +2489,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return 1;
 	}
 
-	if ((segment_count / segs_per_sec) < total_sections) {
+	if (segment_count < (segs_per_sec * total_sections)) {
 		f2fs_msg(sb, KERN_INFO,
 			"Small segment_count (%u < %u * %u)",
 			segment_count, segs_per_sec, total_sections);
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
