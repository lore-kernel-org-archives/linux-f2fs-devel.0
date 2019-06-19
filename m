Return-Path: <SRS0=LeJc=US=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F1CC31E5B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Jun 2019 18:19:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A08B21734
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Jun 2019 18:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RcTPORLE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="huhlLWZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A08B21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hdfBT-0007Da-6z; Wed, 19 Jun 2019 18:19:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <joe@perches.com>) id 1hdfBR-0007DS-L5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Jun 2019 18:19:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Content-Type
 :References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rGcsQZPHZpFralX0O62WUveEvqbXiubtTRGdDF4zNjU=; b=RcTPORLEaFZoYj99nuV8OdewSx
 YJB/2oQZJYmfmBYo/BrK2NPdpRQGLUJgOHC47++6oy4LUr4+yUoOy6rQQXMQ82Zn798zzwK+u4JUu
 fV5CQETrMhPGyoH5xeoXDSQ1JxkHUTN3/0y0Y0euuxt4ZI8/2I0MYBDwAabBaK2G/+Q4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rGcsQZPHZpFralX0O62WUveEvqbXiubtTRGdDF4zNjU=; b=huhlLWZN23HtMp+bgn20GA6YXs
 SzGqBn/NRf/DSWUtx7AWX3+lqQ9BXXMwB6J37tDqxoz2YS6qpoJHqj1HUUdEErt3S1LwtWPcs1Qox
 Ty3IY9hZFp0lpUGcYJbEAn6hw+Ve7vr8rubOcFkrhejZlsorejxusiL856PX9bpE3ma4=;
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]
 helo=smtprelay.hostedemail.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hdfBQ-0055pn-K1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Jun 2019 18:19:46 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7D2E9180A8859;
 Wed, 19 Jun 2019 18:19:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: walk76_36e891fd5be16
X-Filterd-Recvd-Size: 2275
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf06.hostedemail.com (Postfix) with ESMTPA;
 Wed, 19 Jun 2019 18:19:37 +0000 (UTC)
Message-ID: <bf8ad99f0f5d1cb5adde3eb6046a226c78930730.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Date: Wed, 19 Jun 2019 11:19:35 -0700
In-Reply-To: <20190619180150.GC57884@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190618094842.19332-1-yuchao0@huawei.com>
 <20190619180150.GC57884@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
X-Headers-End: 1hdfBQ-0055pn-K1
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

On Wed, 2019-06-19 at 11:01 -0700, Jaegeuk Kim wrote:
> On 06/18, Chao Yu wrote:
> > From: Joe Perches <joe@perches.com>
> > 
> > - Add and use f2fs_<level> macros
> > - Convert f2fs_msg to f2fs_printk
> > - Remove level from f2fs_printk and embed the level in the format
> > - Coalesce formats and align multi-line arguments
> > - Remove unnecessary duplicate extern f2fs_msg f2fs.h
> 
> Can we just use sbi for f2fs_<level>?

Not really.  see below:

> And, could you please change missing
> f2fs_msg() in the latest dev?

Anyone is welcome to refresh the patch as necessary
or appropriate.

> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
[]
> > @@ -261,35 +264,29 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
> >  	int ret = -EINVAL;
> >  
> >  	if (sb_any_quota_loaded(sb) && !F2FS_OPTION(sbi).s_qf_names[qtype]) {
> > -		f2fs_msg(sb, KERN_ERR,
> > -			"Cannot change journaled "
> > -			"quota options when quota turned on");
> > +		f2fs_err(sb, "Cannot change journaled quota options when quota turned on");
> >  		return -EINVAL;
> >  	}
> >  	if (f2fs_sb_has_quota_ino(sbi)) {
> > -		f2fs_msg(sb, KERN_INFO,
> > -			"QUOTA feature is enabled, so ignore qf_name");
> > +		f2fs_info(sb, "QUOTA feature is enabled, so ignore qf_name");
> >  		return 0;
> >  	}

etc...




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
