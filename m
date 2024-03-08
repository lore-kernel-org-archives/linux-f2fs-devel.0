Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1860C5475B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Mar 2024 10:13:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1riXDw-00081O-99;
	Fri, 08 Mar 2024 10:13:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1riXDv-00081I-B4
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Mar 2024 10:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZmqGTA1O5hIrbBXEdx0MrBO9wv8Md09XBJjINf6MQ+Y=; b=eBXMEx7pIMAoGLWTp+kdYB82Rk
 f3vhAehPHfcDBrycL6AHnWtLUTgXez2i/EC+dJ7zoplxiYdWoOQFg7NkhMVABoiO3SmfIiyV/dyem
 Xs6XVaP0XbZr+I/+BRDU2kTH1lPQIJAjm9wwBrjq7db+eV+afVpbcMxa/4t2sZyKzDxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZmqGTA1O5hIrbBXEdx0MrBO9wv8Md09XBJjINf6MQ+Y=; b=U
 H3VvPBERVFBZTNgvY22B4QYn2uF9G/qnWSun5Tx5bMN2hif/TvG0ZFVTuSBW2xMhQo3wG71Oz/Ow2
 vAj8C8mo9nNnJrtbk2RJXrcjb+Ascjwcmo9DccZtAtLd17qAHFoQgivS/e2hcsS6X/kN4vDLGyafE
 sPCQWPYy6SRoyzc4=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1riXDk-0000uv-2R for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Mar 2024 10:13:07 +0000
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTP id 428ACbu3067848;
 Fri, 8 Mar 2024 18:12:37 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Trhll6Yxwz2L3SH2;
 Fri,  8 Mar 2024 18:11:31 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 8 Mar 2024 18:12:36 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Fri, 8 Mar 2024 18:12:32 +0800
Message-ID: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 428ACbu3067848
X-Headers-End: 1riXDk-0000uv-2R
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix to remove f2fs_bug_on in
 add_bio_entry
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 zhiguo.niu@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

add_bio_entry should not trigger system panic when bio_add_page fail,
fix to remove it.

Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/data.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5..f8ae684 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -759,8 +759,10 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
 	be->bio = bio;
 	bio_get(bio);
 
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
-		f2fs_bug_on(sbi, 1);
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
+		bio_put(bio);
+		return;
+	}
 
 	f2fs_down_write(&io->bio_list_lock);
 	list_add_tail(&be->list, &io->bio_list);
-- 
1.9.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
