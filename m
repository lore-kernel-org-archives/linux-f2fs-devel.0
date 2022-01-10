Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32C2C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jan 2022 18:45:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n6zfo-0005Tl-O6; Mon, 10 Jan 2022 18:45:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <peterz@infradead.org>) id 1n6zfm-0005Tf-OE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 18:45:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ttn+yS73TigEPGpcw2iqzr9CnaebrsST4PVtbMFaqN0=; b=jRhoPMytpBeWv8DBmQEaEG61cJ
 SQzNs/Wm/yDztLIDZEewIUuPiBABIHKMSchHxHIzAdunUhSgtS740jX3Mu3Yn0+y7/NuAQ3sGELrF
 tYnmD0QzCcGEjVmHADbLhJuO6Q8A1nIuYKY3sbQ12ELjyv3cL35w5qiH/srNCqVEOoXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ttn+yS73TigEPGpcw2iqzr9CnaebrsST4PVtbMFaqN0=; b=aaJkTfsYxdy2s2Rk6d8+tI57pC
 pa7cRLybg4RQ9CWg+uNYydVJptlKYzlOnHut4hq46Tx2gOhgmqjjiU2/kS6im4TrH1GUPuHtE0Q8y
 wRsgHprYV7FZ4atPhMSXzudhXVhltJ7VQag4iz+pYlsN9walrBjVfHjD4AU2u9+l7kDI=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n6zfk-00Ao7Q-3Y
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 18:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ttn+yS73TigEPGpcw2iqzr9CnaebrsST4PVtbMFaqN0=; b=KsFSWNgo4t73Sb74XHFILkTFLp
 eQfaEjBlx8U9z6Z4isrZ6ltYnzBzsuV7f5K8AaPiFmA8W11fB6AwP3o1bR6IRuyCU/gTC7U9SXirn
 9a10lf/iK1/tPtZsq3ZgVwzjsYYrx2y3FTT/pDC8LlfkZ6c6cII/syS/1NbbtWQIDv7yZIcO8heeU
 HWwIjRRrjyoorgyHIez7YHr9BCjvvHGEGfV0zO/i6rlQcrbVvqncq/RR1Qd22Hqe8WLfX/x2r+zdZ
 D6e9X1VpcSAKfCsYLWzxrOnghBrupzPK+IMr6sl5N+pKx6wU7ITnbNDMiz6vlVkf9zmavFSBKX+yX
 S5XNJ/lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n6zfR-002eHC-TG; Mon, 10 Jan 2022 18:45:18 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9ACF0300079;
 Mon, 10 Jan 2022 19:45:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 846AE284872AC; Mon, 10 Jan 2022 19:45:15 +0100 (CET)
Date: Mon, 10 Jan 2022 19:45:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Message-ID: <Ydx+u9YpzS8AZHrl@hirez.programming.kicks-ass.net>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
X-Headers-End: 1n6zfk-00Ao7Q-3Y
Subject: Re: [f2fs-dev] [PATCH] f2fs: move f2fs to use reader-unfair rwsems
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
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Tim Murray <timmurray@google.com>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 10, 2022 at 11:18:27AM -0500, Waiman Long wrote:
> 
> On 1/10/22 03:05, Christoph Hellwig wrote:
> > Adding the locking primitive maintainers to this patch adding open coded
> > locking primitives..
> > 
> > On Sat, Jan 08, 2022 at 08:46:17AM -0800, Jaegeuk Kim wrote:
> > > From: Tim Murray <timmurray@google.com>
> > > 
> > > f2fs rw_semaphores work better if writers can starve readers,
> > > especially for the checkpoint thread, because writers are strictly
> > > more important than reader threads. This prevents significant priority
> > > inversion between low-priority readers that blocked while trying to
> > > acquire the read lock and a second acquisition of the write lock that
> > > might be blocking high priority work.
> > > 
> > > Signed-off-by: Tim Murray <timmurray@google.com>
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> We could certainly implement a down_read() variant (e.g.
> down_read_lowprio()) with its own slowpath function to do this within the
> rwsem code as long as there is a good use-case for this kind of
> functionality.

I think _unfair() or something along those lines is a *much* better
naming that _lowprio(). Consider a RT task ending up calling _lowprio().
That just doesn't make conceptual sense.

And then there's the lockdep angle; the thing being unfair will lead to
scenarios where lockdep will give a false positive because it expects
the r-w-r order to block things, which won't happen. A position needs to
be taken a-prioriy.

But before all that, a sane problem description. Can't propose solutions
without having a problem.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
