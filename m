Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DC9CA5FD4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JnfPJMEl8ApdlZ0xKJp/62QNbA8OkxFytsAl48ORd3o=; b=O7RP5cjVtFT9sDEC+3VtXugbcU
	zaWtGYOxoZDGzwoGpB2eoSFbrKUar1TH782jCLX1Hta0b3OQMB0hkJ7/SkFjOXxi6jLwh+fnf0Er3
	8SYAxrtXRsfUJBXUPT1rovpm/4tZjlegx+cASMKNSN2eVuiEWhNh8W4xULNl3pr7mdtI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCX4x-000142-7z;
	Fri, 02 Oct 2026 06:49:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1xCX4w-00013w-GC
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 06:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b2I2VmL6WnuxgQWDSKKBuDVc6+oZPGkIWa4vAQHTcFI=; b=T6E2vjRQgbANzA3Cn82gk8OB2n
 jV2hvAfswVzeneg0s0vBMt/zjVD6WjLJNyGmUoxngyLq5oRKCpRisSCQe+91FoyEGskHhgI0GmAR/
 SUQvYYVxjKfPP6phc+louEYPfQBxdiuGcq7eeE0ROJNsj9wJLYiHsKn+3mgjjqYtqYV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=b2I2VmL6WnuxgQWDSKKBuDVc6+oZPGkIWa4vAQHTcFI=; b=R
 WJmrbtDm67yfv2QwElcmftnUUYTY8xYMhXL6P0Hu7F3EcBJFuIF0XNlBsYqXIKkqzplXrm7HmxRCA
 jteHqsBZ+Erm8TNJpFv/xN2zWQnDhM00k2ZSyPRQSLVDok0Cw7PuTHA/9vLmBcogg9KX5N936uUB/
 3RpWYZ70DJQ/uC1g=;
