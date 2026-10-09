Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B61CCA6018
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNuPVOThW/+/67qs7OH6T3lYKCLLuJhXvq4Rk8V/i4w=; b=hNf2WPLyB7TpjvKpT6a4veeVu4
	vc7dCKeyCteFp4rv36LRXBSSiKxFW8k5YOErof2cFZUVWa49cPa6OnTlyQfY5Gpav26ucFLgo+IpN
	ZWOMqCutZRHRGsQ7FbdC3vye76LXo/fx7ju69+c0CyiNcYHT7J499gDqn3ecDeguZCzI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF8fm-0005wr-8m;
	Fri, 09 Oct 2026 11:21:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF8fl-0005wk-6n
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 11:21:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vVjrHJKa7rDFUypv5UxZTfsmJ51mWGgTIxM/zhOP14I=; b=RoRF3jhBfqFpkIUig64smO1372
 Tb7t5itUKMsrcXl0LCJA7CqktLYfLLZpGM7UH8O1oqUWQ59n9Rw+MUJKLu3Yc48hfRhvs+xStf2Ik
 ahrYXgUCu79OWbSNUTEmPhatBGKTRCre3c215op0Y5pv2rVhSiYOM8SptgLWjT2sHhFQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vVjrHJKa7rDFUypv5UxZTfsmJ51mWGgTIxM/zhOP14I=; b=FoMVHNv8VP0qhzprOtgii7E8hE
 nOI7w/wzsE4LmLhuCmv91IXvIjmfcVOj/BcbYktp3q2+dcS3TqmHrwFT8Elb6+48rMOLchsBUEiyu
 fgB4MJnB2D6oPoEO2FPPc/REYZfBY+um/tjsSAD8ttc7Wy98e1u793RpXhdrzoalox6A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF8fl-0005bS-GV for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 11:21:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5ED960534;
 Fri,  9 Oct 2026 11:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1A41F00899;
 Fri,  9 Oct 2026 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791544911;
 bh=vVjrHJKa7rDFUypv5UxZTfsmJ51mWGgTIxM/zhOP14I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kl6aShrmB76Cbp98XLihU/AhoJdIH3oM8O2JNFK7TWZMBfQYIbwB5qQ6J+eFpQ2D1
 rNUArTtrC4hrV94Zhq3q6XcZbFsMMnVGrQK7fyyXiHbVZBvhdxc8pILkn6EB7a9zBM
 GiceKpvsZP9VRC6bVYVlSXVeQ8n98JQw5eEy2n38CJ3RaC5Ch2pxpS6CZYEDoanVVc
 UsZNoc0vpVy9iVSbbWFodbNw2UCIOLkNgONHCPugd4ZzrApaSIj1xJU1I0gxoW0pJI
 Ofq0tZaH/fyek7ncT0BvAsY7Wotfa4QuKKSeNlBKJFTeLxnXgk5DP4aFljA0vEfHYm
 zck9sK+nnBeUg==
To: stable@vger.kernel.org
Date: Fri,  9 Oct 2026 11:21:40 +0000
Message-ID: <20261009112140.2275137-3-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009112140.2275137-1-chao@kernel.org>
References: <20261009112140.2275137-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xF8fl-0005bS-GV
Subject: [f2fs-dev] [PATCH RESEND 6.6.y 3/3] f2fs: fix to reset all pinned
 status during fggc
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ]

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8a37461fc278..8a4395bfeff6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2064,6 +2064,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 						dry_run_sections == 0);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			err = -EAGAIN;
 			goto next;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
