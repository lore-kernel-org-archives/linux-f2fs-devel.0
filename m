Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450B6C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7aWqr+mQ7bfyLvAalv5bJoasUTYKhdHucVhd4mrm66A=; b=V4G//L9C0FDBEm8FyvXMXKMq88
	QacYJA+2b/wa3MAPycT2xxkEOpXE4NgCbMh9aqdQiIuDvdul6sfQqBjhGy/QJm1y/tkYGk1YBveo7
	WGTYcu+Dx+i0ilreH8chRv9XL4FRNhxJaP6b1cxuwhLOW9PAdCK0B3QS54Gs4OtjLUr4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyS0L-0004OT-Ue;
	Mon, 24 Aug 2026 10:34:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyS0K-0004OM-HS
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:34:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gAe9u96jNxE6H3oZgwbxQpRnQm+N+LumGnkEUW5jR6Q=; b=PriQzovtDzf2Pxl5ZiXR/Ai95y
 GX+WpbM4lgRogv+MRyOo9tukXVmtfIgLGzLZUzXtp0zfSzi2bo9Fdh9VK+vbhl08xDoGpiaPdJUWh
 LXAxfYavk+VyuG1oAMHI3QP3y0LXRCeK4AR+ta/eiJQysDpLMPxS5zJVMXSMykENNpEE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gAe9u96jNxE6H3oZgwbxQpRnQm+N+LumGnkEUW5jR6Q=; b=WKYtWKcv2cNnB5IxICxIgVTgm2
 E2pPDb3W4hgYMassoIhHwdZA2ZMEttDmMCYWxCMa5KtNIeEWzqbGU7dcjVnrHbgP6DCq0tWpaVS7r
 QNYjfCIxpOg/oJLY8HTD1I3pMfH9J16LezjvwaRsiHV3bPEbx+MMq8NqauDNltmT/x34=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyS0I-0001aP-0n for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:34:12 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso3337916b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787567644; x=1788172444; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gAe9u96jNxE6H3oZgwbxQpRnQm+N+LumGnkEUW5jR6Q=;
 b=oQbuOmpiy0L56MEEHLEHok7NMfmk6RiUD+RnNjZgPqljEGURhA2QARLWZj/grzsGH9
 1J4urEzoK/Y6MY2hFOyIqe7dCFt/WaHFDy4Yzt1Qsb87eVBdCrOaJmrpoJfIRWwTRkqc
 S+/h2WFlXQIGyIoUFQDc05fuDJ8eelwt7+VPQ1eq2b3AX803iDmvSVNz+vIbr4I0+ptV
 ldPaB6hCTTVCyLmByE4pPVQ/IGScWoHe2yAG81OShMRO97ZfQIu3IkdA+gTflpVno1ep
 nzirVpDPTE6xNGq7TOyidD0CNRx12bEt7Kw1bO3hY65Z3Mmn/Zm34Na/i5AANcdq2MCA
 clww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567644; x=1788172444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gAe9u96jNxE6H3oZgwbxQpRnQm+N+LumGnkEUW5jR6Q=;
 b=oiFBPx7UgtU876hn/ffTvPb5fTxtqG+Y8Il1jK0LHnQqh7VaoZd6SX0M8cSkTxHRUJ
 /CUcJQRiFvj71A3GFSErRdD04VYCfso2PiOJKUaBd10GKLCk54UKAB+oKaVtPqgcvecd
 73WKTsLuBtAz6K7r641//DnN9XP3fSGr2EzUfgTmOEzuxiRJZzg0tK4EnY3gmJiUJ4pV
 RDxnjsSNV4HWMJOWPST0OHOhlkMgw89h38nqqUtiLFxU9btop3kO8a5LgkovMnhV9TH5
 g8CQm1FPuhWUQwnZvKSun5EE0hidtPT7ccGlnv1ktythLkhkiHW/fdOvGUP2hSrJXTfT
 zJPA==
X-Gm-Message-State: AFuF++mkK5r6ioVL062h71gCYwu03egwTfYciI0VEKcJxRED5s4j9ZNM
 Li4UimeqnsXxxreoi4eO4O5XgakYOJf3AO1K1mntpyWdznqah1gz2TnLKXS7iWs7
X-Gm-Gg: AR+sD10ZgF+i5tOtG9kZNsPI4gLrxhp34nb/Bct+nfekUC6B/JmpELY7VBi/zkKxx99
 zfho2CAYQ382vw9ElVhXeSuZXxMxf1J+uYPlJaQSBdd8ObM6umq2ixL1ngDcvz3ggebnmHpMt1k
 sGvHOeRQBl3Hz64i6qwocNe2/0TeTGkpangCsQ4DJhqWT9fJ701OXQDN9ETFwA6gtGWjkt/0P7r
 XT8RT1LVfDvQ60O42ndwMRBOTyC/LmUIQX7V7qmyuyg/i2PtvCvQ+/lPALsyxJsZZyY7uxWc/En
 XlwTLdtE37JYCJYi2gZ6UE+YURA0daLxkgvdSyVHO+ZOofI7zHma2s/drA/cNGrMnz7uKwIHVTM
 YqrpKOBjgGckHtnFLmxbS/mY38cib8jKGdhcC3Fvl5mJf80PAmGv7eB7Z5vo67/B/U+FrjBXNMA
 Yg12U1PlxNRuYDY3dS7zUiSwjRLYjsW8Q4++Ffmccfh4RjduDnoB39CbEIFAPskN0pOH6hkhUio
 9EPGw3gJXDT12gV/XUHfBU6Qbrts32j7WY=
X-Received: by 2002:a05:6a00:1d8f:b0:84f:a7bf:8fb9 with SMTP id
 d2e1a72fcca58-8520b9c6cfemr30801153b3a.3.1787567644332; 
 Mon, 24 Aug 2026 03:34:04 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8520f14abb3sm1805081b3a.45.2026.08.24.03.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:34:03 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 24 Aug 2026 18:33:47 +0800
Message-ID: <03790070c828924d98ba6d78e909391fb0014c7a.1787564706.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787564706.git.qiwenjie@xiaomi.com>
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
 <cover.1787564706.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wyS0I-0001aP-0n
Subject: [f2fs-dev] [PATCH v3 2/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for IOCB_DONTCACHE
writes and advertise FOP_DONTCACHE.

Keep the F2FS-specific lookup flags because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 9 ++++++---
 fs/f2fs/file.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 774a3e2d8e3..ebd9dc582f9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3981,11 +3981,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
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
@@ -4031,9 +4035,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
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
index d82be8c1502..8e9d86dd42c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5912,6 +5912,6 @@ const struct file_operations f2fs_file_operations = {
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
