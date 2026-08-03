Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF74C55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sjlWITxbJ3DTl1G3SJwgc4XQjDxZH9FfRB30w0NKCBU=; b=HzghJb8h/iMtmgQvsdExI1r4fK
	u7AoNAhCveZWEuKQUfxX0QHdjwQQKeHeJRiLsXd/ied2kiW2aXQVk3qpLk5dzCBaVA4K3PTTPTeji
	O7FEnCw18ZHxOHpv9Gm8Dq4jCYIXtiO7JaeETUl9MTZIOUs17tZOxi6i6G9TUn8mTr7E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqnYG-00008O-DT;
	Mon, 03 Aug 2026 07:57:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wqnYB-00008F-Ev
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pEKQNJ0GeZ0TkdVN8gs19LHlDQKs8ULpJdgXj5UynNs=; b=FytjSXf2/P3Wbx9H0Z9bL/0okL
 5sSrivNEViDpVuSOytd+1CrNsaw1XRWB+l4vGghjDAlhvZjWp9ryNSTBRG1TCTNQ47W6VEJ/rcFBV
 05EDQ21HBuFTETUIn3pmdp7x0FajFCJKpJ0iU2OuHHH1dlaxHXAPR7UVA/qBf6Ns7gbg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pEKQNJ0GeZ0TkdVN8gs19LHlDQKs8ULpJdgXj5UynNs=; b=Q
 By2sejel1acchRdT1UQTJnm5x4ZcYfgZg5js8yzfT/40OntrW2PHjwUj2a5DezUF4z0rgKUPhvL52
 DevqW6oCJdwKIFnVK1CTs9SgZJx+mfX1L26zecnAqiotINGxKExKeP3kyLDcIQGn6B3ZLBu2yX670
 9vi7nvzcUekUQZQY=;
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqnYB-0007Om-O2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:57:32 +0000
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so4237870b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 00:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785743846; x=1786348646; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pEKQNJ0GeZ0TkdVN8gs19LHlDQKs8ULpJdgXj5UynNs=;
 b=AFVpth0soYR7Usiy7KsCAKiUfdTTPUhXKNGVYVCEA/4aOu9PaSpOojGzNCW42MduNa
 qRhaVHxa26Xl6Q3n8/1yNqdcUH1L2zmgX5Nll7JwKmL7VcBqHfGd7CXmnpNgRICdJgJP
 QfLwi3hiklNJR5wKuc0m2ppxTgHaO80aY8srsNUh0fg/on8xDP5P3TzaSiSUVbgUzBg+
 HMYfuXSiR6VMIzfcvl4TzRLWgyPkDhLaB/hcG6LuZCL3ZA+EL0MmfJegGzOgpeKnZcEG
 LHOcDe2EQiAYcaQxL0c/mmD7Yt1G0+mDQCver0a0ISrkDjvUOak41WXACwpqs+A2qSTf
 5hQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785743846; x=1786348646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pEKQNJ0GeZ0TkdVN8gs19LHlDQKs8ULpJdgXj5UynNs=;
 b=a/Fz+UUlFpVFALy3uk8g4tnvaft/O0kvBp2J5A0iPqf7ZNEgif/2lDKj5eBmJM8qpP
 tVPfaa9Id5mI/fyGBNf3tWWn6j3yOb0D6KwqNOYvV1leaQFKW9wWJSZjLklXi1LphLhr
 DxUA5jFeGbk5qDMNPXi2FZzr+W/RbBLGzTSZ8d7j+qrkIOL7qpmBVnw/VyOzsd9kkkrw
 9cAojz+DSEBeQlctaGpX7rgFbPNhU7jHFuZ1TMPB0z3c4NhnExU2L/5cxgl1/ToZ84yM
 PD/ycvhUv7Z+1pX6p/0o23uuq14nTjFIY+/nG5fBmpPEbiB37KW3LEI3Kk1QEf01BFXK
 6+ug==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuD79aVuFZQWQeo3zchAPfwPcN2Zjrjk2g/hiPJefJT9DCSgv7rXsiMjifUB4G5WR3hUIrO0TwCWHD+w1naNre@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzLnpTD6XlbfLEwbtizPBzq/gnAfxICkyQTzJ9X5Kw6Zicr0vW4
 YiHVRe8TZMY7MG+zTMektGtDnme6lyFKWfFUGmjX3/P6sIyuazlNLo6m
