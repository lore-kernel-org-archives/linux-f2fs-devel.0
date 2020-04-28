Return-Path: <SRS0=IwMA=6M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BA4C83002
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:43:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2FC206B6;
	Tue, 28 Apr 2020 02:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="R4ZwQJeR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="X9hk5phS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Bg4D1tf2";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="KnwnZ++v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2FC206B6
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1QuIAdzgkzUKqgC+drpB527PMfk83JFgd3KtKDizOr0=; b=R4ZwQJeRYGvnRJutnFWrt4I++
	JlYuj47QnT8I1e3On7m38vZJK+cM8fstN1siubaTCTHCJp4BQy+rIGxHbM4oIkhYUxCp870T73oJr
	7zDZ39pclQvIGhgqEqYV+aLTvdOB01iifvIClCzIv/My9+MTWUCMWxZ5CJIhQUYpLhnws=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jTGDi-0003dL-Jl; Tue, 28 Apr 2020 02:43:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <satyat@google.com>) id 1jTGDi-0003dF-2d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Apr 2020 02:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dNDHgCC2Tbezyzaz1jik79FYVEDQH+X+/Zl/FX9zdvE=; b=X9hk5phSUD8kDFEmW2unZJbM1m
 mZIhhay8fcvbKymbkdqUZvT4Q+GnyzAcu0g88zMn4ujvyV1s7QKsbXANYfkIR7fgTlLEY00YaVR7b
 A3x6jDIxXEvHAAV32C6hv0iRO4a4MTBzF/38VcSbtun3WwbJsMMs9I0msDqAr2sMZRbY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dNDHgCC2Tbezyzaz1jik79FYVEDQH+X+/Zl/FX9zdvE=; b=Bg4D1tf2KQrZ98rrE52hj2NLuF
 Iw3BQcBUSOJW4TTi8TPszsIp6tMPDn2WIyJjhT2NQ5/BHFhve+SkXrobyjFqfrRku8hN5xoCR4R6N
 pG3+kWfbl/hZZJhx52GqyPJ8Wd63+VpW+CrzZEqFZz4qoiAeLZIqEV9hxjel5b4xjkPc=;
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jTGDg-00DRkj-Ik
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Apr 2020 02:43:38 +0000
Received: by mail-ot1-f68.google.com with SMTP id z25so30060387otq.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Apr 2020 19:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dNDHgCC2Tbezyzaz1jik79FYVEDQH+X+/Zl/FX9zdvE=;
 b=KnwnZ++vm3JMJEkBfjFTzuMZedHlKQkCikCMg8o+5SWaFUknNqNFJgJ3P2p9Bu58HM
 uf017eQcybmhKeNlI5fCSw+3L8DgrWC0bVbQgF+oc8afCfYiOFaqp3b/LyOGYDXw57Uj
 QuOKGbFyCv2xwx1rc1Vb7FqncrawNMyBdsB/86iAof/qDTTDi8hg+1WYx/5AFR7ebw4n
 sQ/ZxXJZQZcKzI3CfLRPf/Fz31PKeWGx/2vzUUpwYkPulnIEOq6wrS3fwVu+YWWfJChZ
 N8ChLbccFNspOjuqbjvUfB4gcGKYV27YIq0wzgMlqrHmCRN1evUqwui+9EvxyLrUj/S8
 NQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dNDHgCC2Tbezyzaz1jik79FYVEDQH+X+/Zl/FX9zdvE=;
 b=iZA0015prJ4q7eic6qL8R+EzFvpYCEh0fYraJJe7ldbeyCjUSpYfIyuCtCNFQZWXfA
 WU6iZ3qBHRypy46uH9PQEIHiFERT4waGYoNsHGxu8opXwHEpmLWmhJnnbLH+1P1Sdey6
 3nq5B1+2pHVRTXCDlQnylUlbqFzNu/GO3AntZuVOGM3BdP2P4OQA/+Se6EK+KSB2gGiN
 x7geCsewWEs9GWZfy9YYSN6/XZya7yOI6UbRKSUO0TikYQblhpFuictGuc8J6fbsCX6g
 TO1vNLsWIb1fcQtBCSdgFhk1Ys3MNQr4QBjxLVqZ8I+sQALmXb0Vtxx2fCFgUJNBKvj6
 ByfA==
X-Gm-Message-State: AGi0PuY5MUMSXTuvL326AnELtNharjKMGfSrttMnWC9njWruk0ZNHXuC
 XR5AePrFlZKFgxiK+4b2yJuId8MH5Eg2ww==
X-Google-Smtp-Source: APiQypJ+Q+7kB5uiF6PP1T5S7xnrAVLUajbrQdNpmN5RmNLCd3B63jV5Haw2iF8Xd19BTMuAfLQl5w==
X-Received: by 2002:a17:90a:68cb:: with SMTP id
 q11mr2161545pjj.15.1588040086489; 
 Mon, 27 Apr 2020 19:14:46 -0700 (PDT)
Received: from google.com (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
 by smtp.gmail.com with ESMTPSA id
 q64sm13385299pfc.112.2020.04.27.19.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 19:14:45 -0700 (PDT)
Date: Tue, 28 Apr 2020 02:14:41 +0000
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20200428021441.GA52406@google.com>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-3-satyat@google.com>
 <20200422092250.GA12290@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200422092250.GA12290@infradead.org>
X-Headers-End: 1jTGDg-00DRkj-Ik
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>, Eric Biggers <ebiggers@google.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 22, 2020 at 02:22:50AM -0700, Christoph Hellwig wrote:
> > +bool blk_ksm_crypto_cfg_supported(struct blk_keyslot_manager *ksm,
> > +				  const struct blk_crypto_config *cfg)
> > +{
> > +	if (!ksm)
> > +		return false;
> > +	return (ksm->crypto_modes_supported[cfg->crypto_mode] &
> > +		cfg->data_unit_size) &&
> > +	       (ksm->max_dun_bytes_supported >= cfg->dun_bytes);
> 
> Nit: why not expand this a bit to be more readable:
> 
> 	if (!(ksm->crypto_modes_supported[cfg->crypto_mode] &
> 			cfg->data_unit_size))
> 		return false;
> 	if (ksm->max_dun_bytes_supported < cfg->dun_bytes)
> 		return false;
> 	return true;
> 
> > +int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
> > +		      const struct blk_crypto_key *key)
> > +{
> > +	struct blk_ksm_keyslot *slot;
> > +	int err = 0;
> > +
> > +	blk_ksm_hw_enter(ksm);
> > +	slot = blk_ksm_find_keyslot(ksm, key);
> > +	if (!slot)
> > +		goto out_unlock;
> > +
> > +	if (atomic_read(&slot->slot_refs) != 0) {
> > +		err = -EBUSY;
> > +		goto out_unlock;
> > +	}
> 
> This check looks racy.
Yes, this could in theory race with blk_ksm_put_slot (e.g. if it's
called while there's still IO in flight/IO that just finished) - But
it's currently only called by fscrypt when a key is being destroyed,
which only happens after all the inodes using that key are evicted, and
no data is in flight, so when this function is called, slot->slot_refs
will be 0. In particular, this function should only be called when the
key isn't being used for IO anymore. I'll add a WARN_ON_ONCE and also
make the assumption clearer. We could also instead make this wait for
the slot_refs to become 0 and then evict the key instead of just
returning -EBUSY as it does now, but I'm not sure if it's really what
we want to do/worth doing right now...


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
