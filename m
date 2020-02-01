Return-Path: <SRS0=Xl6b=3V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2EDC33CB7
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  1 Feb 2020 00:53:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FF920661;
	Sat,  1 Feb 2020 00:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="UkAT2jSd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="j2kBAISQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fN70rAkA";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="AlBMjDdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FF920661
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XtAtUM7F4qWqeopQGkHNJkvrwgBDJRxyCdBYfrQFZkM=; b=UkAT2jSdrnNerwky7Gjr6ie90
	RhiKUUtwflDNg6mYY7q2mc9zXY48to0fD0jVuHIsZkXR7VlbdZXN/kMiJCmTX+BkNr2NlKCbgonLw
	YTNRMiG8B5i9cxNDJapuaBINQuBqS7eN1E9uJgQHmTMiJQpvLeARRJvpLMVH9z5gRaMfM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ixh2p-0000WV-KI; Sat, 01 Feb 2020 00:53:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <satyat@google.com>) id 1ixh2o-0000WK-Gd
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Feb 2020 00:53:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tc8ar+zPlE2mflta9AzRevX9yYQr1iSscRoF7kXeb8o=; b=j2kBAISQp/ce8gwxeSW/4BR/3H
 9AqaV4wK4Q62HNv/H6VDCoyKVmmGmp/EzHFQsbhV7a5DxSrgaU8O3dm6B8yCcy+sV72XTshRUH/vt
 0NaApZxnl6QukKcnTETqy2eT1UKoY7gakwIvzRGXtd0xURN5hEJrIiT4dmiqeuL6uT4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tc8ar+zPlE2mflta9AzRevX9yYQr1iSscRoF7kXeb8o=; b=fN70rAkAx+Gkf53vQYmF3C4Fow
 7u3plaUc7XKxN5cE4OITvgCy54KcHKZwloHM1zCPrhxymistKC9SqBoLzWX1TH+8po8frTUP1pL7n
 pFJbWuQs0KZZ8rrRBnU62ErwFp+U1eZmTRbijNNldW4yByhvOxcDONaZJ1b31RHnggM0=;
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1ixh2m-00Ces3-L1
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Feb 2020 00:53:54 +0000
Received: by mail-pj1-f68.google.com with SMTP id m13so3778282pjb.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 31 Jan 2020 16:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tc8ar+zPlE2mflta9AzRevX9yYQr1iSscRoF7kXeb8o=;
 b=AlBMjDdvPjgeI/eGL89AQ49XgQmrU/+1ozzmtDR5dHvi6yoogM7awYpQ3BkwGcbVYV
 M1s+faeZNiOPts5oOD18nSVaEWe6Tq0280wPaPZ44Sf4nlvLTmFmvire62nOSnezG8V3
 kB7Yi8Esmzg+8masoI44VX1hQGDU3cIbjAw9eSnbhVR3+mjaXQjImZ+IRzqvaNxg5VMf
 Uu7wzxAXhTW9dGMMKwq5ISWZd7sJ2JO4ROUIIDfNvsadjrfkihOshvSZ1wGG/XLoTVaj
 PeXXkLr9E0nrKxD7VqSS2R1o5f+DfDnXuyOIhtDKYQmc+JEkFwklNlkFtZ2fV/4X+S3d
 fJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tc8ar+zPlE2mflta9AzRevX9yYQr1iSscRoF7kXeb8o=;
 b=Kcxq9+4VkhXVaU3QQ11xZtnr++icH/FijETdlFN+cGxg0onvdbxOKm+0sqdKPn1gYU
 ZdJDTsbFoiqL/+iSNJhnHsJw1ZgekTsqhUra1+SMp5F6DyawKDmzFstQCAZdrPPBbMuu
 Fs7thCmow7UGWSh7C/Axm6W4SDgleKVtAeslk1MDbLOnj2jEYgkUcPcptEjorptc/BVN
 Ajo51Y1KIGBb41nuDr8elpMWAcCXvpPyB8Ssr58zhwVnPFzRp3ukAzREHlUH59z7WTiy
 u/veYPjE851Q1KHJgdhw2Q4filBIT22oZTfftr0Ecgp2etZwhX1DsjREPmgBfX4HPQDQ
 YE+w==
X-Gm-Message-State: APjAAAX3Chi1poRxM/3SHp8VjjUGaKx1IYSofB/J2CqBI+NmB7YrASF+
 UT5tEpby89b/QkyNmQ0xeWxGuQ==
X-Google-Smtp-Source: APXvYqzikgNTMcmEplcDqmJyDdxwtw9uBCUErp4noGehjtNn15shqpInHU4QEVPviXn1v7bNUq4q3A==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id
 b44mr15962672pjc.9.1580518426468; 
 Fri, 31 Jan 2020 16:53:46 -0800 (PST)
Received: from google.com ([2620:15c:201:0:7f8c:9d6e:20b8:e324])
 by smtp.gmail.com with ESMTPSA id p24sm11163167pff.69.2020.01.31.16.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 16:53:45 -0800 (PST)
Date: Fri, 31 Jan 2020 16:53:41 -0800
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20200201005341.GA134917@google.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200117085210.GA5473@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1ixh2m-00Ces3-L1
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 17, 2020 at 12:52:10AM -0800, Christoph Hellwig wrote:
> Hi Satya,
> 
> On Wed, Jan 08, 2020 at 10:43:05AM -0800, Satya Tangirala wrote:
> > The fallback actually is in a separate file, and the software only fields
> > are not allocated in the hardware case anymore, either - I should have
> > made that clear(er) in the coverletter.
> 
> I see this now, thanks.  Either the changes weren't pushed to the
> fscrypt report by the time I saw you mail, or I managed to look at a
> stale local copy.
> 
> > Alright, I'll look into this. I still think that the keyslot manager
> > should maybe go in a separate file because it does a specific, fairly
> > self contained task and isn't just block layer code - it's the interface
> > between the device drivers and any upper layer.
> 
> So are various other functions in the code like bio_crypt_clone or
> bio_crypt_should_process.  Also the keyslot_* naming is way to generic,
> it really needs a blk_ or blk_crypto_ prefix.
> 
> > > Also what I don't understand is why this managed key-slots on a per-bio
> > > basis.  Wou;dn't it make a whole lot more sense to manage them on a
> > > struct request basis once most of the merging has been performed?
> > I don't immediately see an issue with making it work on a struct request
> > basis. I'll look into this more carefully.
> 
> I think that should end up being simpler and more efficient.
So I tried reading through more of blk-mq and the IO schedulers to figure
out how to do this. As far as I can tell, requests may be merged with
each other until they're taken off the scheduler. So ideally, we'd
program a keyslot for a request when it's taken off the scheduler, but
this happens from within an atomic context. Otoh, programming a keyslot
might cause the thread to sleep (in the event that all keyslots are in use
by other in-flight requests). Unless I'm missing something, or you had some
other different idea in mind, I think it's a lot easier to stick to letting
blk-crypto program keyslots and manage them per-bio...


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