X-Gm-Gg: AR+sD13G2EoWZyfG88T/hM8lBzGO8GdgLLc84B+Bf4AGmzOiXa8dq4DVdc+EzUW6k6/
 PkedKsMGjHdQxrpNnCjwy+c1KZJ1PpN1MDlu5VUuvBtJ4oSomH+QHln26p0XHxcr/Gr5+M18YsE
 5uTO7JnyunKjQ2ccyumyJ4fqrfFWTC1qqMWGgIotFxt9UHEmI0keHmCetjiFPws/hbApkWAyngx
 Q+m679x45ekKfMrkgmv/heNQAzjIe3pQcWmsIONUbRt0N7Hb4sIoIJBgAs9W2iNg7UpEXE52hAk
 X69L5gpb4FLL+GKpuTC5XLLe/E+cVwECgIlfYQ57zGWzk/w7SjRX2cRee04vOu3l3c3lLwyh+fL
 nTrCbmXuRg/ScKC3L5HGvtVoyWXL8sR+DIYT5aUKQCwn/ESaMthGlQnaOIFqkf0RhZSiBkRJOUL
 DhfO7pEo89V3PS8XjOEoOSGEOq6blqLH7lZ6sDRKl/KEuOGT8AH4LAq4z2Y+QrIe/hm9v5Hd7KQ
 su2mliIe4nkpoSwZgfVXO70q3mlfxHDA1k=
X-Received: by 2002:a05:6a00:99c:b0:848:2f77:e2da with SMTP id
 d2e1a72fcca58-84ee498e27amr7666176b3a.67.1785743845990; 
 Mon, 03 Aug 2026 00:57:25 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84eecf81b08sm2166790b3a.22.2026.08.03.00.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 00:57:25 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  3 Aug 2026 15:57:16 +0800
Message-ID: <20260803075716.1400915-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wqnYB-0007Om-O2
Subject: [f2fs-dev] [PATCH v2] f2fs: stop checkpoint on compressed write IO
 error
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
Cc: qwjhust@gmail.com, yuchao0@huawei.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Compressed writeback is currently charged as F2FS_WB_CP_DATA through
WB_DATA_TYPE(..., fio->compressed_page).  That classification keeps
compressed cluster writeback under the checkpoint-guaranteed path for
POR safety after fsync/sync.

When such a compressed write bio fails,
f2fs_compress_write_end_io() only records -EIO in the inode mapping.
Ordinary F2FS_WB_CP_DATA writeback also stops checkpoint on writeback
failure, but compressed writeback does not.  Checkpoint can therefore
continue after a failed checkpoint-guaranteed compressed write and later
persist metadata that points to compressed data blocks whose writeback
failed.

Stop checkpoint on failed compressed write IO the same way as other
F2FS_WB_CP_DATA writeback.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
v2:
- rewrite the changelog around the existing checkpoint-guaranteed
  compressed writeback semantics
- no code changes

 fs/f2fs/compress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index caf522d667d6..9b1501004456 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1488,8 +1488,11 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 				f2fs_is_compressed_page(folio));
 	int i;
 
-	if (unlikely(bio->bi_status != BLK_STS_OK))
+	if (unlikely(bio->bi_status != BLK_STS_OK)) {
 		mapping_set_error(cic->inode->i_mapping, -EIO);
+		if (type == F2FS_WB_CP_DATA)
+			f2fs_stop_checkpoint(sbi, true, STOP_CP_REASON_WRITE_FAIL);
+	}
 
 	f2fs_compress_free_page(page);
 
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
