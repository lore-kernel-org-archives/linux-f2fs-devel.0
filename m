Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C945606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 00:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CTMXF3uJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kvVSQbjI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a7Qayvjt;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jLjbuTlq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=guNmNgLMMS1UXr7+3WEX9RK0mHIK5Hx2/EMxMETsoAs=; b=CTMXF3uJ8K2p/Ul6lA+JaWjeA/
	bf567TlodbU1hFEBWicYxiMdmEd9Q4gzhnlExC3s1XQtKYCkGWZLLp8dbGXm6U7hoTuM662QZoKs2
	PSJZGKSjbE9L737ujy9eABWIUD+bKJdhaWcFwlJ+DVbwpF7To+Xl7yg0Zll2iV7DfsP0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xL8Vu-000000005oC-35dg;
	Mon, 26 Oct 2026 00:24:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xL8VR-000000005nn-0UB6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 00:24:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N7nzB2KLuRZYRlbVOXc3Qao54Dq78/8OeGxh0TxfAxY=; b=kvVSQbjI9z7f2pzzbRB0kgB/g4
 iNNxkb01rcUVM3YJhMOe2seRM2d5iKa0a2GGfLQFUamei3kzrSloVOkjZFNMJaJc2Lg5tiFzuGfa/
 jIdteCqZptjxTjeqjH4m4TybnUACikz5oUxz3VxpiAui4we5o7whufNI9x46cQYUDdmo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N7nzB2KLuRZYRlbVOXc3Qao54Dq78/8OeGxh0TxfAxY=; b=a7Qayvjt1zafmBXXBHjCkohV3l
 DzI6uRS7E/zej8ao8xNifVQqQQLRe4k7dKOIw4ZlFOVeBhVX9fjPO7FIA681Os5rfda/2RdFP+SBt
 sSEOZpaEeruyClukb9rpIvOMnuiqh2sikr4kllriUNaK/TovWg9jDG2Lk7CYYcw7G8fs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xL8VQ-0000000063L-2SIc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 00:24:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6F0E601DE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 00:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E1E1F031E1;
 Mon, 26 Oct 2026 00:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792974238;
 bh=N7nzB2KLuRZYRlbVOXc3Qao54Dq78/8OeGxh0TxfAxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jLjbuTlqNsP8WS3AfJmvbRmkSbY3/bhF0hzrQsK3DCmMZqf+oFaoWO7PrdaabJTZI
 kJEuSi4EhUK2NYCS6epjZyapgZYQqMSQjLUG/8zHEwJMhwhimOS+x0Y2f5gRglkqb5
 M8yjujt6+dCjv+tWxYkGatMg/hibSiEuVj6xZ+vyzIDItJPGthnQilh7ThUraJp5ia
 M9JdSEPPSjTxLeXcKfjNa3ILqvFKYD/Fprp8/uBhel4DWh8+roTst9mgYcVPq3sVuv
 IGStQulby6QtVmjGfYIKKdICTo51AAyfeH4Nfokx1jVtSwHTHOPMeNXeC6u5X6QYTE
 cozOG2v5IMz1w==
To: jaegeuk@kernel.org
Date: Mon, 26 Oct 2026 08:23:50 +0800
Message-ID: <20261026002350.1451587-2-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026002350.1451587-1-chao@kernel.org>
References: <20261026002350.1451587-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xL8VQ-0000000063L-2SIc
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: fix to update superblock crc in
 sanity_check_area_boundary()
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

We should update superblock crc along w/ raw_super->segment_count in
sanity_check_area_boundary() if sb_checksum feature is enabled.

Cc: stable@kernel.org
Fixes: d440c52d3151 ("f2fs: support superblock checksum")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- update crc directly in sanity_check_area_boundary rather than calling
f2fs_commit_super() which will access NULL sbi->raw_super.
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b321b9cff351..37d208c6bb53 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4084,6 +4084,12 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		/* fix in-memory information all the time */
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
+			__u32 crc = f2fs_crc32(raw_super,
+					offsetof(struct f2fs_super_block, crc));
+
+			raw_super->crc = cpu_to_le32(crc);
+		}
 
 		if (f2fs_readonly(sb) || f2fs_hw_is_readonly(sbi)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
