Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DE1CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bj2Fh1jIDrV1WbpWqA0rKunjsOjoLC8TLotasSuH/5A=; b=nHxvr6yZTbklTKkLIoYZLSv+Dz
	UxyMcB73xaXr6LAb0fuZyHxhQASnklT68u2iWNkxedOVxRC9OtOORnp6bJLBFrFRpYtuGUdYDdcEk
	8TqG6iJW+ECkUODpewfBK1fYSdFKH8opQR2p6F3lV715hNrSCbPwYWhxxCRcYWUm/ar0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1jA-0006BD-7e;
	Wed, 14 Oct 2026 16:21:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xH1j2-00069k-2Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:21:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4kNm/zqK+BXvQbf79KIBsuWK0p3H/vvNqohwaYGJPpY=; b=QnoxvfITb1Pg3Ep5Zz6/dLmXqU
 6Dtk4QBhlcVhWQ5dUaQPQdJMz1vS7wawW6FBrZgNJhRawlXV0Ycn8PXEEhZWjkaVdyBo+vV5C9Bkv
 uokVriGW9FDy8V0uqEINLsEcpH+GMyPsWCxIEIgWqiAEUUGa6N4EBG2VuhS7AlK8sFng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4kNm/zqK+BXvQbf79KIBsuWK0p3H/vvNqohwaYGJPpY=; b=GixvmTo/3QTN2hvaV/c2ehM5Hn
 TQZZHLehcqkZQ5PgnH5v9p3/Q98Ytv3Zo8K5wjGiLiaLBD7CRBBgrAsxlE7hstZ5kS2KZzk6Bquju
 vz51v3Ta20zMTfVZdIIH/mtZ1Ts6wjXnOWcjRDKuGw0JHmyMoiYvVkQ5/TskLIRaaU8U=;
Received: from mail-pj2-f2.google.com ([74.125.227.130])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xH1il-0006gN-Qi for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:20:54 +0000
Received: by mail-pj2-f2.google.com with SMTP id
 d9443c01a7336-2e613f813b0so7247395ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791994846; x=1792599646; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4kNm/zqK+BXvQbf79KIBsuWK0p3H/vvNqohwaYGJPpY=;
 b=fKnMujnc3C/lKQtz0Zxx6D0obgtKT8cF/bkU903UqaxmbI9QqCKdn8FmF9K169GKrQ
 5fsDagCNPnxqbXRgGqW/nc184vhxKlZskjWTL11WmFm+uHG+/4uUFKIcZoZiE3BALnEb
 W1jV7G2oDYd9sQouK7Az5RvoGNArlBnxLs4dO5skHoru3SvGTLOzISQdcXOXHUtI3FWq
 nDFuoSopqDpse3u2yw3YPhubEF1WUBp3FI5314gyCSwZEeshsd6M4OFfClH30EevmqkY
 atuRGMlGBAJgp/D4isnGnxm/wmVQnm9M+VzF2fXvnCos9EspxhqloBemewmdLPYXWBQw
 GIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994846; x=1792599646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4kNm/zqK+BXvQbf79KIBsuWK0p3H/vvNqohwaYGJPpY=;
 b=I3w3jQKc5S4/CsO4RgbMbN2pMdx9/bQ29LOgdlbQzcJFcUhLMZHonoyi88A+VC1S4q
 lAP4a7F0JOolFz4nBclo0NOeCUAMZ/wXgd1pOeZV84DlaBng7Z9pIPTjJWNu8CsiYdaK
 3vqhVtkppGtwOfiSfBjsHs+WQBvN9cWY7OfG33XzuT0+AeMykCjtTHiG2GnBT3x6IzSJ
 b01vKdyfewGR4RbA2mUMPg+Fq2A/a5advr7KlZNYMf1ONOTrcgoofwM4QPQEProIwyYe
 zNc85tJQLDUOqCZgK0KGtfbIlN/HAMgn7L6IkRXdTW555NxekTUUJBYIw2alhWlwZB+O
 LSxA==
X-Gm-Message-State: AFq9FYLtyBz3jj0LNDCDYjzFMBN9pZEKbU8DpSVP4KKdBun2BwYmb2ET
 Qo+EvXr7U/POZPzsFv+KdtoJI8nxvSKHo6EtleCMs3jEG1v8t2qDdH+B//LvE9G5oLo=
X-Gm-Gg: AYBFou1Bl85c0nZ3+2Z7LDCnI0CUG8dmydiMGt32fkXtBD1EJ+Zgf2z5oeo9JN8F+8H
 fVXsfRqFJSfcUKcymCoXo0RE3F2kyigCYLBKSf/5RjPXYI8hOsNms4S9Kw0yqlfvgcM/ZfTyN8n
 F1wGeegAm06SJVJOSaapjeQz4LeRTumPjVcPhql3XyCsA8AwbOFuSekfpoMucuVftAVkhHENb92
 CDPHKZ+o2Sv3GoXI3sgn8bSjMLWroFDY6YKQcd8xeZ6/DogxnmGtoxrAqH9UnKXUERJD03xzWlc
 dChFrbwTuE7Mq/hdWRHEfHZJGIIXDKpE3UwOEIt53qGr41ULq9j0NxnteasYmVgaPXBGS8JHsKu
 vAA4hVm1n5P0Ei9D1Y/IyIIwTXcZC+SPxzpPmWpED9ouaSAJG7I4loKV+nI7yN3pLOtgCOjKVH6
 Qszdjli7E+q25SL4HVVE7ZqENntQ6CTcpRzmin927QANc/Dma9NgaYRIkPvSFw/VcEOA0oauPKr
 MEuGC6y2Dbkw7/8Ty4q7YQm6JDMEHVII7T0
X-Received: by 2002:a17:903:2f8b:b0:2e8:7a31:58f3 with SMTP id
 d9443c01a7336-2e87a315d8cmr84098885ad.19.1791994845906; 
 Wed, 14 Oct 2026 09:20:45 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421a1de9sm73045795ad.26.2026.10.14.09.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:20:45 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 00:20:41 +0800
Message-ID: <20261014162042.3834545-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-12-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-12-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xH1il-0006gN-Qi
Subject: Re: [f2fs-dev] [PATCH v5 11/16] f2fs: handle partial truncate of
 large folio dirty subpages
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sashiko says:
> Could this lead to silent data loss for order-0 folios on recoverable errors?  If a
> recoverable error like -ENOMEM or -EIO occurs [..] the code clears the dirty tags and
> advances, silently discarding the unwritten blocks.

Changes:
@@ -4531,4 +4593,4 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
 					(err ? pos : end_pos) - folio_pos(folio));
-		if (dirty)
+		if (dirty || err)
 			folio_redirty_for_writepage(wbc, folio);

v5 adds `|| err` to re-dirty the folio on writeback failure so it is retried, matching `f2fs_write_single_data_page()`.

Sashiko: https://sashiko.dev/#/patchset/20261013115621.968742-1-nzzhao.sigma%40gmail.com

Thanks,
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
