Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FA2C3DA6F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Aug 2023 16:08:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZCt6-0006rR-7r;
	Thu, 24 Aug 2023 16:08:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1qZCt5-0006rK-7a
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Aug 2023 16:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mwl7q1yPOEcXF73xF3to8HfIIGKX018FgBcknfK83RE=; b=NVpWd8o2Mj/LgxnCh5Svi4Nity
 /KoOtTCulc2nRM155e5tlXjwe74WXe8AVxYzOXom+fpR0DTQwiXIlpJd3F1+LMkW7mhKrbACxiKpB
 dta8p3P6e24nQVrv7TvFz+kgivbyA2WROffy1IgNtYjnE7VGwIDHzuGztC45MSI++ChU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mwl7q1yPOEcXF73xF3to8HfIIGKX018FgBcknfK83RE=; b=B
 FOwhL3xOMOnnIu0kNP4Xn3mL5jWKRKBcQggJ8yKooUx1D/x7V7GUL9pVNyXoRoVTaTSVXz5sf/ukW
 iP1GGwf8fsCmy5x3mBDywz/4uCJS7YoH5oU38c8qnM1TYf4g6/fs/OsHdN2WQLA0dozyG/bAMQSe1
 do7kqBq5DP8SZx3s=;
Received: from mail-il1-f180.google.com ([209.85.166.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qZCt4-00EPcK-Rm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Aug 2023 16:08:47 +0000
Received: by mail-il1-f180.google.com with SMTP id
 e9e14a558f8ab-34baeb01942so23094855ab.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Aug 2023 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692893321; x=1693498121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mwl7q1yPOEcXF73xF3to8HfIIGKX018FgBcknfK83RE=;
 b=I1/T4RTD1WGrxc97G5vu4JwTSp917FtOlo0CqDDG3+i6LwOM/8n104SaMp2tAnvr+q
 KIkpZ7sUcDy62PT5VjM/+KVCz+i5nlXRBa1G6LlUTE6WbEx/9v70ZjD+S0OIc1BY6H+i
 jjuA9GG30sKqDwbxb36E6A77mVf+8lp1umaAmuZEv4CaFeDCGhu2sqqVaL1WqrKftHmn
 Ad7bkCDIXjob14zMX7uhEixZST3vRvRSEfpjiPKYCkIIOTkbxbl91IT7oCFNtLGLCKJE
 YpZ3GfJOt+Hr47oXdj3eurCSV4hgAa+74uQl6XhLkF/Gh6fG3Ciqci86Eyg9TNHJfCvl
 iQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692893321; x=1693498121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mwl7q1yPOEcXF73xF3to8HfIIGKX018FgBcknfK83RE=;
 b=Kln6Xmz/Fq4x3Ez2O8opE++YYJBZhuXWr71ox//+oBMcADPlWJxIMQxBey3wvM51CG
 57dow3FEIXPuu7TQ8ubtHTGvuJEpHWBs0P7KkTv3L/XGNcPh+iKu0lk44f8hdOBKnFp7
 CfawI0sD2AUfvXR71FZBVc08W8KnY5t92FCkGl9EpACR62n61aQJVTFFpqWYH1ry9tqr
 iupsnYtGp4JgdfHzz6V4GFNs3V9IjUjM+cAzyXu26Fz79g2WVKiWepiOBzc3a8FNlnOq
 AAtR+hDEyyXzE0J5inRQY2qBdBNKazCcqyghU+fzjWl3PSnBR1onFcYurouncpLPwerK
 EXXQ==
X-Gm-Message-State: AOJu0YwjeSRd03ZqCKPw3XIVURHoIhS9WYzecTQMmU4LSpndcivsOL/q
 R3apBJHPpCgowl6DiEvCaHA=
X-Google-Smtp-Source: AGHT+IGBcpwaFEsAg0jmQmnsciZ7Ss2OB5wbWgSqSzaLeCDbd15m13wj5d2RKi3X+7boqWqXGLtEGg==
X-Received: by 2002:a05:6e02:1ca8:b0:345:fae5:666c with SMTP id
 x8-20020a056e021ca800b00345fae5666cmr7377252ill.4.1692893321078; 
 Thu, 24 Aug 2023 09:08:41 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:6826:ad3e:88eb:ebf3])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a639209000000b0056946623d7esm11741234pgd.55.2023.08.24.09.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:08:40 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 24 Aug 2023 09:08:31 -0700
Message-ID: <20230824160832.3195155-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
X-Headers-End: 1qZCt4-00EPcK-Rm
Subject: [f2fs-dev] [PATCH] f2fs: use finish zone command when closing a zone
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Use the finish zone command first when a zone should be closed.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b38bf2b34490..d05b41608fc0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4948,12 +4948,19 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 		    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
 		    wp_segno, wp_blkoff);
 
-	ret = blkdev_issue_zeroout(fdev->bdev, zone->wp,
-				zone->len - (zone->wp - zone->start),
-				GFP_NOFS, 0);
-	if (ret)
-		f2fs_err(sbi, "Fill up zone failed: %s (errno=%d)",
-			 fdev->path, ret);
+	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
+				zone->start, zone->len, GFP_NOFS);
+	if (ret == -EOPNOTSUPP) {
+		ret = blkdev_issue_zeroout(fdev->bdev, zone->wp,
+					zone->len - (zone->wp - zone->start),
+					GFP_NOFS, 0);
+		if (ret)
+			f2fs_err(sbi, "Fill up zone failed: %s (errno=%d)",
+					fdev->path, ret);
+	} else if (ret) {
+		f2fs_err(sbi, "Finishing zone failed: %s (errno=%d)",
+				fdev->path, ret);
+	}
 
 	return ret;
 }
-- 
2.42.0.rc1.204.g551eb34607-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
