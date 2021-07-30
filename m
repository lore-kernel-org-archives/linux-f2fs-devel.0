Return-Path: <SRS0=ah6d=MW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3203DC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jul 2021 22:20:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DD86103B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jul 2021 22:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1DD86103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m9arj-0004f4-D8; Fri, 30 Jul 2021 22:20:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1m9arM-0004cx-F1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Jul 2021 22:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7E0PN9545v/jjTptH2sc0W85O/TpuAJcR8TKs10f0U=; b=LnWAxzOokwG4btyLCssqa5kENa
 sZloc2Bpt3t9mQp5AtXAhPjvbODGjhfVRN4h5atMq1l7wC2XmT4vdlgA0k8amYUFHx4oiGEqutZ7d
 sjV2tTHHIEH3v+QrzSFpyYKyCVhXrqtLyo2LWVwQ+2SAA6OrsGog61ak0YVj6zLWHQxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7E0PN9545v/jjTptH2sc0W85O/TpuAJcR8TKs10f0U=; b=NhJhZLiZfmpNA7K/ZXWlSPjicg
 7BDcOAWEvD7lximgt/Rpfpn87+9N2x+VZP35JjHMq+xry7x716KK+cS28vtokHH2DFjscf2zk0YZz
 77kcG8Ijs08P/y3OLeiCDqJqvctwoMMxXT1EbI/6dGcSgcjEDSC1yagxGvcubeDjxIdc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m9arF-0003sc-P2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Jul 2021 22:20:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4853D6108E;
 Fri, 30 Jul 2021 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627683592;
 bh=eymSPNa/TShtYv9U+nLrPRjDCp95bQdCZy22yEiy6Ok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KXy6Vyl6m36STisPeXh+7/hG5UjvgoprI0Vk6NXpV1dglkyEOYQWHVlz0l6onT51r
 jz9TLdegV7JdNemfxYZldBxqIQT64qHDoQMUJu4+HXP+eKivaNs7C4Hqris4yHOwGL
 RQvmv78vATrETUChTHRjNzdXUG+4x84f9ikZ7L/99vRfXERl9qEy6zpBzX1ORWRVls
 8znxc3hcCbbjwzoey/QizLY+99cw1XQMRF5LeM9pVwCXfMDDOnzyjy4R76/Jp3rOaY
 f2rWT/Etm0amxspsLFQ6ALojtxyc4wDjG+IIdUnvOEnb3hsSnq/FrljUJ5835AKZJT
 DKXt7mfdCU41A==
Date: Fri, 30 Jul 2021 15:19:50 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YQR7Bi9lI+k2QuYG@google.com>
References: <20210720010329.3975-1-chao@kernel.org>
 <YPYjzAVq04LfUO2Y@google.com>
 <014d1b9d-0698-fda1-0765-cce81d915280@kernel.org>
 <bdd499d9-1272-9fe3-8024-f53fbda458bc@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bdd499d9-1272-9fe3-8024-f53fbda458bc@kernel.org>
X-Headers-End: 1m9arF-0003sc-P2
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to force keeping write barrier
 for strict fsync mode
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Chao Yu <chao.yu@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/29, Chao Yu wrote:
> Ping,

Added. Thanks.

> 
> On 2021/7/20 9:19, Chao Yu wrote:
> > On 2021/7/20 9:15, Jaegeuk Kim wrote:
> > > Wasn't it supposed to be v1?
> > 
> > I skip IPU case for v1, and resend it as v3, is it fine to you?
> > 
> > Thanks,
> > 
> > > 
> > > On 07/20, Chao Yu wrote:
> > > > [1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html
> > > > 
> > > > As [1] reported, if lower device doesn't support write barrier, in below
> > > > case:
> > > > 
> > > > - write page #0; persist
> > > > - overwrite page #0
> > > > - fsync
> > > >    - write data page #0 OPU into device's cache
> > > >    - write inode page into device's cache
> > > >    - issue flush
> > > > 
> > > > If SPO is triggered during flush command, inode page can be persisted
> > > > before data page #0, so that after recovery, inode page can be recovered
> > > > with new physical block address of data page #0, however there may
> > > > contains dummy data in new physical block address.
> > > > 
> > > > Then what user will see is: after overwrite & fsync + SPO, old data in
> > > > file was corrupted, if any user do care about such case, we can suggest
> > > > user to use STRICT fsync mode, in this mode, we will force to use atomic
> > > > write sematics to keep write order in between data/node and last node,
> > > > so that it avoids potential data corruption during fsync().
> > > > 
> > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > ---
> > > >    fs/f2fs/file.c | 12 ++++++++++++
> > > >    1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 6afd4562335f..00b45876eaa1 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -301,6 +301,18 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> > > >    				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
> > > >    			goto flush_out;
> > > >    		goto out;
> > > > +	} else {
> > > > +		/*
> > > > +		 * for OPU case, during fsync(), node can be persisted before
> > > > +		 * data when lower device doesn't support write barrier, result
> > > > +		 * in data corruption after SPO.
> > > > +		 * So for strict fsync mode, force to use atomic write sematics
> > > > +		 * to keep write order in between data/node and last node to
> > > > +		 * avoid potential data corruption.
> > > > +		 */
> > > > +		if (F2FS_OPTION(sbi).fsync_mode ==
> > > > +				FSYNC_MODE_STRICT && !atomic)
> > > > +			atomic = true;
> > > >    	}
> > > >    go_write:
> > > >    	/*
> > > > -- 
> > > > 2.22.1
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
