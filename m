Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707A2C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Apr 2022 21:18:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ni0fz-0002jc-KV; Fri, 22 Apr 2022 21:18:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1ni0fv-0002jK-QR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Apr 2022 21:18:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T150FBHbGleIB5mrb9HL3szXKTUr2956ZFtpCqxsPgQ=; b=UYdWfTlVxAesZ9NDNt8Vc4xy4J
 D/v8K26tKxzLJwd8i/uvO6I3Xx63SityZvWwwXEPKq5CitKpO2SkiNRMWdub2MyEM3YhFa8p00Cte
 ZAX0mjFNDZlWsValYHjHkLjzK9dTR97/N1e5GqzojByuiitYe2U284X3ULdgQiD8m0T8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=T150FBHbGleIB5mrb9HL3szXKTUr2956ZFtpCqxsPgQ=; b=C
 BNRAbTW5NjxDTcmoOeabqUVLOiTZfNVeAfdkXfoYOtsdpUe2/HqjZvjm7Kjt6FIyn+QI0sSGEO7b7
 9juw8I135gUsaVsmpXbX7SrINtBQVg/NdtIdUhry1QeyTohqwboHXMMRXmruK+VCqTjscozwO4f/U
 InRnSWFL2F7cQvmc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ni0fq-006rCD-C3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Apr 2022 21:18:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EE4DDB8327C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Apr 2022 21:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC36DC385A4;
 Fri, 22 Apr 2022 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650662305;
 bh=hqWuDh2/4bxBqikSOmOW5A/qv61DX68gdU1Tb71NWMI=;
 h=From:To:Cc:Subject:Date:From;
 b=KW++VE43h/4O+yK+DHLdNLcgk7b5Hq+BtGAH6Sq6sNANptG6axSP+xCd7xPJs1sPo
 xzPgwUpDSg+F0d6FrY3kltM1Cdy2ctgiWRhmQdzSNqeUGwbp3W22FmxvYWvgNFBY0q
 UbFDNmKZWumUQHypd+HQdHs34PFMhoMW9diwHXhCM2GsZIJt3QHQW3iPYA0z9brNUn
 VeRyIZFWdPH/EHxjMBy1DaFEPRcd4gau0jWYPLy7MPzWErXrLzKCqtMp3kY0X8HDbD
 8vl8GEyVUEBx+/iMlk9uBpJ3l49Hl2/RuApPcaVypSTPQdCLi2gKyLQXXp73V13VE8
 ZSdxnhalGCzrA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 22 Apr 2022 14:18:14 -0700
Message-Id: <20220422211819.2230879-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
X-Headers-End: 1ni0fq-006rCD-C3
Subject: [f2fs-dev] [PATCH 1/6] libf2fs_io: add unused mactor to avoid build
 failure
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs_io.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 09a689293356..a392255e8e85 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -501,9 +501,22 @@ static int sparse_merge_blocks(uint64_t start, uint64_t num, int zero)
 					F2FS_BLKSIZE * num, start);
 }
 #else
-static int sparse_read_blk(__u64 block, int count, void *buf) { return 0; }
-static int sparse_write_blk(__u64 block, int count, const void *buf) { return 0; }
-static int sparse_write_zeroed_blk(__u64 block, int count) { return 0; }
+static int sparse_read_blk(__u64 UNUSED(block),
+				int UNUSED(count), void *UNUSED(buf))
+{
+	return 0;
+}
+
+static int sparse_write_blk(__u64 UNUSED(block),
+				int UNUSED(count), const void *UNUSED(buf))
+{
+	return 0;
+}
+
+static int sparse_write_zeroed_blk(__u64 UNUSED(block), int UNUSED(count))
+{
+	return 0;
+}
 #endif
 
 int dev_read(void *buf, __u64 offset, size_t len)
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
