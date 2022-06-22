Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED27C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jun 2022 16:58:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o43gY-0004pZ-4X; Wed, 22 Jun 2022 16:58:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1o43gW-0004pT-V3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 16:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pLyj4FHkOYdCTm0RLUnb49P5W2d0CbZlblIjkf6bk2A=; b=G0JwfFgyEHXjlq9PC4Yn4bmhCo
 L9eHCNobexxsAzNwS590LFbEa8fi16uZQKcj2izn6xiCqNE4KuZ5pkO1wOh07pWOOmn29YKGslvyQ
 iTqfh7mUrKzu4MVhNIFufLfD4sthZU1JaNtVmdMSh5ZWf77ctAYxwTlzlXsMwZO8moUE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pLyj4FHkOYdCTm0RLUnb49P5W2d0CbZlblIjkf6bk2A=; b=Xfqfzn4daamMhUpjKg6YLnkNBh
 dGmGvTyg4vuvwkNs8D/uhoGTpCtQORjot3ZePcfLw681Qm5ZGF1I9S2ttuNTn9hZSTSgsY2K1M+Au
 xc2w2bNpYuaL4PLB//JsT5d4ogDaKJXhMmuGbbUXKHd7mPbfYFgtH7Ff8zwpVNpL+2ik=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o43gW-0003Iz-5S
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 16:58:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C6929619FC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Jun 2022 16:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19408C34114;
 Wed, 22 Jun 2022 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655917106;
 bh=jllQadT4DvrMRtLBTBYBV6S5D+eDKQDPfqSBRBCDFNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L1ISw55PclMBZPb6nTpyfWY6V110GgKc+EMpt7XWMIfYo6Fd0mXHqhTfA77igZvoF
 fo80oHxO5aQIxqEbznF/FuWRwhnx9lVbq9FKBdWwK8ysvnLzCpN9MxerSlT+3rTakq
 y9U4y56KYzMhf03XoT98uCh1gMx1kqzyRXo/Hzew45H+M9Yquvth1wTGGoqgnMv6/n
 vrGehsiVq53cLtIFEmdh3NrHN+kE+H6Vsvc+cKtZ0s9IzonqzWdLft2fKc5330TKmn
 tS6d/vdRB+wDr9OnnrNmts09Q9/B6o7X3aVP6+zrRyVfQWorsLndR7hrarRjsrbG4G
 PZB5Vk6PH1rJg==
Date: Wed, 22 Jun 2022 09:58:24 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YrNKMDAgB1/vtoxi@google.com>
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
 <20220617223106.3517374-2-jaegeuk@kernel.org>
 <c45a9c8b-c73a-76bc-6725-5d7e48e7a3f2@kernel.org>
 <Yq+kiXPyBsXgdYb2@google.com>
 <27138a10-a6b2-edad-1985-687a95b9039b@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27138a10-a6b2-edad-1985-687a95b9039b@kernel.org>
X-Headers-End: 1o43gW-0003Iz-5S
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: run GCs synchronously given user
 requests
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/22, Chao Yu wrote:
> On 2022/6/20 6:34, Jaegeuk Kim wrote:
> > On 06/19, Chao Yu wrote:
> > > On 2022/6/18 6:31, Jaegeuk Kim wrote:
> > > > When users set GC_URGENT or GC_MID, they expected to do GCs right away.
> > > > But, there's a condition to bypass it. Let's indicate we need to do now
> > > > in the thread.
> > > 
> > > .should_migrate_blocks is used to force migrating blocks in full
> > > section, so what is the condition here? GC should not never select
> > > a full section, right?
> > 
> > I think it'll move a full section given .victim_segno is not NULL_SEGNO,
> > as __get_victim will give a dirty segment all the time. wdyt?
> 
> However, in gc_thread_fun() victim_segno is NULL_SEGNO all the time.

What do you mean? The gc_thread thread sets NULL_SEGNO, which prevents
from selecting the full section. But, f2fs_ioc_flush_device will set the
segno to move, and f2fs_resize_fs calls do_garbage_collect directly.

> 
> I guess .should_migrate_blocks should only be set to true for
> F2FS_IOC_FLUSH_DEVICE/F2FS_IOC_RESIZE_FS case? rather than GC_URGENT or GC_MID
> case? See commit 7dede88659df ("f2fs: fix to allow migrating fully valid segment").
> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >    fs/f2fs/gc.c | 8 ++++++--
> > > >    1 file changed, 6 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > > index d5fb426e0747..f4aa3c88118b 100644
> > > > --- a/fs/f2fs/gc.c
> > > > +++ b/fs/f2fs/gc.c
> > > > @@ -37,7 +37,6 @@ static int gc_thread_func(void *data)
> > > >    	unsigned int wait_ms;
> > > >    	struct f2fs_gc_control gc_control = {
> > > >    		.victim_segno = NULL_SEGNO,
> > > > -		.should_migrate_blocks = false,
> > > >    		.err_gc_skipped = false };
> > > >    	wait_ms = gc_th->min_sleep_time;
> > > > @@ -113,7 +112,10 @@ static int gc_thread_func(void *data)
> > > >    				sbi->gc_mode == GC_URGENT_MID) {
> > > >    			wait_ms = gc_th->urgent_sleep_time;
> > > >    			f2fs_down_write(&sbi->gc_lock);
> > > > +			gc_control.should_migrate_blocks = true;
> > > >    			goto do_gc;
> > > > +		} else {
> > > > +			gc_control.should_migrate_blocks = false;
> > > >    		}
> > > >    		if (foreground) {
> > > > @@ -139,7 +141,9 @@ static int gc_thread_func(void *data)
> > > >    		if (!foreground)
> > > >    			stat_inc_bggc_count(sbi->stat_info);
> > > > -		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
> > > > +		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC ||
> > > > +				sbi->gc_mode == GC_URGENT_HIGH ||
> > > > +				sbi->gc_mode == GC_URGENT_MID;
> > > >    		/* foreground GC was been triggered via f2fs_balance_fs() */
> > > >    		if (foreground)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
