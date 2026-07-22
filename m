Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215D9C44539
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hLkP6W7aMudgPn5PFxaxFZ7WBszLCQ1iMOCiRyLSakY=; b=Ef2+y+wtgfRpJ0PkiOFq3vcYv8
	BtBupZGuGrAkf4v31rQDFNN8WbM2eXlYKwoRl/a7qylzdnWOfZOywmaKHfUPCAk0fecajU9KT10cw
	UvIALCanoTKGbWmzjtYtHE/PNZ8oSP585PiSSFMwLm5E29SiraUYzH4VzKLFnH+PaoeE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmSo3-000894-1J;
	Wed, 22 Jul 2026 08:59:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+371806032f8d6c276398+8368+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wmSnt-00083W-RD for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 08:59:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bw/ZwJMR2E4oPPf21+xmPO1rb6lPTHcC55Yd5BZPcLU=; b=fQlMVdrOoKNBATiEBqaxvPIlEJ
 TblY+nIm0WArL9FFLPpg8UKwJBlRa5R2xacr8w6Sr0sR72FFarcX+/b1WhQ/mhV3mZub7uRdnBZGm
 /N4pnPNunY1AoRV/ZeGdy9QHVpH+nVb/54mGwE/NyFnwh0w+She0tXOyco9fYoSAqDGQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bw/ZwJMR2E4oPPf21+xmPO1rb6lPTHcC55Yd5BZPcLU=; b=jDT3+oBR+oUzh2g1nooZpnVIP+
 jZvudufW/ao+IUY520oLsXq0eKpt8I2mqqeTV5rIOA5k4UzPo19Gk5FrH0/9skPiMa33Ll9ZNNWBR
 4Y5vsWaKjRGHLypI3kbqz6LsMUn38y4tdkdz2BS/by6ulBY3kwclzTOWteYjCZGgxMc8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmSnq-0003ou-QK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 08:59:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=bw/ZwJMR2E4oPPf21+xmPO1rb6lPTHcC55Yd5BZPcLU=; b=J4uquJmA2FpCnM98prIs7uSJEn
 ADzYc74f9ZqtPGNeHhf6amMxoXpK3GP0Z8poom+Gw5qbOiIkWupWAQNuZ3fLzIfoQFPW7NjPb5JNa
 KCMg671g2fNfymh/hyeNnYMjqhRKmBxExBMdMktVFXQ32o6wIY4L3jCFR/rHx/FMZn9KFSrmIZofI
 a+A+9FLLmWw5Uz0foDo1jBP/pXkAx8ZDmFOi9FRHf23jaSDMcZkJp8e6fOSQvI8QzPeUsnafmmU/J
 ccub/qwleepEdHAoT1bnYMfUuhmBuYWCrcp3YNBtuYnGxxOUp2qNgxoJdpGnr7dKH/3IDYAf59VxN
 0U/UQ/CQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wmSnl-0000000BJgc-2Gyn;
 Wed, 22 Jul 2026 08:59:41 +0000
Date: Wed, 22 Jul 2026 01:59:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <amCGfUHu6kI4CPND@infradead.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
 <al3Wcz5pIujPdTrL@infradead.org>
 <1a0bb2ad-c175-4cae-9e3f-79fbf69ce735@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a0bb2ad-c175-4cae-9e3f-79fbf69ce735@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wmSnq-0003ou-QK
Subject: Re: [f2fs-dev] [PATCH] generic/064: allow 50 extents on F2FS after
 fcollapse
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
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 22, 2026 at 09:12:48AM +0800, Chao Yu wrote:
> Hi Christoph,
> 
> On 7/20/26 16:04, Christoph Hellwig wrote:
> > So looking at this explanation and the code, f2fs does not actually
> > support COLLAPSE_RANGE at all, but emulates by doing a full data
> 
> For non-checkpoint data, we can just update metadata w/o any data copying
> to support COLLAPSE_RANGE.

Can you clarify what "non-checkpoint data" data means?  Older data?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
