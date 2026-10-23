Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8516606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y7K1/ZH0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MUFqcC7u;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BidO8ZwU;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JylwvKDt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0wWwXdzelXGBWlE57HYa/wYsGFPItwUqYM3aoWptKYI=; b=Y7K1/ZH0c3A5FAvORLgOoMQgnW
	VMTUlkJr0f60i5H0qlBz5mM5BCg1KBhFFYZteaXCa1JmRLk5GAEfMdnlM3vOhP/64RBFWXLNV31+c
	GfFA0N9PGFchaVm6Lx/MODxdVbWsUMW1yisL7/fYwSMf2VYk03+q7hnl0vEtoctwXt1U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKEUh-000000002U3-1zv7;
	Fri, 23 Oct 2026 12:35:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xKEUf-000000002Tx-3wUT
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:35:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=spOSuW5P2q6xG0pxXVZvFLkoEd4KzyUD5oh7Qd+Zw3M=; b=MUFqcC7uHbjUzS4K57VhmSEwb8
 SFFxkdDhCAJrLWWYhnWUG0uFhaZpkOJEIo8eoLL9B8dxe7fmIWCexpUJOYveD+ZfvMZML6Nhqa0nj
 dy/P8tXFIeWXAXb2fxaQGj9iEHrnosn64WlxJqjhB+DdSozWzcMW/6nUjFcLNCGc8nP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=spOSuW5P2q6xG0pxXVZvFLkoEd4KzyUD5oh7Qd+Zw3M=; b=BidO8ZwUwXmeFZjHDd0nlk/IU6
 07Yy0U2rGOwTSJbui487wgjBOHnyHDjfk7u+X1QBE2YhfgS52ZGQSuCda7x9zQyji5ZpHtCC6xyBz
 Ukb/U6QNZ8O/+xwf9LyHtDaaSIX+FeBpHu60bNRCTZkPrKLp/XBhUH2gCCXjuOtyNVRU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKEUd-000000003qR-1Vsj
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:35:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B79A160142
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 23 Oct 2026 12:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950231F031E1;
 Fri, 23 Oct 2026 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792758925;
 bh=spOSuW5P2q6xG0pxXVZvFLkoEd4KzyUD5oh7Qd+Zw3M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JylwvKDtOuXmgZ0xoyROdETXUBSW7G+tATPy/OgCUwr9iTryqhiFwJpg7/fdS2fgQ
 Nhq74DONcSOCpCaXJ4Ey/XwSW09z3kkjDglHgnlsY4ZpsfC0gxe17VsZZQ6GSVV7Wo
 LsiMPQ02+h7UuXg2xyUAgn4KKxIuqoDPo8cjjnFZc7MxS+xVoKfw/7Mpgfrp/Jre33
 Yj8e9p/hhhvnwGbT+cjYGmaqkJgTY0brz2L7TqSV/nx0xuZ3mCrljanvbEfWhgHV3s
 Q3xrQLRsSPgiwcIjXS9F7hT5mSIUjMcyNEdYvs8iYrlCepwSK4ejt06ly1vLQ2teLt
 syUXlwFaKzKWw==
To: jaegeuk@kernel.org
Date: Fri, 23 Oct 2026 20:35:18 +0800
Message-ID: <20261023123518.504064-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261023123518.504064-1-chao@kernel.org>
References: <20261023123518.504064-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xKEUd-000000003qR-1Vsj
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to call f2fs_commit_super()
 correctly
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

This patch fixes the bug reported by Sashiko:

We should call f2fs_commit_super() instead of __f2fs_commit_super() in
sanity_check_area_boundary() to update chksum valud along w/
raw_super->segment_count.

Cc: stable@kernel.org
Fixes: d440c52d3151 ("f2fs: support superblock checksum")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b321b9cff351..da1e4bc8a64f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4090,12 +4090,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 			res = "internally";
 		} else {
 			/*
-			 * __f2fs_commit_super() will access log_blocksize
+			 * f2fs_commit_super() will access log_blocksize
 			 * in SECTOR_FROM_BLOCK(), init it in advance.
 			 */
 			sbi->log_blocksize =
 				le32_to_cpu(raw_super->log_blocksize);
-			err = __f2fs_commit_super(sbi, folio, index, false);
+			err = f2fs_commit_super(sbi, false);
 			res = err ? "failed" : "done";
 		}
 		f2fs_info(sbi, "Fix alignment : %s, start(%u) end(%llu) block(%u)",
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
