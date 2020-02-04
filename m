Return-Path: <SRS0=hAFL=3Y=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C236C3524A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Feb 2020 03:47:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB4E2080D;
	Tue,  4 Feb 2020 03:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="MdVJNFy4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="H2dYroHC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="XlLFaCoz";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="V35oksgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB4E2080D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2Xo9sMFu11t2vxVXuKgG1R0pSb5oKqdqTETj7ACqHZE=; b=MdVJNFy4vqzIkCO4/q9Yc1VWY
	CfJdMtUXzsl6lJ0DpCfPsT91qZ/KPxnaDPR2hofxOYTlB4j2W5DUqOXVyRYu9u/thfxBHXf9NtB9e
	Ul2iA9SYnoFp95TeseSbBEs6AfWkTO8AnacXJsrSEg88z+AwKPsazZJNV7iPYpkDEq6us=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iypBE-0004zX-MF; Tue, 04 Feb 2020 03:47:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <satyat@google.com>) id 1iypBD-0004zP-Aw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Feb 2020 03:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mPedbGLBNu2L3k6HSm0HBzkbV9veK3pUwD/I6GC5AJI=; b=H2dYroHCkljZEAK594wGcHeFa8
 T0DYlPMt7Ffn89zb9LMoQ29aQeRCgDHd7cGiPAmTwV7/EkNkBz/z4c0gc8hgppX0FuOOs7LXtzzT9
 zU8YA32eCcPq+j3RvsoTM0X4DSWCpcrsAAiNe565jIG1bu5QmoqONd1E8lfFGyLQdwCA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mPedbGLBNu2L3k6HSm0HBzkbV9veK3pUwD/I6GC5AJI=; b=XlLFaCoz4mKfTjXfpVPI/L+v0x
 +0g4IF2RjOs1NtWhIJuXVmXMursx8vshUIYzcEFbHwdkvMpgl/e4cH8uerQmSThb68hL4y3PrEb23
 TrUGtB/+2bs3BQMZ+T/eUrbBCjLjxamRNSiNfIBaFJNHllqCBwZ6kzqCVVpfwE1DBPS4=;
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1iypB8-00G7jy-L3
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Feb 2020 03:47:15 +0000
Received: by mail-pj1-f68.google.com with SMTP id m13so743860pjb.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Feb 2020 19:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mPedbGLBNu2L3k6HSm0HBzkbV9veK3pUwD/I6GC5AJI=;
 b=V35oksgSkm4ljAJXfpnCVS3GtTn17dSUeg2MvjUD8k9o4vbf9KU6/80bq/BynnK1Qf
 IsJGGcd5RzKRTU+nuDS2OYIOc9FrCpdpjRZyPBPFE4VGdh8TVYGf/KZWj18ekArH9rB1
 w8p1F8d+QpPkaiSpRGyBDkj03c0jf2DQ57xf2Mxcugwiy69Pm15KEyOVkkUu7FV9znsq
 UVvWnmAFcbKMwQUVUJe/J9SizvP5DudE2sXnJ5u1ewncR+bSgjEEpmtsP8PzxWChcBCK
 6pM/4UvjdlaLkbLMTSJpg7PKD37OS6sT9PM/ja7gJe1oJXxJfSA2WaA9rGwsQ7HAVGGd
 1tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mPedbGLBNu2L3k6HSm0HBzkbV9veK3pUwD/I6GC5AJI=;
 b=nOljfBfY0Uer6C80IwePwCg7ViLQzv00J+/Rhxtt6yKUIfsbyOERzVMtiE0Gy9n9Rf
 bA33qFV3kpYGUSbmaUEV5EXRoaspUDyo6DhtG4nQqjfbIUZx75Pa6n2ZBDyuWFfafHlo
 vghJLiIllJ9TdSDekm/2CVfS+k173kYr2302UO7YhNnKV0UCTKUQh4JwQ1z+K2tJku5H
 sXxHLS9B2QDd6JYGJdD0R8e2ZoktBDsXpdO/M/TKJoM2fXdU8LOV3bXtGy6VQJRn6rFU
 PiwiuTvf7vrzpJn8sMLiBSIj/iHdnUc8xQUes0qc5VO11qJGloBOwmr8qsi2irDYc1ZQ
 iMFg==
