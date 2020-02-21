Return-Path: <SRS0=zARH=4J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2E0C35647
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:35:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0B824650;
	Fri, 21 Feb 2020 12:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="LLewyRD5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="U/vgBReq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="kSFgOoHj";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="DH263imK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0B824650
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OhUXhmY080fcqcT2EXBG/R2EFewTKRn6gnJIX0vXyjk=; b=LLewyRD5Q1N0IFmIAZ+OtjDv7
	YcU6vfFPhcxT10SUkWxIZ9hytKEdYJtD9qi3RzHoadkkPR79ItUFzOsjJA9KApco6YpbjH/cUfTZy
	IlSSzMld7UFbGnF33Av9NvvVoYf1YQ8itg2eyneiEjf7DOY8g9lK6fPZH5SesHNPf7+H4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j57X6-00087L-0z; Fri, 21 Feb 2020 12:35:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <satyat@google.com>) id 1j57X5-00087B-Ed
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 12:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uyerPeK9P8LqDlV7LqFL68c1sT2T1cP6gBnBuIAjadc=; b=U/vgBReqTdFfdU5lo+qEcOfB4s
 Gsl520SjPSFDaVeFCkXV37LLF2QOSDabVlaqLIsRAIcyTL1clZnh8iANu7gUGFhembZs7MxkjE/76
 dYHVvpDgihU1jSSj5xT2D2JXZVaBKjo1kWQ1rWu3Ai47fLalzvnuRME2jANa2Ag/9vao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uyerPeK9P8LqDlV7LqFL68c1sT2T1cP6gBnBuIAjadc=; b=kSFgOoHjPk3/QBoW0GPX0zK9tA
 zN3ElMEGNt49ofRanwyMN3j3D3gQaOG9egq5k0o62uUFZ1YTZooYmqX4eipjM6OydZx4vLg1Pjs4L
 24fCY+b/9sCDt6sxxM/NH/s8CRp4sgGmVHhfORO3v8+SGUJq1OWkJk4YEDXBFIjsEskU=;
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1j57X3-00CiLg-CH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 12:35:51 +0000
Received: by mail-pf1-f196.google.com with SMTP id b185so1136133pfb.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Feb 2020 04:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uyerPeK9P8LqDlV7LqFL68c1sT2T1cP6gBnBuIAjadc=;
 b=DH263imKuVYHuV7EPkqh1eCSelnzcxPWxEzuOsU3MCY3TYDfuO7Nw2xSXuTBxCvKqU
 PV4ReVe9Ez5GMFdMKV60cvkjNGSA30SJhBQERM6jcTGT7YyFOTx55Sn8jBN5jauV0mbO
 PVlFmsHTaxcwByzlq653WpLCkV6XCuXOVqfmtnE899xmEZT8yck8t9Bg6na0TVR9qa6I
 1q/y8RyuYd8LoGbJozNSNdjIWRYNapZrDW4+y8WoB6OJMeEL/DFJe4jSdjbGRZFDRsCo
 NcLn+fhFFUU6iGm8zPJuscczpWxP7kC11r/MBHqAXx986E1VN/5ag6lTlXC2tdBcnOTO
 Dg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uyerPeK9P8LqDlV7LqFL68c1sT2T1cP6gBnBuIAjadc=;
 b=Zuu2fno6dHu8flHt956Pw0OR90v2T088V+Wgby9OrtY/sRcKNTEbzbt0TmTEh4HUBn
 vTteXNY1YlktJa0SGM6hYR/1IVV0/PypSToicH9lwCQOYN2sG98eGQEpgK9w2tSQ6ztm
 Y/vZkFwyU+Rn/7Zuooucy7yL0C+EYHsMjgVWhT1I0BVrXS+PCMCdwfpjpkwwivlZMjgK
 vC6JV5NtWe03GICaGCvcSalGc2LbWnCEWp0u/vuTKzPfZYryeN/jHu64U7DJUxknBGET
 SKXj3xqbb8ge+/5UPVt5HMQyFQMTXdXtMydT97RLBYX1V3P7xmp5M1GJQljFyHo6MSjF
 rT+Q==
X-Gm-Message-State: APjAAAUx7Ff6KwVo849e5THL3t99pB0usQurWZqVlcfU63glHmtsBhAI
 gLhsShHh4NQEZbrvrxIqHpZh4gEA45Relw==
