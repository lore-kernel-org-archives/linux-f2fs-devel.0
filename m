Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC78CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jpGrdK3uNTezL+ee1OwqhmB+h9pcyMITSEG5shO2sIw=; b=X6EBM/NmlhRBM2QrfAyPdkJ6UX
	7lz1en6AC3yu0kwna0G+jGROW+iNpNrcmlAscHcrGjaOc8Lf035nocTw3IkNk3ZMhi3yLHZHPVxdz
	yB3zqRKIcI/9G1hW5I8Maroob5jwuIgtZlLRA7lklb+IPCGJLXYl2LnTkfCPc7PpkHqg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskh-0006oU-KM;
	Wed, 14 Oct 2026 06:46:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskg-0006oH-7m
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BSqO/zhHgRFW/+OIlp26uOSe1RZSVmBUuUAxntrjdec=; b=S+y78suSYMS64pXmKqXzV6HbZ4
 S/sObZDCttHihcPLb4cq0rTktbQ9irFvXAp5nQJYGUvExqJS6ZDHf6p4LszuVwGr+US9tS2SJIsur
 4L08D1nBdIecQKrbvG+wbrZnf6uZvTXyBu1MzcsAGFq0y35E7I21Ql2VYuj6W6ASwQTM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BSqO/zhHgRFW/+OIlp26uOSe1RZSVmBUuUAxntrjdec=; b=coFi9GM76VzCLy57vnj4J0sHCn
 0nMkK1NQBpiNoilX2LZ/aw1Mx76tmSRLZQAxX0iw4sbLoDAxjYPx9usMqzjCuXmygP8QhwnjAzwjO
 6t3WdeLZF+FiIzQdy3EcZAV9F7bE2wuL5EfFnp8BkDfuFfdvqQrmDz53QTQM6qyWqLKY=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGskf-0000yx-Al for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:14 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-3ab37ea4798so1405575a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960368; x=1792565168; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BSqO/zhHgRFW/+OIlp26uOSe1RZSVmBUuUAxntrjdec=;
 b=AAbSE2O757UME0jCOUqxxGc+yngwcIDAEmPy/TscRLXBa+n8ZpPu4QCGw1EfR6z5nG
 gd3mL5Px/pdA6En+GbbSJ0T0lnLr2XBdLXQZRuSuEBjJ9ZfyoSFWlXAiEcOK8upk9dKR
 P93raRancQ5BI26YiQjA+87lKwj6+w+uLLoi/wGANW8zroUUJkEmA+aFYmEVTABYzkni
 vWf2/FFghgKMt303Owz8P9wFKzbkuLeWtmSPECgIIzKF1IAyH1LedD+VOgueMa+3TmEF
 UKauAooRR6aMAl2tC+o+jDFYMmd6Ox9GKWQgAJhIyyUofoHpsb9w6p15Hfw7ySrul0qf
 Ffag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960368; x=1792565168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BSqO/zhHgRFW/+OIlp26uOSe1RZSVmBUuUAxntrjdec=;
 b=HuM7fz55P+BhvnfyKkETmoPyNJ+tapxEe0wGFZeMAZEMg3Evr5cc3w1Y1ulBG7jB+U
 wz+UKH/WxKsD6vcC88/Ah32tSHAcrudaHzRV6cO8f48DDMAyzGLfvX3p9WmiPDEliqLt
 ArA8nZSW/ZHGXiPdmBnTDctVZMA5wrFO2fvoJUoa6+/TW/zfFCMM6oEyTQRxDnoHxdId
 Gdx53kl1fUglY56uefhThJ8ScxVOTPDWaXRvc+NCAHD15wLlOLo1BEj4k7jL7kGGkssw
 sW8r5DaMaJRB0VjnKD11MxH5fRk0XP4iXh2JMt2c/7lor1Ya6ZxLa4SPozExgSi4J0jP
 xvdg==
