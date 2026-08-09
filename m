Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6603CC5AC67
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/GggCgIfzjrW5BFL6pZCYpFI8MhmhQB8QhEG92epoFs=; b=GOaJb5totisppk2eCIdtRQnXRq
	tk5ERgu5Wp1Ru8C16nwbIeVS6O4OpSz4lKAnDv0dZo5Rx7deXEghLMq+8+oxeixp6bDr+URKn2HaS
	CqePJ3J/gmoTxGAZNgik1yvGxdX4PbYhrp4BH8FlE9MlQCDy8ddRBPK2Fo9UTztJGBss=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wssCF-0001ZY-IW;
	Sun, 09 Aug 2026 01:19:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wssCD-0001ZQ-Tn
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 01:19:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K2qNCO2iIrsvq5WO9N3ClCvHMyYMh9h8fqOjkEzr0nA=; b=bTAz6JsCqMtBHPwHwYWkrdbmVP
 Ek7vmSxIHHF4bHhI1pbJNDSfW5roVpLQNNQ+pBnnrbovap9Ojj761eMuKfS4Thsi79I3NkOPMWYIK
 POe5bi/maOeL+aiNGkMPylbrEly4kaRa40lwPnQ6tWOQaGrzugfVT2Z9JGV4XyngR4XA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K2qNCO2iIrsvq5WO9N3ClCvHMyYMh9h8fqOjkEzr0nA=; b=I
 CZeNTEZcc752PRN09WLgH+mSNRs0V4wHM036iUAu+FKC91m9C3LKG0ExbQac7uANdYvUTy1iM6qBx
 E62gMF8wkwwEPo7pZXDgcfvX+a+5FRTKLIQBaPa2HoOU/IXSVTGoa9BYBCtkmIT4HnNGp5Sc4vJPy
 ytQFx/GPcJNXZQ3A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wssCH-0004UC-Ms for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 01:19:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8259760008
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  9 Aug 2026 01:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC3D1F000E9;
 Sun,  9 Aug 2026 01:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786238359;
 bh=K2qNCO2iIrsvq5WO9N3ClCvHMyYMh9h8fqOjkEzr0nA=;
 h=From:To:Cc:Subject:Date;
 b=d4AaF0uXDoT8SCQOQr/zkNtkYEWXAP+45hT/reQC37zlf5qRm9mV3KynMZspGTpCN
 /ICvgdGOui9xVPMnfpEglkK0g10xJR+aWZcImuITURJtQJ6HDarSrFSB1cgTqDC17y
 UZqSuL9CXgYBPA+eSVBTmimu0wlyucXJyFo92gf76a1iYKMzBjzlwf0r84RKeDG6qN
 uwqqD9R4YD3bIr2k5xYSgPJcAZqKZK4Q28suDixJF2oJalZyenWAsHIZrrrvYGsoqw
 UGKRy0i46KJAKUIk0Qjd3BV2wS83OjhghgIFGwES790VpFcRYDFcgeaEyrV5ikyi8i
 8ju0xptuE1LrA==
To: jaegeuk@kernel.org
Date: Sun,  9 Aug 2026 09:19:13 +0800
Message-ID: <20260809011914.565936-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1wssCH-0004UC-Ms
Subject: [f2fs-dev] [PATCH v4 1/2] f2fs: fix to off-by-one issue in
 f2fs_zero_post_eof_page()
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise, it will drop one more page after new_size which is not
necessary.

Cc: stable@kernel.org
Fixes: ba8dac350faf ("f2fs: fix to zero post-eof page")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- no changes
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b99d9cdf9ba7..be319a2e9830 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -50,7 +50,7 @@ static void f2fs_zero_post_eof_page(struct inode *inode,
 	if (lock)
 		filemap_invalidate_lock(inode->i_mapping);
 	/* zero or drop pages only in range of [old_size, new_size] */
-	truncate_inode_pages_range(inode->i_mapping, old_size, new_size);
+	truncate_inode_pages_range(inode->i_mapping, old_size, new_size - 1);
 	if (lock)
 		filemap_invalidate_unlock(inode->i_mapping);
 }
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
