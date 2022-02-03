Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A53FC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Feb 2022 14:47:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nFdON-0005B8-HK; Thu, 03 Feb 2022 14:47:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nFdOL-0005Ay-TF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Feb 2022 14:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BNRatYWjQm0fcsUYBvNGaWTgGWFUxP84PzInbvdppyc=; b=eq5ztPOdhCafb9HtdwDH77cvUb
 BpJH2Pu3TpuLTzsTrnsTNaNmoiD5tzxFGH1r+bnN+HiTt92WpP8fkZZ/F3oshvRGZmGmpl/kbrDIO
 LSX32J1JVoJ4U0SFc6xZTmypUHG+08kym8gB0wi/2pOLnZqpQQcCdKPcLmP6VQ4UdX9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BNRatYWjQm0fcsUYBvNGaWTgGWFUxP84PzInbvdppyc=; b=F
 s3zDfiwrGfhldR4spyYassoj/zxe+PV0C2iINFlZFMDbDewDJW0TC1Qi7yQ3c0EPs+Er0cXxdQ6Wm
 mwGHL/JYk282J/aGdpAQSqcYHZ2b3zC18P54XSbTRsTXqxjQzpxGo8705mWM3205BNR4Im2yzj3Md
 UBo0NokNCLgVI5po=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nFdOJ-0005hU-NB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Feb 2022 14:47:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5C79FB83475;
 Thu,  3 Feb 2022 14:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07328C340E4;
 Thu,  3 Feb 2022 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643899632;
 bh=HsISUCVfu1iUw1BVQ2l4vNJsgdtVwJ6qtpiQzSoC5as=;
 h=From:To:Cc:Subject:Date:From;
 b=SK+mkJx8u6S8ZgT7OW2Z+bbqatlwui/sMuRXvTn6ItzkjyGHBZZXJGwxQSfs79287
 z+0aMg+lHj6gIMkdfG3T00Mvj24b1fUaiKxzlEi2/Ofb99QMM/W8djmhMJJDR/tfSZ
 xdaFCLaA/RQcdQA5F+vMSmDWl7eEGMcldz6zue4UBaw+QBserFBtEDyy93q/liRIZh
 yqie5ayExS+KmGqJs/EZpCCJG4++VpR9jWXofTJtbvPOEIVzIemit9xaG3mIdoN2op
 0d1W67+YeDui5rOfznX876bXylj14gVZAZJJgg/MoSGLq5bvnjUmUOxyFPT2rk0tA7
 bskTm/wQJoM6w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu,  3 Feb 2022 22:47:05 +0800
Message-Id: <20220203144705.23528-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1nFdOJ-0005hU-NB
Subject: [f2fs-dev] [PATCH] f2fs: fix to unlock page correctly in error path
 of is_alive()
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
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As Pavel Machek reported in below link [1]:

After commit 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()"),
node page should be unlock via calling f2fs_put_page() in the error path
of is_alive(), otherwise, f2fs may hang when it tries to lock the node
page, fix it.

[1] https://lore.kernel.org/stable/20220124203637.GA19321@duo.ucw.cz/

Fixes: 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0a6b0a8ae97e..2d53ef121e76 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1038,8 +1038,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
 
-	if (f2fs_check_nid_range(sbi, dni->ino))
+	if (f2fs_check_nid_range(sbi, dni->ino)) {
+		f2fs_put_page(node_page, 1);
 		return false;
+	}
 
 	*nofs = ofs_of_node(node_page);
 	source_blkaddr = data_blkaddr(NULL, node_page, ofs_in_node);
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
