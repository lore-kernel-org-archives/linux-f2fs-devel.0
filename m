Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF24C982FF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S63QS5++SvhAd9wTex53Nmim+PbLNZuT0Q4uU0aY0uU=; b=jLIFivCrbctEBP+wmswrC6vssi
	TBwx+UmsSbwf/Gp+gldFw9SbUyF4FmZmqC0Vg4xA75bDgVfAvYYmzHLoqBLcvMjQzafDf+rn2lqeW
	0CIwgjSK4mW+pmod6+FRyywc2IEQ/TCGz3J6FjOaRFlPyCRGD/Y0pVUNWgSkIfydnzII=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8wNC-0006Mc-HT;
	Tue, 22 Sep 2026 09:01:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1x8wMx-0006GM-Sj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8YJMnxCx7h1aVciSzhmVbEN46xY6rfHQRJ4daqV9A0s=; b=Kh2+hScaKG0Mp4g38oL8GKLycq
 gpaPE9jWDOLcM+fWcWQQZXpIzwZujOk9if/YweiAHq7nvvIY1UfwaMx56bei0Hw5MJdnDNaipSkSm
 5mTls4r17JO78L0tgKY7a2EJ+0SWO/lQ+AOpE3apeI/IPTckZNkKT04n+uQ9wvFM/eT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8YJMnxCx7h1aVciSzhmVbEN46xY6rfHQRJ4daqV9A0s=; b=bU+0uTt3/1qurh4MzHXtwQBjJl
 TI94H5BlX/d7yq8Gw4tWe5VaD3Z8USgIpSdrwR6YxcuvHbiia83tz0NWO8MTNeBXUs/l/oFoPVzWQ
 z+gcJsbvA2LApvKZ44SJBJV1QdwRyYPpWYdQK1Zk/JQtwO8OUHt64xgW3SVdXzhyptNY=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8wMf-0003ja-D7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 09:00:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790067631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8YJMnxCx7h1aVciSzhmVbEN46xY6rfHQRJ4daqV9A0s=;
 b=Mt2dS8xRYTr9oIgvGetgqP7OKLcDuHWX2FRcg0QBT6GZu5CnrbQJ1yj0DCjN9ttHTNgjx7
 1jJQ+2Km0m8igKMqg1zfI8iydd3K/f8wWyS0QZUJ6obfPvMGxBfjQS7ax4oW9eI+PqDkmb
 DFRoJRnzvNrbqhnW5kXJp2aQt+fy7Bw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-7Z7da1hhMr-OiJDziQkl9Q-1; Tue, 22 Sep 2026 05:00:30 -0400
X-MC-Unique: 7Z7da1hhMr-OiJDziQkl9Q-1
X-Mimecast-MFC-AGG-ID: 7Z7da1hhMr-OiJDziQkl9Q_1790067629
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c25edb54d22so469649366b.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 02:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790067629; x=1790672429;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8YJMnxCx7h1aVciSzhmVbEN46xY6rfHQRJ4daqV9A0s=;
 b=w9utL/tljiBQdwjDq4ve/iPtTLQ9yJCX81UIJvTz7pIHf7t/Fqjj0/a2i1p9ozo5IM
 +imPPpBXU3rTOhL4DV1QO07UcvnQFNB6JZF/I9IEGYZp3rLfQixf+C//1ljyUjcvhNyD
 xjjKVh2Tke6N+aN3BRBsGsdF+hT454kN9lS8U3+2ThFuT4MbqQ0gBQbWgAurzZw70ij6
 zGtorDjvK49AvTFXV+ApQtIMfyYkYju/bOzGOld1ZhxfVX4sjaiivSFeyAyagMbSqcaO
 10F8S2EKZKR+2P6uQHP4QLHU9B+A6umGOPd/qEWi+ivb3xgmY4LA4+PnMDTjbZ164SF/
 aMBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkG/v+q0pvlyMAJhs0XUUoQQPAu/Gia/fRG6r74qKfvMLnejXJZYbz2tazx3oRtw40hQZyyFovM3IgnDdUCP2g@lists.sourceforge.net
X-Gm-Message-State: AFuF++mH9KXE50RP9HpC8PYZpxsPzovy4zjaYNcSuQb38wRI5nnWNTxK
 EVIHM56XAto2CfXmjYSp9IwpMzBSqyp71FPIOVokqMNNWuxG4A4lC7UyuZpbgSaR1SGjSyyKTWx
 +n6R/5tBVrtlfPP9MXc9+EebIRW/uGOoGJADxk57jrhIKcTo/b+QAWUWwUsYoTmsPxU79scYHmZ
 NPxg==
X-Gm-Gg: AYBFou1GA2LUi1q5L0MbHPeO1AZe5cvdAviYyGd6GuRwThUL3LrK5F9UVf3gFjJF58u
 OxDQuLpDoRJb6hbP+a6LSsTzWoLurZAadjF8Q8m9Podel1cicuza9W3nspdN95zYvF0WETKYM/u
 GGRhk8xVnXGiUxFKraT6oxV9FNMC/7jXiDXjcjnWc1NpitP3QAi16JvSXB3fniYJhWRJsWRvySE
 /wZwvvPkYthmYyKM0rPqIoH10eRc6TPdsoKq54ytOVOp23Bvjs5vpXTYGmPmrKi3+4y6p9bBn/X
 5FGlM5J1ZH/3YpqzviFlDfCgIJi0tIEEvu2xnR/K0rcj820mmxaTmcJTHc7tiyptf1jWX9/kzGW
 FQtBMoxXohwZ63rNgFk8kH36U8V3DPHrP6w==
X-Received: by 2002:a17:906:9fc1:b0:c29:4a1f:76be with SMTP id
 a640c23a62f3a-c2a15703413mr1217335566b.20.1790067628387; 
 Tue, 22 Sep 2026 02:00:28 -0700 (PDT)
X-Received: by 2002:a17:906:9fc1:b0:c29:4a1f:76be with SMTP id
 a640c23a62f3a-c2a15703413mr1217326266b.20.1790067627294; 
 Tue, 22 Sep 2026 02:00:27 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a9c4309c7sm51460566b.6.2026.09.22.02.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:00:26 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:00:26 +0200
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <arJC542mXklAeswE@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260922045144.GP2705364@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20260922045144.GP2705364@frogsfrogsfrogs>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sB7pehORnnx2bsg-evUxcPGTT56CcMNPMysVdU35Ve4_1790067629
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1x8wMf-0003ja-D7
Subject: Re: [f2fs-dev] [PATCH v16 00/21] fs-verity support for XFS with
 post EOF merkle tree
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-21 21:51:44, Darrick J. Wong wrote:
> On Fri, Sep 18, 2026 at 01:15:12PM +0200, Andrey Albershteyn wrote:
> > Hi all,
> > 
> > This is next revision of fsverity for XFS.
> > 
> > The main change from v15 is addion of kmem cache
> > xfs_fsverity_ioend_cache instead of adding work_struct to iomap's ioend
> > struct.
> 
> FWIW, Sashiko found at least one or two bugs, but the reports only got
> echoed to the ext4 list.  Perhaps it's time to discuss allowing it to
> email linux-xfs for bugs that it claims to have found in xfs code?

I'm checking its report for fsverity series, but for other patches
not that often. So, maybe it would be useful for "critical" and
"high" priority issues (not sure if it's possible to configure it
that way).

*this time sashiko sent me a bunch of "no regression found" emails
which I think are not necessary

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