X-Google-Smtp-Source: APXvYqy4UbSXqOZGpOmD7o9lFGwKmBa5kKvuV+uXccjEFuj1rsjXLaJzspJLLddDZl/DDXo6gKy6HQ==
X-Received: by 2002:aa7:979a:: with SMTP id o26mr37568002pfp.257.1582288236069; 
 Fri, 21 Feb 2020 04:30:36 -0800 (PST)
Received: from google.com ([2620:15c:201:0:7f8c:9d6e:20b8:e324])
 by smtp.gmail.com with ESMTPSA id r12sm723387pgu.93.2020.02.21.04.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 04:30:35 -0800 (PST)
Date: Fri, 21 Feb 2020 04:30:30 -0800
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20200221123030.GA253045@google.com>
References: <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
 <20200201005341.GA134917@google.com>
 <20200203091558.GA28527@infradead.org>
 <20200204033915.GA122248@google.com>
 <20200204145832.GA28393@infradead.org>
 <20200204212110.GA122850@gmail.com>
 <20200205073601.GA191054@sol.localdomain>
 <20200205180541.GA32041@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200205180541.GA32041@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1j57X3-00CiLg-CH
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Inline Encryption Support
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
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Kim Boojin <boojin.kim@samsung.com>, Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Christoph,

I sent out v7 of the patch series. It's at
https://lore.kernel.org/linux-fscrypt/20200221115050.238976-1-satyat@google.com/T/#t

It manages keyslots on a per-request basis now - I made it get keyslots
in blk_mq_get_request, because that way I wouldn't have to worry about
programming keys in an atomic context. What do you think of the new
approach?

On Wed, Feb 05, 2020 at 10:05:41AM -0800, Christoph Hellwig wrote:
> On Tue, Feb 04, 2020 at 11:36:01PM -0800, Eric Biggers wrote:
> > The vendor-specific SMC calls do seem to work in atomic context, at least on
> > SDA845.  However, in ufshcd_program_key(), the calls to pm_runtime_get_sync()
> > and ufshcd_hold() can also sleep.
> > 
> > I think we can move the pm_runtime_get_sync() to ufshcd_crypto_keyslot_evict(),
> > since the block layer already ensures the device is not runtime-suspended while
> > requests are being processed (see blk_queue_enter()).  I.e., keyslots can be
> > evicted independently of any bio, but that's not the case for programming them.
> 
> Yes.
> 
> > That still leaves ufshcd_hold(), which is still needed to ungate the UFS clocks.
> > It does accept an 'async' argument, which is used by ufshcd_queuecommand() to
> > schedule work to ungate the clocks and return SCSI_MLQUEUE_HOST_BUSY.
> > 
> > So in blk_mq_dispatch_rq_list(), we could potentially try to acquire the
> > keyslot, and if it can't be done because either none are available or because
> > something else needs to be waited for, we can put the request back on the
> > dispatch list -- similar to how failure to get a driver tag is handled.
> 
> Yes, that is what I had in mind.
> 
> > However, if I understand correctly, that would mean that all requests to the
> > same hardware queue would be blocked whenever someone is waiting for a keyslot
> > -- even unencrypted requests and requests for unrelated keyslots.
> 
> At least for an initial dumb implementation, yes.  But if we care enough
> we can improve the code to check for the encrypted flag and only put
> back encrypted flags in that case.
> 
> > It's possible that would still be fine for the Android use case, as vendors tend
> > to add enough keyslots to work with Android, provided that they choose the
> > fscrypt format that uses one key per encryption policy rather than one key per
> > file.  I.e., it might be the case that no one waits for keyslots in practice
> > anyway.  But, it seems it would be undesirable for a general Linux kernel
> > framework, which could potentially be used with per-file keys or with hardware
> > that only has a *very* small number of keyslots.
> > 
> > Another option would be to allocate the keyslot in blk_mq_get_request(), where
> > sleeping is still allowed, but some merging was already done.
> 
> That is another good idea.  In blk_mq_get_request we acquire other
> resources like the tag, so this would be a very logical places to
> acquire the key slots.  We can should also be able to still merge into
> the request while it is waiting.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
