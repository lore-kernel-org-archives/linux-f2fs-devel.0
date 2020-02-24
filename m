Return-Path: <SRS0=hT/8=4M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F488C35DE6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:35:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1AD20732;
	Mon, 24 Feb 2020 23:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="K0thTGWh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ViQK73R/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V+DVcx87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1AD20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j6NFu-0004mo-76; Mon, 24 Feb 2020 23:35:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+fd4c774fa746ae91f5d1+6028+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j6NFl-0004mI-6I
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Feb 2020 23:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PY3LO7INDVp+w+EyWwMiX5Boc/JVIKXMjl3FPvBvaMU=; b=K0thTGWhoOV/w2dkMe/NRnnaks
 beknS9I5N2KiKEWVORJnekV9vZmqW5QAadnc8T1scmBB4cG00iK6fUdTdFZcrebecVLwvyGiX2Nf6
 atCRb+Y0s7Iv1Kf9okVLQitdh8L8dvSD6MtMs1Qk4FxEnoqRNvsyEp90Cqy+ubL4vP2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PY3LO7INDVp+w+EyWwMiX5Boc/JVIKXMjl3FPvBvaMU=; b=ViQK73R/b/yio6j0QLlS9lOHOu
 Ed0lcXihzCg9JnuwyI6r4QO/kgR+0H70fQKE/fHog3f05UpX/hq+SnAu2/QyL5Tw/q/l0aJ/HHfnu
 tP/6nkPQp7u/JI4BI2b4zmjvkJYBZYsKGgwYQugHx7Vxu/R62+aRUAIx1ZkG7am2d7yc=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j6NFj-00FWXe-Eo
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Feb 2020 23:35:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PY3LO7INDVp+w+EyWwMiX5Boc/JVIKXMjl3FPvBvaMU=; b=V+DVcx87tJk52TKdGhJJCBe/uK
 inoCeiP5XzzrwO1gSANtRw13Log7drQQvTc2ys8TpcC5zg7m5wXudpHFc8Xdwq2LrHh+5UvyJWN09
 ZH51GF2VIzakAVkgfmaK81URA5C9MsOVW8QBhm0XybP/45eZ7IH8KwRWqcHWjww/5McIzpmIwqKb+
 twJjGwM9LaCEhOBtH7ryUU8OvzbcQx2CVJRWVA07HWcoGBjZJVFGKq1AHDJ110DowIiCl8GmXEV8q
 QicSV6dlsuvgePe6A5cVdTcwTit1pJP/gCadj4tyS84frv/bpUzN0EUL3u/g1orpMGqA1qqz4gauH
 mcy5oHXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j6NFb-0000go-3n; Mon, 24 Feb 2020 23:34:59 +0000
Date: Mon, 24 Feb 2020 15:34:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200224233459.GA30288@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-3-satyat@google.com>
 <20200221172205.GB438@infradead.org>
 <20200222005233.GA209268@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200222005233.GA209268@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j6NFj-00FWXe-Eo
Subject: Re: [f2fs-dev] [PATCH v7 2/9] block: Inline encryption support for
 blk-mq
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
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Kim Boojin <boojin.kim@samsung.com>, Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Feb 21, 2020 at 04:52:33PM -0800, Satya Tangirala wrote:
> > What is the rationale for this limitation?  Restricting unrelated
> > features from being used together is a pretty bad design pattern and
> > should be avoided where possible.  If it can't it needs to be documented
> > very clearly.
> > 
> My understanding of blk-integrity is that for writes, blk-integrity
> generates some integrity info for a bio and sends it along with the bio,
> and the device on the other end verifies that the data it received to
> write matches up with the integrity info provided with the bio, and
> saves the integrity info along with the data. As for reads, the device
> sends the data along with the saved integrity info and blk-integrity
> verifies that the data received matches up with the integrity info.

Yes, a device supporting inline encryption and integrity will have to
update the guard tag to match the encrypted data as well.  That alone
is a good enough reason to reject the combination for now until it
is fully supported.  It needs to be properly document, and I think
we should also do it at probe time if possible, not when submitting
I/O.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
