Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B63C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jun 2022 22:46:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o2hD2-00059A-R1; Sat, 18 Jun 2022 22:46:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1o2hD1-000593-1v
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 18 Jun 2022 22:46:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ADJj4uPeh8NPNr6TJh2107as2KfTTMkqG+G41+Lb5mA=; b=gjVFZzJLivDSxXbp9jcD+vR3By
 yQ9+DwbB56VH761FNib2p8DzGUrup8qgn3o5HwhkWBI+04XujoW8xyQIy0z2PE2TXR8g10QaJqBfi
 dgfkg50dMRjBMj5Aak8GHqDlNj0rRoNqUZhjWShpk94BvS9cL4Hqa/Gyn80OHgegSaN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ADJj4uPeh8NPNr6TJh2107as2KfTTMkqG+G41+Lb5mA=; b=F
 XYzJOXagBICzWws8y/tBGbz9tLCdvFvQNQBfnLnlasFyhytCWtm6Da1ilJjYZgvLFdmfxEf3vTXdO
 tlSg8ZqWsRvYu0/EFxuSIa2HzJXGRw7Y8EhblSYcxeq9d5+RmhW5Xs1njsiPF/POIA0ZnLQDfJr2S
 6t2k7AxXSLw4hu50=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o2hCz-006jRs-Oz
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 18 Jun 2022 22:46:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 01A92CE08C7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 Jun 2022 22:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A14C3411A;
 Sat, 18 Jun 2022 22:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655592369;
 bh=V7chkL2A5m6qQLgPvjeycpUuzNA+cLG9L2qrqHYLUSg=;
 h=From:To:Cc:Subject:Date:From;
 b=F29zOKh+AdueVTj4VXMYrX/smopNogx5c75t0KuMKQ1eaBz2c5o0eD+vjXtb9XN2j
 VKlbYcFrjCrt0+ML7E8sRmaflzz27K1dWapfGzQhzLwIVbt4tWiXFUuCPBz3RniR9Q
 ySQu2lNEEwlut7osVxn7csDmMLqZa1gKsjalUC6WPvKHWVv3F2W+YHjIocuf5gPmJl
 UVwmWG8Q5Y2iOzTqRAwNsB/K5claNV7Rk1TnLjwO0ORYhoRrR/5aX20lds/zcIUDXd
 D1XECy9bF4vihzSxa4QSzLerg7NFbHcCqxZN2TtaNSP1/2g92FXIP1Uu2FO4r13IbC
 Og7SnABFnTDFg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 18 Jun 2022 15:46:06 -0700
Message-Id: <20220618224606.1554706-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
X-Headers-End: 1o2hCz-006jRs-Oz
Subject: [f2fs-dev] [PATCH] f2fs: do not count ENOENT for error case
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise, we can get a wrong cp_error mark.

Cc: <stable@vger.kernel.org>
Fixes: a7b8618aa2f0 ("f2fs: avoid infinite loop to flush node pages")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4181d03a7ef7..095a634436e3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1450,7 +1450,9 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 out_err:
 	ClearPageUptodate(page);
 out_put_err:
-	f2fs_handle_page_eio(sbi, page->index, NODE);
+	/* ENOENT comes from read_node_page which is not an error. */
+	if (err != -ENOENT)
+		f2fs_handle_page_eio(sbi, page->index, NODE);
 	f2fs_put_page(page, 1);
 	return ERR_PTR(err);
 }
-- 
2.36.1.476.g0c4daa206d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