X-Gm-Message-State: AFq9FYKEIr/Vzx1gBzeG/40Ddb/SEFdKjAktOpbzFJYbDV94B4EYvLpR
 yYzovfOVLpXJTQNseLDLXr5HmorHZ1m6r4jgQY1EfJ4iU7SFJ4NQfnVXWEVDqpJik6Y=
X-Gm-Gg: AYBFou3Ta2lUywYNOmUw9kA+OrZ8ydsmqOcgkoZrKfCAlja1jwzXI1GCLlo7VSBg3YA
 +2w+KS1IU60fNaIuPoNEKBfhLamwNS8z29cAI5leLbuyayLvMww0dhRGjFvC+d6uorr/3p3nHAI
 FTZkUqTWm45kia0nHILkiJMlvLJ2HcNdQapKxgCGPNO0OIn9nIwQkkn06OM69iTsvL8GqhoAZPd
 e1OIImaL1w3cKa4tRKRzGixdw7Qr0kbFTmubhcycpSTaN7thllLjU0Ft3WInplBJ9uJMHzUAc+4
 ezkc4dz7ZWFQRChFCjTwDvpT+jfeCKpqKGICo5SqD3TbhPurKiomgoMJyprW/8MEKBVyiVimeqP
 ls45VjxV1MBoKVu6HWmyEXcAvHZ+PnD5lmp6zzSEl8zme6AN2fdrzvEqs3wdstzHqXQvw/53CbO
 MMB9CI/LH6e/4fbAoupJHXr37FSsKZRT+WHju3juXKtrPpgzZiSGFZgpOjwT9EyipnOrtptNyyw
 RfyjhNE9M42GYzNfwbTKgRen833QDfvJu/b
X-Received: by 2002:a17:90a:c10:b0:3ac:7556:8eda with SMTP id
 98e67ed59e1d1-3ac7556a3ffmr429550a91.26.1791960367573; 
 Tue, 13 Oct 2026 23:46:07 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:46:07 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:41 +0800
Message-ID: <20261014064445.2835813-13-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGskf-0000yx-Al
Subject: [f2fs-dev] [PATCH v5 12/16] f2fs: wait for folio writeback before
 ffs_detach_free
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, kernel test robot <yi1.lai@intel.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>, linux-kernel@vger.kernel.org,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

truncate_inode_pages_range() can invalidate a large folio that is still
under writeback, which can result in the following use-after-free:

 CPU0 (writeback)             CPU1 (truncate)
 ----                         ----
f2fs_write_cache_folios()
folio_start_writeback(folio)
/* submit bios */

retry_out:
folio_unlock(folio)
/* all bios submitted; folio lock released */

                              truncate_inode_pages_range()
                              find_lock_entries() /* locks the folio */
                              truncate_cleanup_folio(folio)
                              folio_invalidate(folio, 0, folio_size(folio))
                              -> f2fs_invalidate_folio(folio, 0,
                                                        folio_size(folio))

f2fs_write_end_bio(bio)
ffs = folio->private          ffs_detach_free(folio)
                              folio_detach_private(folio)
                              kfree(ffs)
atomic_sub_and_test(nr_pages,
    &ffs->write_pages_pending) <-- use-after-free

Wait for folio writeback in invalidate_folio, then we can free the
folio state without any other remaining user.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202610081027.b13dcf10-lkp@intel.com
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4228c26bee0d..9cd1c34fe6c8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -5470,6 +5470,14 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	}
 
 	if (f2fs_folio_has_ffs(folio)) {
+		/*
+		 * The folio may still be under writeback with bios in
+		 * completion that need to access f2fs_folio_state.  Wait
+		 * for the writeback to complete before freeing the state,
+		 * otherwise it will result in use-after-free.
+		 */
+		folio_wait_writeback(folio);
+
 		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
 							folio_size(folio));
 	} else if (folio_test_dirty(folio)) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
