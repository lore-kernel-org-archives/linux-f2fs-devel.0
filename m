Return-Path: <SRS0=LeJc=US=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A98FC43613
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:52:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5162147A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Jun 2019 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="F99XlfDX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NXTv6YcY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7LKM86X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5162147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hdhZS-0000uQ-JD; Wed, 19 Jun 2019 20:52:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hdhZR-0000uA-6O
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Jun 2019 20:52:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KWxpYBoNcIIku5RsJeQ/Kay1v+JCHMsFWsDP1jjnICk=; b=F99XlfDXSeOCXx5JQXsOFRHp3M
 sJxHyCi1CtQJ40Kn5j8HiCopRSg2OVo6S3TqWnl7A3vGtxRhOTxJfFMQMHup0/7npY7NldbLIQ5R+
 Tt+D/joG4LIQfvncu+TjcmEpQGVHhcEOvVEncNlfZcxgFDJHYWhrXyA0j2ojDUxvGn9w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KWxpYBoNcIIku5RsJeQ/Kay1v+JCHMsFWsDP1jjnICk=; b=NXTv6YcYdQBsSH1DpsTFr/oC3L
 7Cp/pwX3xVovrzl9eK5Yy2kXRuYj6Uglnjb0KyzBdlTdxe5Bzzya5kOx6UIKJGneVVZmkuJdR6fYH
 wgSxqUWOmtLLX7jTwLuH0A/YsT8ghF2NincvtEhw+wIipvx/LELuRckKlVIsibxWYnSg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hdhZQ-005Fd2-Py
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Jun 2019 20:52:42 +0000
Received: from localhost (unknown [104.132.1.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 63B692147A;
 Wed, 19 Jun 2019 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560977553;
 bh=EmNI5o6EvjjbtNHqvH6RPpiIY8gO+KFytt/UAXSpdd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A7LKM86XEUUESUtnaxSM/DlqNUltkNgEJt263nPSsYVi0HxV8qirkZZ/IgvrfzAJn
 PSIVCo46E17tedIzlYxutWNh9+nlDVBCFO9/YxrYfeeaSbff7GXrJXlCF8t/9Pgdj1
 xN8iQkwxN/M5Xjh3uzZMxyGVYJCNa3LhYbXBDDSo=
Date: Wed, 19 Jun 2019 13:52:32 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Joe Perches <joe@perches.com>
Message-ID: <20190619205232.GD57884@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190618094842.19332-1-yuchao0@huawei.com>
 <20190619180150.GC57884@jaegeuk-macbookpro.roam.corp.google.com>
 <bf8ad99f0f5d1cb5adde3eb6046a226c78930730.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf8ad99f0f5d1cb5adde3eb6046a226c78930730.camel@perches.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1hdhZQ-005Fd2-Py
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce f2fs_<level> macros to wrap
 f2fs_printk()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/19, Joe Perches wrote:
> On Wed, 2019-06-19 at 11:01 -0700, Jaegeuk Kim wrote:
> > On 06/18, Chao Yu wrote:
> > > From: Joe Perches <joe@perches.com>
> > > 
> > > - Add and use f2fs_<level> macros
> > > - Convert f2fs_msg to f2fs_printk
> > > - Remove level from f2fs_printk and embed the level in the format
> > > - Coalesce formats and align multi-line arguments
> > > - Remove unnecessary duplicate extern f2fs_msg f2fs.h
> > 
> > Can we just use sbi for f2fs_<level>?
> 
> Not really.  see below:

Since sbi = F2FS_SB(sb), I don't see any problem.

> 
> > And, could you please change missing
> > f2fs_msg() in the latest dev?
> 
> Anyone is welcome to refresh the patch as necessary
> or appropriate.

Could you please take a look at this?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=697743b1c1025483c97c740cd8834711be4294eb

Thanks,

> 
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> []
> > > @@ -261,35 +264,29 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
> > >  	int ret = -EINVAL;
> > >  
> > >  	if (sb_any_quota_loaded(sb) && !F2FS_OPTION(sbi).s_qf_names[qtype]) {
> > > -		f2fs_msg(sb, KERN_ERR,
> > > -			"Cannot change journaled "
> > > -			"quota options when quota turned on");
> > > +		f2fs_err(sb, "Cannot change journaled quota options when quota turned on");
> > >  		return -EINVAL;
> > >  	}
> > >  	if (f2fs_sb_has_quota_ino(sbi)) {
> > > -		f2fs_msg(sb, KERN_INFO,
> > > -			"QUOTA feature is enabled, so ignore qf_name");
> > > +		f2fs_info(sb, "QUOTA feature is enabled, so ignore qf_name");
> > >  		return 0;
> > >  	}
> 
> etc...
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
