Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0183CC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 May 2022 07:14:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nogYM-0001XL-Cu; Wed, 11 May 2022 07:14:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <fengnanchang@gmail.com>) id 1nogYL-0001XC-7l
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 May 2022 07:14:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J3+mzN/w8Mb86jzbBYeEf82naYxsdfh5F+BTNwPNzio=; b=C+dyUFloOrPbeW8AzVLmqvE2gO
 uAQY/gk8atDXX9P0whGFMHaFFJBm1EkVIVvd8MfxU4NhAeKeTfzGA5EYxohe90aDwnGYTPNkTzo6t
 mGfVD7YEMO1uxI/Qc6Es+EYMWT9LU9jkn/jdSCpzFPD5gJ9IloFHL4VLE6VFCOUF/hn0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=J3+mzN/w8Mb86jzbBYeEf82naYxsdfh5F+BTNwPNzio=; b=D
 gBLvFYJ0B0lTt/QztKDyXFh4oJ6o6ZwSQC3SwINmx8KR1noUupyXR6WgjD9g/pOevB5cUsX7R5UYN
 xYXoRRVxvWCLVCvTn7fM1ldroWLwFnj6KX1k+qwH3mCY46cYPQ0z8JhYJVigmevOtqI06iW8HfcwS
 HMfPPuiCBQIPo890=;
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nogYK-0005cY-Vw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 May 2022 07:14:33 +0000
Received: by mail-pg1-f178.google.com with SMTP id s16so1038696pgs.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 May 2022 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J3+mzN/w8Mb86jzbBYeEf82naYxsdfh5F+BTNwPNzio=;
 b=VMJZK9BV8jSs9q95ZrQmbxvRCtGUKLoaWWuNtfzF4aB5reNCOgozYj0MuaIl2ZpRVN
 j68014kU44QIrCmpJXSxzVhj45jCC+jxUVGM2sLzf0wxE9RxtN6FqC23r4t2BNLMeNtF
 bo5bDLrQF5I5L5v1AV3XQrerJ4g3t6xuRJx1miKDWtznJ+LT4wXnD+kwBqWqsw/uNI9H
 YFnCYuTvxszUC2GElif6RFdZHXtnCPGflElRqj99YRf146VXvEY5rUxyEgTzYb8Y1Oz7
 bl7GcEuVChspREhNPFPWmGuxN6H8vvbRpEXRYMBolflkBIY1ERJxVcowyrfZ2zWHB4Gr
 /jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J3+mzN/w8Mb86jzbBYeEf82naYxsdfh5F+BTNwPNzio=;
 b=wEsRE9FWVM6qDcSTA03yIv3BRsjxJ9MoFT6IMU4XIjLgWJZMeq0Rziuv4GlkyvH0dM
 /UVxeVysgvkINao89vge6f2ZaqpJL/Y/L65YW/O+zOZYAPq+0/ftlz0cB1lkPWKwefNR
 yEeQMXkcyupIwEYQPEl4wMC0w5CG4wQ/6Wlz1WLq2oCH3BwgaS2zLpxPccHhcwX9EdNm
 PSU3d51Hlxzpy9JwQ7G7H7ROm/L3yVDzlDcACWILrlt4NuNKFkhhcUeIxAW2lnd5T+H6
 dxvV7AiOqRVzPD4V5g3XBgBYRmrbfbhsP/XK3j4lQ7Uw+Y66lmk+pL5YqQv+N4mtVwDn
 wQ8g==
X-Gm-Message-State: AOAM532UAd/jaIPaAe9lew1XJOpdbRMyBeWvLdmJ5HHrHEBPFZZnA+Ts
 HUR0s8t/n7Sy0btiujIWYtWGhT04itfEGw==
X-Google-Smtp-Source: ABdhPJx9CayYHwofW8ggQCY6Ntkl1cXBYuykUVjD8WpzIlkE5RS2D1tVCb+oY//ctu7i5Q22xsadxQ==
X-Received: by 2002:a63:f0a:0:b0:3c6:e825:2431 with SMTP id
 e10-20020a630f0a000000b003c6e8252431mr6445312pgl.166.1652253267127; 
 Wed, 11 May 2022 00:14:27 -0700 (PDT)
Received: from localhost.localdomain ([103.167.134.175])
 by smtp.googlemail.com with ESMTPSA id
 s16-20020aa78290000000b0050dc76281cfsm801167pfm.169.2022.05.11.00.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 00:14:26 -0700 (PDT)
From: Fengnan Chang <fengnanchang@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 11 May 2022 15:14:19 +0800
Message-Id: <20220511071419.100386-1-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1nogYK-0005cY-Vw
Subject: [f2fs-dev] [PATCH] f2fs: fix hungtask when decompressed fail
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When decompressed failed, f2fs_prepare_compress_overwrite will enter
endless loop, may casue hungtask.

[   14.088665] F2FS-fs (nvme0n1): lz4 decompress failed, ret:-4155
[   14.089851] F2FS-fs (nvme0n1): lz4 decompress failed, ret:-4155

Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>
---
 fs/f2fs/compress.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 12a56f9e1572..6a65443fd9b3 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1060,7 +1060,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	sector_t last_block_in_bio;
 	unsigned fgp_flag = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
-	int i, ret;
+	int i, ret, retry_count = 3;
 
 retry:
 	ret = f2fs_is_compressed_cluster(cc->inode, start_idx);
@@ -1120,7 +1120,12 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 			f2fs_put_rpages(cc);
 			f2fs_unlock_rpages(cc, i + 1);
 			f2fs_destroy_compress_ctx(cc, true);
-			goto retry;
+			if (retry_count--)
+				goto retry;
+			else {
+				ret = -EIO;
+				goto out;
+			}
 		}
 	}
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
