Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126A2C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PY4xXV0XGNIhNWXLs4mNorKMutdhDuJd2re4vx4TFig=; b=kMG2oyTTdvceJkyCG693UaHUOX
	SVEOVDR6E3WTsjGB7efUc8hU1ElACDuKIAlG7qHmm0kYWKlLXhbC1JaZFRzL88cuiq6RqnPzTzoFz
	WVE/3kuLmaTzkW7kUjpcbKDtCXrQmPuS4O9nNHVD3I4Zhyyh+0L7I/XxUPrVVe0Gt04c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woaiI-0000Bv-Ru;
	Tue, 28 Jul 2026 05:50:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1woaiH-0000Bo-Ja
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 05:50:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RSQlSZ74tUvUSC0pLiC2vJIgfUaYlvS5eLq7/7sfks=; b=SKQIXeGPe8Z0D1Sd0kWlhfcVlx
 S73miPF6u0Ylj0WX2UcuNbIBOGTs6Zf2xHMM2eg/NzOSHIM8EM60ublxgN8rVuGR+OodilOVQWu9I
 n1mdCrit0rhf7rjyEG6AFkyLPjDADjz/udW8PhXWEQSg4TQSVHnXJcCDxNpupG7wmtAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7RSQlSZ74tUvUSC0pLiC2vJIgfUaYlvS5eLq7/7sfks=; b=nDj5GuKDzdkDmBCWb4NHEcIdxk
 y1G/WS9GguZXjXukYM+9OpluC/nzFvDxB3wCCj6Lz7aXzrveKqlASaBTaG3E0GzZ0sOeABCjKeywz
 cT/iVAqahR20ciFJlFnDij/MArfUdjlPBp4moL2ra/jXxX8B+C5WNTczz3XoW+S4luRQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woaiF-00084X-P5 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 05:50:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E483960A62;
 Tue, 28 Jul 2026 05:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5175C1F000E9;
 Tue, 28 Jul 2026 05:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785217841;
 bh=7RSQlSZ74tUvUSC0pLiC2vJIgfUaYlvS5eLq7/7sfks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VKV0GyIjK0GL4FtieY77ZquJC4YCLVOOeIePgpFVQtZ9FE8QwEl3XkYUCBacc63Kd
 bhX5juOiJVyrnkYjGP4FCXg6+R6tiCKn6hlpoQY350cHeC56BcpWXV0ozB5l8dhdKH
 NGyExdX52ZCRm2DhlM/zqxWLMS2Ohsbt5pCYVgYbozmFx6GasQoqiKVbmLmIqH7wfJ
 nSGTo/mn0kEWS1Z/uqitZTNAzSnJeOtzH1gMBBcqHFPWeJxt55V79/js1dowNtioQH
 Hu1bT/qlVCKKKPqafvWZsCPKTqZByyk7xQ52ChMJWjlOQKTbSgYMoFdgXSZVCLknTJ
 muZQaurdChR/A==
Date: Mon, 27 Jul 2026 22:48:47 -0700
To: Daniel Vacek <neelx@suse.com>
Message-ID: <20260728054847.GB99797@sol>
References: <20260724133328.1837318-1-neelx@suse.com>
 <amgfuk12imPN2XJe@infradead.org>
 <CAPjX3Fd1KPswrsNe=BeDpkDwi8CmL9HNKcPScMsgGN16MDyVEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPjX3Fd1KPswrsNe=BeDpkDwi8CmL9HNKcPScMsgGN16MDyVEQ@mail.gmail.com>
X-Headers-End: 1woaiF-00084X-P5
Subject: Re: [f2fs-dev] [PATCH 00/12] fstests: introduce fscrypt support for
 btrfs
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-xfs@vger.kernel.org, djwong@kernel.org, zlang@redhat.com,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 28, 2026 at 07:44:37AM +0200, Daniel Vacek wrote:
> On Tue, 28 Jul 2026 at 05:19, Christoph Hellwig <hch@infradead.org> wrote:
> > On Fri, Jul 24, 2026 at 03:33:16PM +0200, Daniel Vacek wrote:
> > > This is a rebase and cleanup of older patches [0] from Sweet Tea and Josef
> > > fixed to work with the recent kernel and btrfs-progs changes.
> >
> > I'm not sure if you post this just for reference or what the intent here
> > is, especially with a cover letter like this that doesn't have much
> > information.
> >
> > Before we doing anything for the btrfs-specific fscrypt changes in
> > xfstests, those changes should be accepted upstream first.
> >
> > Maybe some thing like splitting tests might make sense without that,
> > but then it should be posted separately.
> 
> Hi Christoph. Thanks for looking into this.
> 
> Yeah, I could have been more verbose, perhaps also using an RFC tag. I
> wanted to get feedback and a review from a wider audience to see if
> this is a viable direction. This is currently the base for my btrfs
> fscrypt development testing.
> Especially for upstream fscrypt changes, when sending those patches I
> was asked about tests support. I understand to keep fstests OOT as
> long as the kernel part is in development. But at the same time I'd
> like to make fstests complement the kernel part and ensure they are
> ready and available for everyone throughout the process. Kinda to
> "bundle" them all the next iteration.
> 
> Would you suggest otherwise?

Please keep sending out the tests along with the kernel patches.  But
yes, they aren't for immediate merging and should be tagged with RFC,
and the cover letter should mention that the kernel patches are pending.
Thanks!

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
