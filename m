Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBB3C44515
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+h7B5dC5yxEItbQfelUfi9pfVkJDzln+7evaUakSp6Q=; b=guwfoCXJn/9t1M6bzY6tdChF1q
	ts2I0u1+xf4G+OjR35VkxshgZLR3G0RrGHrxNBmAaVUanFH0gXhjYaP+TttPBUWCRgJcrFE1vTP9a
	hnDzrnv624QVKiq5T4rLEmeDW6Hjvbp4kDXOuoAGQgesBIKwGlPcD2kbc6klsWEJ8Zo8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlizB-0005xr-Pa;
	Mon, 20 Jul 2026 08:04:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e0905d82d93001400e43+8366+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wliz3-0005tw-9W for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 08:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+k/S57ilndGjoJss1cqjmQ22UwAd2c+Gg+Fclh9PZOU=; b=O54GgtZeNUFc2+tQy3FHfEw//X
 wVDD8csAhq6K1DTdj7CA6q/BCnOc3Iayxea9P6XRPpgaHi9GiwvsDfUmc4B9XKKl9SQISmTLnP9rb
 E875UcDPSEi8L1IoOKrg0ee7okeKp9gE6A1g0u9QJHiF+3MLwK/RkJQXt7sFTMMFSkP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+k/S57ilndGjoJss1cqjmQ22UwAd2c+Gg+Fclh9PZOU=; b=QysoKRJyfaBuIQifH51S7gyqrp
 Sc2g3zxwcVrlg+LVCq8xYIkjfPi81LPIoxboZpg9iWG3FiAafAXWOIbWWx+CAwUvHzmblU+Qm6p2R
 jnaOfooDowY6pyEfqHIZ7EiEkAW/b86CV0BbVH3PyXkRmY9Bo7NA9fU0ptDmsIqU/q6Q=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wliyz-0001X0-UW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 08:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+k/S57ilndGjoJss1cqjmQ22UwAd2c+Gg+Fclh9PZOU=; b=pjBU6g1bY/5CCKbkWnRO68c+lZ
 hN+mOASOwbENw9K3BviGH93pyvJIgn8pjfVKR5gDS2Sw8kVKSAw15MWDzUM1UsYVFOXB8lQOeKMT2
 QeMk9wl83lEG/h3aKcExIlga32UzGiy+8fqX9cWEpht1MfzZokqHdm0ZVpeknqkkpiPSe19/Fg/GY
 GMueV8iBvh8MA8z2N8be60rj5R1yInaoG81s2GIzNDzBZ+R/LcccReOLXP2yKXacrzZmYGTCH5+zM
 GYz00WY02oSpeSDqGHwN5YpBDq7pJunwUxTxDH4muBcZgPtfsWUNv74RNayKJIAKZR4ZeaBGykASu
 AQ3YyU8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wliyp-000000069mR-0zhX;
 Mon, 20 Jul 2026 08:04:03 +0000
Date: Mon, 20 Jul 2026 01:04:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <al3Wcz5pIujPdTrL@infradead.org>
References: <20260622070438.1542638-1-jprusakowski@google.com>
 <ajuLORVplOvEXvnI@infradead.org> <akKd2IImO7bRjVV2@zlang-mailbox>
 <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7a57c5e-62de-401d-8e39-f7409f398a84@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wliyz-0001X0-UW
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

On Tue, Jun 30, 2026 at 08:09:19PM +0800, Chao Yu wrote:
> 
> Let me explain it briefly, this is because f2fs has only one copy of reverse
> mapping table (aka SSA), for any checkpointed data, we can not modify SSA info
> directly during remap, otherwise, after sudden power-cut, we will suffer
> inconsistent issue in between reverse mapping table and mapping table. So, f2fs
> choose to rewrite for any checkpointed data.

So looking at this explanation and the code, f2fs does not actually
support COLLAPSE_RANGE at all, but emulates by doing a full data
copy.  What is the point of this and lying to the user that it supports
and operation that isn't actually supported as the intended metadata
only swizzle?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
