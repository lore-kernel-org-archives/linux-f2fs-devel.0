Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D9DC98302
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 02:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lNFjF1LlEbSISJrhAbSKx9FdGBWytUfYu6OvWkQxvk8=; b=AaF4pk92Stc84LuuiczJy3O9Vk
	bVwM0ok3QLWA5Jc7vQEVA/ZzXxVS/eaKoKgEdNY6pzM4GSUpYCN+ZhSYXLg2OGfZ12VK88xCwG/R/
	fbC5fjKJVxPQ9j9cbpQUvf8bD1WC2gV02emOmeNl+Gq6N72GrIx6LjCK/pWEWf7SOeQ8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9Cqg-0000TH-BL;
	Wed, 23 Sep 2026 02:36:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1x9Cqe-0000TB-UE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 02:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wq6rDKDipwApsiUMergEejrorDpbyIXxDoYQljk9aaE=; b=mz3mVMBuwxBs7L4SEuRhV/gGTN
 HsXJkMdjQ5X4YqTaYTRYw+Yf+qNdX9e0GDWll+9gpk47Ul4GNrcl/7Qtj8xyNqIrQq5thE1gL6zoT
 oYUF7GtMjKSi9ZuUVT+4DCS6yqLVb8Ly5cbO7IdCWYOKS+jHAFfX/XX1/x0BTTkFz9nU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wq6rDKDipwApsiUMergEejrorDpbyIXxDoYQljk9aaE=; b=XbXkk9f3fYcEwqb0Nn+7xAyVMN
 GUwFSd5s/+Ki7N3FOGgXSPXqTptzS4Fw8EvCJAjHXE5kPRXonaLRw3y1sbWgdhrI1krEMFBENkZlP
 RGtGQQx4hEnJArNbgQABVQpK/fKemWaQYtbdqMT9Ezu4tW0LxEv7M93L8I6t6/EPPvr0=;
Received: from m16.mail.126.com ([117.135.210.8])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9Cqd-0003Nw-Nt for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 02:36:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Wq
 6rDKDipwApsiUMergEejrorDpbyIXxDoYQljk9aaE=; b=T6RENoVuOCPYB/Z7Gg
 rxywQK733nfT3zivSDlNZiodCGLV8JnudEuZbbavHY2JyvmIzzKdYTNFyS2Zpjsw
 yAR/O/pzWJ905lRP3GbOy80paVVQ7jAI0NGCbs3Q912iSWg4E0YdujPo7PYcY0Dk
 WpwToSKWkf6ZOp50+1fjr9gBU=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wDXH+8UO7NqDuI4AA--.29453S2; 
 Wed, 23 Sep 2026 10:36:05 +0800 (CST)
To: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 23 Sep 2026 10:36:01 +0800
Message-ID: <20260923023601.2191075-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_z47SS7OKs_wU=-eiPLTMqF=7w6cekiLFK4ePVAhC8YNg@mail.gmail.com>
References: <CACOAw_z47SS7OKs_wU=-eiPLTMqF=7w6cekiLFK4ePVAhC8YNg@mail.gmail.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wDXH+8UO7NqDuI4AA--.29453S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw17AFyDXFWkAry5Zw1kXwb_yoWfJwcEyr
 nIvw1DAw1xtr4akF4DWa15ZrsxtF4UuryIk3y8Jry3Za4FvFZ5uF1rtrySyr4xJa1UJF4Y
 qFsYq34IyrWj9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRfMa3UUUUU==
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohVbK2qzOxVUaQAA3N
X-Headers-End: 1x9Cqd-0003Nw-Nt
Subject: Re: [f2fs-dev] [PATCH v2 08/14] f2fs: optimize small block size
 large folio read
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <nzzhao@126.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, 15 Sep 2026 21:33:15 -0700, Daeho Jeong wrote:
> 1. read_blocks_pending underflow: If a folio already has ffs attached
> (from previous writes/holes/reads), whole_folio_in_bio skips
> incrementing read_blocks_pending. When the BIO completes,
> f2fs_finish_read_bio() still decrements it, underflowing the counter.
> 2. BIO split risk: If a large folio BIO gets split by the block/crypto
> layer, f2fs_finish_read_bio() would call folio_end_read() prematurely
> on the first completing piece.

Hi Daeho,

Thanks for pointing this out.

It seems I need to drop the whole_folio_in_bio change in the next version.
(BIO splitting at the block layer can only be solved by read_pages_pending.)

I understand that in that case I'd better re-measure the I/O performance of
the whole patch series for the next version?

Thanks!
-- 
Nanzhe Zhao



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