X-Gm-Message-State: APjAAAVdzeUtzTexF3nDehSMTmdVn7SvL3yApDLXrmbjCWOa36wmPAK5
 1bsUGLxqDPR+3thgDMC0l1hxfWPBClp7vA==
X-Google-Smtp-Source: APXvYqw1B1BjXGg0r30M6wu7yNLM6kBYQXBj/o7bHXB1/TSf0blx3HAUudnmN5lGww82QU4/vn4Bug==
X-Received: by 2002:a17:902:8b85:: with SMTP id
 ay5mr25055691plb.253.1580787560953; 
 Mon, 03 Feb 2020 19:39:20 -0800 (PST)
Received: from google.com ([2620:15c:201:0:7f8c:9d6e:20b8:e324])
 by smtp.gmail.com with ESMTPSA id g10sm10397099pfo.166.2020.02.03.19.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 19:39:20 -0800 (PST)
Date: Mon, 3 Feb 2020 19:39:15 -0800
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <20200204033915.GA122248@google.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
 <20200201005341.GA134917@google.com>
 <20200203091558.GA28527@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200203091558.GA28527@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1iypB8-00G7jy-L3
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

On Mon, Feb 03, 2020 at 01:15:58AM -0800, Christoph Hellwig wrote:
> On Fri, Jan 31, 2020 at 04:53:41PM -0800, Satya Tangirala wrote:
> > So I tried reading through more of blk-mq and the IO schedulers to figure
> > out how to do this. As far as I can tell, requests may be merged with
> > each other until they're taken off the scheduler. So ideally, we'd
> > program a keyslot for a request when it's taken off the scheduler, but
> > this happens from within an atomic context. Otoh, programming a keyslot
> > might cause the thread to sleep (in the event that all keyslots are in use
> > by other in-flight requests). Unless I'm missing something, or you had some
> > other different idea in mind, I think it's a lot easier to stick to letting
> > blk-crypto program keyslots and manage them per-bio...
> 
> But as far as I understand from reading the code it only sleeps because
> it waits for another key slot to be released.  Which is exactly like
> any other resource constraint in the storage device.  In that case
> ->queue_rq returns BLK_STS_RESOURCE (or you do the equivalent in the
> blk-mq code) and the queue gets woken again once the resource is
> available.
Wouldn't that mean that all the other requests in the queue, even ones that
don't even need any inline encryption, also don't get processed until the
queue is woken up again? And if so, are we really ok with that?

As you said, we'd need the queue to wake up once a keyslot is available.
It's possible that only some hardware queues and not others get blocked
because of keyslot programming, so ideally, we could somehow make the
correct hardware queue(s) wake up once a keyslot is freed. But the keyslot
manager can't assume that it's actually blk-mq that's being used
underneath, so if we want to get the keyslot manager to do something once
a keyslot was freed, it would need some generic way to signal that to
blk-mq. We can also just wait around for the queue to restart by itself
after some time delay and try to program the keyslot again at that point,
although I wouldn't want to do that because in the current design we know
exactly when a keyslot is freed, and we don't need to rely on potentially
inefficient guesswork about when we can successfully program a keyslot.
Maybe we're alright with waking up all the queues rather than only the
ones that really need it? But in any case, I don't know yet what the
best way to solve this problem is.

We would also need to make changes to handle programming keyslots in
some of the other make_request_fns besides blk_mq_make_request too
(wherever relevant, at least) which adds more complexity. Overall, it seems
to me like trying to manage programming of keyslots on a per-request basis
is maybe more code than what we have now, and I'm not sure what we're
really buying by doing it (other than perhaps the performance benefit of
having to get fewer refcounts on a variable and fewer comparisions of
cryptographic keys).

Also I forgot to mention this in my previous mail, but there may be some
drivers/devices whose keyslots cannot be programmed from an atomic context,
so this approach which might make things difficult in those situations (the
UFS v2.1 spec, which I followed while implementing support for inline
crypto for UFS, does not care whether we're in an atomic context or not,
but there might be specifications for other drivers, or even some
particular UFS inline encryption hardware that do).

So unless you have strong objections, I'd want to continue programming
keyslots per-bio for the above reasons.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
