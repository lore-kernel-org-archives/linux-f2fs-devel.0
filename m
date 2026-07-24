Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB02C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bZ6uFxj8loAgrzDqp67lcX3+akFBxuRTA2pWMz+KcPs=; b=YDqhbeF7zKKmqdM4t3P3LTxFC2
	nj7NVHqTJNo0aswWNr16HI1euzc4JCSYvVNK5vemr1Ogq5FVVZzreQmhtr0v1dsR0JrvZB+JM043l
	UvcRWhl17TNT11mceUz9dvUVSatoVysd5GpABp+bT3/gpS1q6mYWDtKoMooa0TE9hFHo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnI1j-0002uF-Cs;
	Fri, 24 Jul 2026 15:41:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wnI1i-0002u4-7f
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5vLc+vG0rGVVOWe4a5Zin60GW5eTEpkkuLWioXbed9o=; b=Ww61ub2zpOCnGfJKYAAJYeQALe
 iGNAuLW9gEi+/1t916xPOVJ9/lJX4hJ+d4FdfWmOW6yRg90gukLO5hHuo36xI65YunkRfSCGwzqNU
 SdMK+acLLWHVO1DSAguhnzE1OiZfoDTAnWeAUhKOsWUjcx16w9OWa8+Dbzab39ERckvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5vLc+vG0rGVVOWe4a5Zin60GW5eTEpkkuLWioXbed9o=; b=Y
 BPXLBOlGKGY5H1ByCBi6W8ZtccNjJ0KYp1tcJASyFbinXulG2kkMjLlsr3L1Imv3zUbzJXnXDzI/Y
 woAi+TS8lZD7H1SyZg6ud9kMOWkBaApvMfTZG4BThAHvNRi8QHnK7FydzPRGv1mDAop5t+d0IaJZI
 Z/cG7Gs+k65KajiU=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnI1c-00081j-6f for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:27 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6983d3dae7aso2323184a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784907677; x=1785512477; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5vLc+vG0rGVVOWe4a5Zin60GW5eTEpkkuLWioXbed9o=;
 b=EX5AtpBIrANuTFuDrWIIGLeF7GhNbjyZCscOrFV7XV2Z9Qzxo1dJesPSBL+ojc3WiM
 jn4hlaH9MfR5tTSKkW9nYw4AgDgoWJTTUAdYSM9pyFSoJR/m7R3fxjzM8oHBzBWdbp/P
 lGXUB+/KzHeFYy6YLR7WuAopdqD3d5lrOpmqnPB+zd3eHHIEQE00Qty1FwazwwJJ5IgN
 opiJT+8cwcqKxG/9rb8gT70N1FAhiKPKVH9rzQmm9+6KOovOG2JzszReWUKTiheQCnhp
 TSWQccROkRLmV9V/1YKSZnaTwmIOmqi5G/9yKJ9OPzj9o+rON6g17gXAAphlmHAxAwJ+
 CjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784907677; x=1785512477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5vLc+vG0rGVVOWe4a5Zin60GW5eTEpkkuLWioXbed9o=;
 b=ggrB9u39JDi9dmt8Pl1CsqTXi9Pm3CpsCR8g/BqDEp0ahZvbo84ipvNWPxTCSkreZw
 a9A8VJF6svii1eeKz1sp7hWz2Xh3+tGGC2CHKVUIMF0FzBOJHZrtvzKf+bPYcFBAapHy
 uVFzQ0C36jHKf8oqtWpmLGw+oYp/YKOaA14ZcBBWE6zRNX7UdWlnwQqNbCXM/tfVeQIH
 vSMl7CcpeH14OZRkvy1gLdrC+FOJ8I0v6h/L+zioema+4O/JqqOdDYo3KLmiFatLoxbk
 sTPERAALAMe069ZUpFf/adlWShPdc17D3c9a6zvpZMkkm5vVRVxxrLILekcT+Fri4RAH
 +64g==
X-Gm-Message-State: AOJu0Ywxg1KxdEVFypTmzLyNpvPspxmR3o5KR7Hr51ntD15lKz5V94VT
 zBSBly3bKvzXNFyeZ96VeHPqNhoyezURSlTRKIWLriMDAarSdoENgE5i+ne39+FT
X-Gm-Gg: AR+sD11h/C28aI+MW706pmEBtxIQOdLWXhm0+dJuEBvVGh3kJEUJDqWxfeFXLQuKkmZ
 13vLdZUdXAYCGEn0SS9xhKsRvgKT9Bcm2j7Rn5K6xKIIJbSeJB9X5Ca3kA6h3ebKvOX0lpD0bee
 B1MoJcP5w00NXr2Cr/W26ZvrfanSJnKx7rL97VcJkbmfEhHb0dRFKOw88mxDGdZp6e6cDG6ZcNY
 Mek7MDTO8FxaHBwQ75H4hnP4w8ZN4d5NUYYrWpQokjRsElksQsfZxXBVsKAJp5S9KZMwzaSOEVj
 ak/RukrOVTwdkJYGOYuDUPjwVdWO18mATznF1qzHaw/dTvO3Voagge0nl6yd456cnsTLFRotxwO
 J2rVs2nsEyMc41WW9DW9ekHLDqgGbt1YwMFq5gphrwUG3bjCqcCozXfbiNl7k++FgqyVf++IuHx
 98t5mDkW91s9bJPVHOZL4sX2U7gEgSwTYony8yZw==
X-Received: by 2002:a17:907:c21:b0:c1c:6d29:8a11 with SMTP id
 a640c23a62f3a-c1f1397b66cmr39700566b.13.1784901036978; 
 Fri, 24 Jul 2026 06:50:36 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32a798a5sm349051266b.9.2026.07.24.06.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:50:36 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 24 Jul 2026 21:50:26 +0800
Message-ID: <20260724135026.500859-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wnI1c-00081j-6f
Subject: [f2fs-dev] [PATCH] f2fs: avoid stale FI_COMPRESS_RELEASED on
 release failure
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
Cc: qwjhust@gmail.com, stable@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS_IOC_RELEASE_COMPRESS_BLOCKS sets FI_COMPRESS_RELEASED before walking
data nodes. If release_compress_blocks() fails before freeing any reserved
block, the inode keeps the flag while i_compr_blocks is still non-zero.

Then F2FS_IOC_RESERVE_COMPRESS_BLOCKS returns success with zero reserved
blocks, and regular writes keep failing with -EPERM.

Set the flag only after the ioctl succeeds, or after it has actually
released some blocks. This preserves the existing partial-release error
handling and leaves a failed zero-release attempt unchanged.

Fixes: ef8d563f184e ("f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
QEMU fault-injection test with FAULT_BLKADDR_VALIDITY:
- before: release failed with -EFSCORRUPTED, reserve returned 0 blocks,
  and pwrite kept failing with -EPERM after remount.
- after: release still failed, reserve returned -EINVAL, and pwrite succeeded.
- normal release/reserve still released and reserved 192 blocks.

 fs/f2fs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c54897a25981..dca1722f92b3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3916,10 +3916,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	set_inode_flag(inode, FI_COMPRESS_RELEASED);
-	inode_set_ctime_current(inode);
-	f2fs_mark_inode_dirty_sync(inode, true);
-
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -3963,6 +3959,12 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+
+	if (ret >= 0 || released_blocks) {
+		set_inode_flag(inode, FI_COMPRESS_RELEASED);
+		inode_set_ctime_current(inode);
+		f2fs_mark_inode_dirty_sync(inode, true);
+	}
 out:
 	if (released_blocks)
 		f2fs_update_time(sbi, REQ_TIME);
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
