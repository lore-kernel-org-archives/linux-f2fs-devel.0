Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3996DC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxmpgiSf6HPCHc5Lx7q4mTjDIIQnFIlqivS/LBFsLEk=; b=C5VI+V63R4IDLc5A73V3+V7bhC
	c9kIcVrLlzrb89Matmtxva3oKqbGYP7waGMCRsc2wkGY+y3OAhtt4ZAVgBI9c99KPW6dHm4PayOzh
	823yMN8i6EpGLKFc/HjeLiv4CNHAS/PDfE+poRC2YwRhZg/GGlEq+TthyjW8MyK0qYm4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x273h-0006uK-Ld;
	Thu, 03 Sep 2026 13:00:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x273f-0006ti-Ry
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A7QKH2r7d66SxSFJm8bjz6ZBcyuRFjzyujOBEDXlc4U=; b=XFtgPB/3COrkLCIMaR9zumBOxs
 63iZT5/O+5hQKJLlOuYfKOP4dFRbrlfwMAt5HwxT9XsIGkhVewySeLPZZmaBEQEUDfgEM2EQ4l6qR
 oW8IA4/pjKyHVkKVe/hjtXK+J1W3WcbGz4xCCeRM1Z6mjuo/+SZrP5VafnP/j5AGSwwI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A7QKH2r7d66SxSFJm8bjz6ZBcyuRFjzyujOBEDXlc4U=; b=f3t8uF3wkwjPA6IczIuZUo5cdC
 oEUjVKhGoANpQckXk7N2hLTMEfTW/CpPzyKXyuBBLYIbQFTdtXZWfPVNtqrZrxBZjJN2bdLmeG8Df
 24dFqe4ffahmdeHoJ4yAYBRG3cZjoB52KPwMISd3EqjG/EMRdWqopIBo5CfEzFFdIr6g=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x273I-0003Bx-VS for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:00:26 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8568e3ecfc3so1909133b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788440419; x=1789045219; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A7QKH2r7d66SxSFJm8bjz6ZBcyuRFjzyujOBEDXlc4U=;
 b=km18tpWf8PrPoQlzqFzUz+EBmGpFuL6u6/4bB2Eb3zBWCc7r7cZXQ1Y0iEpONam5H4
 NJAY992s+E0yI4xUpLiUBc/zpEDhoFxif8mA1PXzZ6WFqCkzB9C4gNzf7eY2ol6Im2d9
 72Xe8vNNG4H/xpufYUkad99jgo72ko7GkVk0om3rQF/JjA50nhKzBeYtms8uYCMry3Y6
 hvHFoK62+aaduftE4/LYUVNt7GokogBxqCQZjHheaqEWKx3YYqodcL2D2rnTYuQpVtzI
 F1yzwaikA07SpkivoMofBQ5oyerIHiadGRkPXUrttGlKlBwjbErSlSfrGi1f+F471Gkt
 a06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440419; x=1789045219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A7QKH2r7d66SxSFJm8bjz6ZBcyuRFjzyujOBEDXlc4U=;
 b=gwRccxR0Id17JvweWV6a000fxCzrvNkdSBIxdK5kO4ZHLsxSCV07A/V6q7aDc8P9Nq
 o5JDwNnUBCNBoCP/d1mFYMWEqqR+gM7HBwpJH/KkXcs8NCKqEH3vLgkotTgapYmOZ+ev
 oxbURtVp5nLRfeokqZqqU3zFdDubwSd4Am2rTkWZJVd6kgracWC20+OYPtFQdUKA8cMy
 7dCJ9XMXXwwSuDvsfPjf+Ma9yeeiXA4UvHsrAty4KVhicTn9OUwjwEW9hGgDjOfEuAMP
 +aYlC+d0/fYpSA/2ZZJkrTGl3JVMB7Zu8ILGihCa+kDuSVaklACOjJvJUfHDl2IHhQJj
 8fdA==
X-Gm-Message-State: AFuF++koIzo5sskcVrNm8AKYn0GqqZtg7ai1WENEnthrLoBMBhcTTHJv
 2FybBVcUhwmgh/V2e2dXZqnUajtVE0Bz2zu88vXRFlXZjPUUGQrnqw0d
X-Gm-Gg: AYBFou2QFJwldXI1SHZcUCSdDHyCPMxGGDtq9F5oxUfZ+3VUtEkKH3MCco5dORunlF5
 LjtPhtEp279e4jZjqVapyVFFTVB+878zOaPYo14kHR+2p3NPsX3DjL3oZ7W027C3xbEWJRmpj24
 YhwrNt0yyta2UlmuixLDt6SIn5kfw8u9e877AK5gvegJmQ8wGva1t3xt0BArxXDBG+XnvMo80VO
 uP9lTvZEs5813FM1jzdGT24LvWO5npqJdOt0MkjfX4xk8dNnLJAHZYs2wvlIFyjF1xVgG35P+K9
 sx+eOUgk8hOmUgYn/M8lbvDCFMJpPmW4k1aZv34l9w1+21zrLVlfRJU/eZGefLOQNtXNKCRDBmG
 C2uwRAJYhQ8e6nAkTAIMyGVNelnQTcPQ/JqmrxXjdRNBI7zq7txc7OifDvFitjEqHoWme1PiH29
 qohkgj+2x4s+8+WsqjPnBUasFSHzXy3I7i+KzWRt8C0Cvl9rIh9VW+G566CcaXmY0If7XTX5svJ
 q3p0Y8Y0UvrdcjBEQr5uoX4
X-Received: by 2002:a05:6a00:1a0d:b0:85f:4255:59a8 with SMTP id
 d2e1a72fcca58-85f42557303mr14081961b3a.10.1788440419002; 
 Thu, 03 Sep 2026 06:00:19 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db23f7bccsm2980946b3a.10.2026.09.03.06.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:00:16 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  3 Sep 2026 20:59:53 +0800
Message-ID: <cd5bc4fbb9000e5936dfc96e97ed1e8ab94d0a94.1788438786.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788438786.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x273I-0003Bx-VS
Subject: [f2fs-dev] [PATCH v4 2/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for IOCB_DONTCACHE writes
and advertise FOP_DONTCACHE.

Keep the F2FS-specific lookup because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 9 ++++++---
 fs/f2fs/file.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0fedacfd12..6e816c9349a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3884,11 +3884,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
+	fgf_t fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
+	if (iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
@@ -3934,9 +3938,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT,
-				mapping_gfp_mask(mapping));
+	folio = f2fs_filemap_get_folio(mapping, index, fgp_flags,
+				       mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e8..570244ae4fc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5909,6 +5909,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
