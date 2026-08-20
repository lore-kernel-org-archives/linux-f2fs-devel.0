Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE45C5DF82
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+smnNGrFWzvjSOe5PYs+01rNq8vLSI58JR5Z7X7Fdw=; b=X1VU06ugJmqXGKB5cQdtfVuQdw
	u1RONpbR6ov8QlLJOhiZMgCk9KRJt6HeEsd82n8PQSuMtjLxb4uqTzs3a4CN7vtS+zL4SFtB5dpH3
	C9hVTTkX4Xq4DBrkdRYwtGgmmlVam84yHU3JbDBHnFkfFIIsd9xnoQHEJ+2M44ud7ZiQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwwzN-00079T-99;
	Thu, 20 Aug 2026 07:15:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wwwzL-00078y-Fu
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 07:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nEb4XWsfItBITwTZGmKNPe5cmN2HWgRBVZjtN6+d5e8=; b=mcx6xjii1qNnEvWJQX65wEK/sj
 e2iv6FIeSYvEqmO1eCgGCkqRb2imsYlS9Y8WjKrSzlOR2G3PWpAjd7uxuYQAk+DDxYhiUIx2KNFmz
 97E44cp6BKcm4w8AmpiIWPo4CN6gExaMZ3KtRVo4D3uOvnpSW8WWoPcH/39nifgIvqQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nEb4XWsfItBITwTZGmKNPe5cmN2HWgRBVZjtN6+d5e8=; b=eGIDSDAaH6KBUapNKusw6FmsDr
 mCExqzOaK2aHwblxYUeSLMM13bhwJo3xoa3t6bp2DP0qjkjGZEIzSfTNbpCRqTPWOL/RfCT1sF3WN
 Mf4VFH+r/GU0Qhk0zVAZKozLWEaCPJn8TxCRxJmLyMVCGlizmiMlnNK0bZ5UL2jQ1ukI=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwwzL-0003Od-Oq for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 07:15:00 +0000
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1817370b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210094; x=1787814894; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nEb4XWsfItBITwTZGmKNPe5cmN2HWgRBVZjtN6+d5e8=;
 b=LgIbGTUHMZ6Mwn0ZKBKe2fOk/JPdY0alAvovrISWCxNN/ycw45OlgKvo6og/h8VvbW
 Nwx9GNUW45O6LNBY5V4VPBx8zCXc9t9QS2d3Dmm43zz1U+tmVyh3WqvGuzwgDOb3QLMm
 CV3z9bYuS6OlDTP1LYQSlWXkpuNfgVzs/aGE1oZpU7cX/hyIgVbggV3YbfSFNXoMKW34
 N/mzbEZTsMBNjxQ4AGTleiD6r65kpZ4K4BhmGsZCnzEIIkjW4A+9RxiWQxBTHD+x0osz
 lrhzxoX5eV6PigL7qenIZ/OpQ/4/HjfrOeL/eZzTK+R7/lv/B37YXdxbU2rB3SMAa8Rl
 F0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210094; x=1787814894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nEb4XWsfItBITwTZGmKNPe5cmN2HWgRBVZjtN6+d5e8=;
 b=DzlNAvjlE4D/kMBwBfGlVeYQbJObmtb+P+41KSle5ZbjACNJKZYb5A2HHZohCjMPGW
 VfEZ+xZd2aczViKyFw3QshbwQW1q9TWNCnlTobr3KfH5TalkDM1g1mZuUm6p6YjSCJAo
 /DjW7phpBEjWtt1cqD5KJ/R9yCDqet5Wj/bc4KCsA4hM7S6F3+lsH8QNHs/vm57xqvTa
 nie7x+9CtAMQMTmwBx1qoDyFnJMeFjOiGRHES89J7kdtQVBmrx6Y0k3cvPjAntFbh7Jk
 MNQNKuxktaiU0ciJmxsKqSAAT1fY51n5VN4K+i8o8xf53+419F3kRc5T5Mb+lzHL5UYX
 YykA==
X-Gm-Message-State: AOJu0YxV9LSxxwV2yVK834MWlmgoOJHjGvB5ZVgG8AP5Lnx64qFDxNHL
 yTRT7iBnOzDkVHURvYLNDqLUWekKD3m4J0DwkUoYVgq1VSnmwCZMWz5N
X-Gm-Gg: AR+sD12Ctpv5pHmoudkespWKAVrJjnG/hhdWqcy+VxWhj8OwSfNbV0/ig1oF/TfuAD3
 UPHcvpB/M7QWZeKT3XneujPFjd3hKjDkxQ/2G6JBj7Zoq2jhH8U2Bil3hOyc+9GhJNTjJQi8Xre
 Xpd7Xn36VWbiBPe5leLTTy8aflHE5nCJPxHmxEQ7WLEFwPICbSvX7tA2mxrFJ8I7EQ21mW54IQ2
 M+uFP+k0h2OcStAIgh1IQdEdwRPCtDIXzyDZsiIv6IutwGo/US1S0RBClT5O/vo4lKSUJVfO8to
 CAjbFBBgEduJSu2VZak60k6RKekN3DpjiUlapnkG9mBVmTiwmTaGiJFf+y6B0w6HxwqNLEW+egV
 ghqDOgEmqVpCQ+3WDQ+Rgmim4NzV3kyNcRYGbDgkxSYPdwd/gDNUWNWUrFur/9YddTke6AGEOPi
 nPNLhRXgVl6wrmnjdMOsnVZDNdjkgkZH7h51CaY300raWsd7Cp7zDUt2mqkEzrHzJPkcKRqqURq
 jjL8ZtrFUdP2yj4CV+gG5gb
X-Received: by 2002:a05:6a00:3a13:b0:848:77b3:579a with SMTP id
 d2e1a72fcca58-851d3a86209mr16318394b3a.17.1787210093936; 
 Thu, 20 Aug 2026 00:14:53 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d36185d3sm1329116b3a.31.2026.08.20.00.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:14:53 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 20 Aug 2026 15:14:38 +0800
Message-ID: <20260820071438.695893-3-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820071438.695893-1-qiwenjie@xiaomi.com>
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1wwwzL-0003Od-Oq
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: enable buffered RWF_DONTCACHE
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

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for IOCB_DONTCACHE writes
and advertise FOP_DONTCACHE.

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
index a54b3ab52f1..08285c07c2d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5911,6 +5911,6 @@ const struct file_operations f2fs_file_operations = {
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