Received: from mail-pz2-f41.google.com ([74.125.228.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCX4w-0007nd-Rd for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 06:49:11 +0000
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469b355ffso3122355b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790923745; x=1791528545; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b2I2VmL6WnuxgQWDSKKBuDVc6+oZPGkIWa4vAQHTcFI=;
 b=N0yLmX2RV+9KuNJ2Fc3eT/MpZNyj5PGmmzIP2vA0wFF2Qq+NIXl0LQGry5AljYQ1xV
 yfQAC7i0FUDbI4a7d2Uj+VFgSWp8xzsdjbPaMe9pXvbQkKNeS97mS2Gyc9gv4AEIyy9T
 2h3SLQRmwB27LytUiIrc9C9ayRWfrzW4POe65XKmRxsCKJG4NRAE97HHWkPxefjLIS7Q
 pVHoPI/qxLl6ebWXS6DY/ln9cJ4/KQ0ElKwK9cpQcMwgO+TadeSNX/r7e84ZymHkzSv/
 qKxYrZm840qiH5YeO+OeucNNycHbOI4w4/DWh5iGhSsXmlked+w7lRXw5eiPiSNH6Op/
 qYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790923745; x=1791528545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b2I2VmL6WnuxgQWDSKKBuDVc6+oZPGkIWa4vAQHTcFI=;
 b=zQ8ytEMOTnsIo0R45GohMDlJvN3+40LrS9xw3MkXGyR2CKz10bSNQmlWiIWtEgHuLc
 kAmHpMzHqeEJpp9WitfQDPxbiRASi7JvusOwXh8675zGfKz+W1BM9W1NGrYYyKiaykyu
 gteWx4Ech1ZAVnLX9RZOIM8aleJy7cfDawF7L8ttBTogYvbCUgFFbr6lmABVuQAKsoTE
 Wu3COJUDIV3x7Hn7wvMsOrWVr4CM3h5/QnHpBR/TwgUCEK+EEhpnfeo+cOe23sp5x+XS
 oAs5gaJHIhFjQ2XPRenlUOB3Hc6xn5eGd695Teql3qk7jRc4iBrJMe3nVoy8OJ+IXp0a
 lkGw==
X-Gm-Message-State: AFuF++lzxc3WZIHsqLjkzRQBoOhgjasnWFcQgOXHUtyXHFI14mUjZ3RG
 l++OYxrwufbLTEHdY8Gxuz7ifEYp7hNuK9Ur+HwAJJKhly0Q0w31sMQ5
X-Gm-Gg: AYBFou2j/L9NZBbaShPfbIvADNzkqrx1nnDAxXQhaU/iaA/e84QZrMt2eyhgMUXkPtI
 f0hZVq0kuEAN4NeHiEQPOcOp2y7HMeeZCuFHrT3AHQqQbqfTJGJ6HIOm21IaNvpm90jmYTmnyCW
 oTjK148IhKoNaW2x422aPAPYM7Rd78TDmaG8lBC4oLs8n7mnk0J7KX7EADH+BXAO6hjFQbplqrP
 Drg4+Xpydjj1Kj2OZkb1WvrmovMTrI7kznAWt+vIkzk2j6QT7Bz4zi+fu4qqbwa+EvaGfGn7BlR
 Dwfe/ddm3TM0aZNElrHFsTYJrwA0jDTPbAc1hflpiyEaYMEIbc8sder7Fa6pNqdLI2n8wpsb5UZ
 QkxMco7tuc6Kxc1gtYiVqhpZUMIR1r77vIovcgDLtDXLphGFvQqN32qvDS6FdSjdJq7MBLy6c1n
 qnB4+TvvZOpQ27FWfdrEELzO39Bpk/HicHlX6k2PFiymMrRKnv4LIQHdCs70Ldw6RmkPG+dfx3h
 RkvAjH0a/JyEUywenZk0JIjYxGcr10p+E8LIM78csWFiPXzj0+9sHgJoJZKMRGCzTGFDcL+Qw==
X-Received: by 2002:a05:6a00:b89:b0:87a:50f9:2930 with SMTP id
 d2e1a72fcca58-88af5ac3f05mr1926461b3a.55.1790923744971; 
 Thu, 01 Oct 2026 23:49:04 -0700 (PDT)
Received: from
 codespaces-2362ac.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([207.46.224.87]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0b8f5b20sm573055b3a.11.2026.10.01.23.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 23:49:04 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri,  2 Oct 2026 06:48:53 +0000
Message-ID: <20261002064853.37782-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1xCX4w-0007nd-Rd
Subject: [f2fs-dev] [PATCH] f2fs: avoid unnecessary reads in
 f2fs_update_meta_block()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When the packed SSA feature is enabled, f2fs_update_meta_block()
uses f2fs_get_meta_cache_retry(), which reads the target block from
disk if the cache entry is not uptodate.

However, f2fs_update_meta_block() overwrites the entire filesystem
block with memcpy(), so the existing contents are not needed.
Partial updates to packed SSA blocks are handled separately in
write_sum_block().

Use f2fs_grab_meta_cache() unconditionally to avoid reading blocks
that will be fully overwritten. Also remove the error check, since
f2fs_grab_meta_cache() retries allocation failures internally and
does not return an error pointer.

Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/segment.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 794e0d99fc7c..51858f64e43e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2844,13 +2844,7 @@ void f2fs_update_meta_block(struct f2fs_sb_info *sbi,
 {
 	struct f2fs_cached_block *entry;
 
-	if (!f2fs_sb_has_packed_ssa(sbi))
-		entry = f2fs_grab_meta_cache(sbi, blk_addr);
-	else
-		entry = f2fs_get_meta_cache_retry(sbi, blk_addr);
-
-	if (IS_ERR(entry))
-		return;
+	entry = f2fs_grab_meta_cache(sbi, blk_addr);
 
 	memcpy(cache_address(entry), src, F2FS_BLKSIZE(sbi));
 	f2fs_mark_cache_dirty(entry);
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
