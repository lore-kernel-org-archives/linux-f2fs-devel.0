Return-Path: <SRS0=6JJe=6G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CA0C55186
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:23:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CE120735;
	Wed, 22 Apr 2020 09:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hJvCkw5e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="f2Pp6BLS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FSRMb7oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CE120735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jRBb8-0004i1-AO; Wed, 22 Apr 2020 09:23:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+f4d323def9086acb1ddf+6086+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jRBb7-0004hu-Dp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Apr 2020 09:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LJwNwAXsE+S8zNNlabn/hmZ+oktxf4w2TKCPbz3Xd7Y=; b=hJvCkw5eVx3nwIoHK+xn44n9oY
 dIocUwME0cG8hm5K6+fNvcIhwvGhUrP66FkFhU3ldwW/tR2evuCBpgNyjyw2X6MuVGDzh/YDKLgM9
 7P7WKxYkms5XmOq4/Rxr+gpHSVcNTK1LkJ3jVTG+qKy64cIz2sHGXeocg8UOUzFiHgwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LJwNwAXsE+S8zNNlabn/hmZ+oktxf4w2TKCPbz3Xd7Y=; b=f2Pp6BLSHWSCuRFgGtt47pFk04
 eREtjQ7FQEYyDPTSV7VR3C9jmFHDNUqLAFEHnbGAhMvu7hDLJIDNTykRMX7Tze7O4nNXjs6jjw4eE
 XhVhKJRfZCq30VjbC+vXljNWDBs990nSgm2ef3HU0JW5sev0aN/9m5Zb0yalNt0fhBCo=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jRBaz-009SxC-KX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Apr 2020 09:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=LJwNwAXsE+S8zNNlabn/hmZ+oktxf4w2TKCPbz3Xd7Y=; b=FSRMb7ojsDy+kjVHZOZLeU26Hf
 9MCf1WYrctgxy1tuPfJMalhsl6zhO/V1ks4bbCVNwwHNLlr2jh6msWOiiWacT1kQsPEYAu/6kGWMb
 mMxQ8Zu4i1PrJBW9vFNyMWTpN5Lre4ufCpTj3uRHqN0wC2JGN3FonwPzsLmpEd9Tor932GVd0f33N
 rktqnNf+kW3RdvUgMu8GryUSirp+X5+Kwz3b2uQLGpT8DPabJ2LUrNxxSYFLzws1vD5KwGPX6T2RG
 VZJzk7YamFtFdSj9Y/sWS0kGIoyQLjwpuZmX+BuTl3PCVg67Sxts9J/5yjryJJPwe2kEvUDKf+T0o
 PdTaVhrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jRBak-0006ab-6i; Wed, 22 Apr 2020 09:22:50 +0000
Date: Wed, 22 Apr 2020 02:22:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200422092250.GA12290@infradead.org>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-3-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408035654.247908-3-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1jRBaz-009SxC-KX
Subject: Re: [f2fs-dev] [PATCH v10 02/12] block: Keyslot Manager for Inline
 Encryption
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>, Eric Biggers <ebiggers@google.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> +bool blk_ksm_crypto_cfg_supported(struct blk_keyslot_manager *ksm,
> +				  const struct blk_crypto_config *cfg)
> +{
> +	if (!ksm)
> +		return false;
> +	return (ksm->crypto_modes_supported[cfg->crypto_mode] &
> +		cfg->data_unit_size) &&
> +	       (ksm->max_dun_bytes_supported >= cfg->dun_bytes);

Nit: why not expand this a bit to be more readable:

	if (!(ksm->crypto_modes_supported[cfg->crypto_mode] &
			cfg->data_unit_size))
		return false;
	if (ksm->max_dun_bytes_supported < cfg->dun_bytes)
		return false;
	return true;

> +int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
> +		      const struct blk_crypto_key *key)
> +{
> +	struct blk_ksm_keyslot *slot;
> +	int err = 0;
> +
> +	blk_ksm_hw_enter(ksm);
> +	slot = blk_ksm_find_keyslot(ksm, key);
> +	if (!slot)
> +		goto out_unlock;
> +
> +	if (atomic_read(&slot->slot_refs) != 0) {
> +		err = -EBUSY;
> +		goto out_unlock;
> +	}

This check looks racy.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
