Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A95C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Oct 2022 17:23:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ohwUg-0007Ff-J5;
	Mon, 10 Oct 2022 17:23:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ohwUd-0007FZ-OJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Oct 2022 17:23:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MJUXtA/CRiKOSxIu7Wp+HVwh+Q8GE4zPwnJ3PLj2G50=; b=lGruoZzybo67SGzfkd+xsebCve
 RwA2EcNy79ojo0QmXizLRT7iaDJj7238JGsV5St9k/0RZQJenKXxDxSs+jMS42jSIjrNu5+iDFFIQ
 +pMr85tAEHL6en03jO9wU6RqPt08Isshp19Xx7W0/XheMe7Pp4LafLMDDLaFkIIPIymQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MJUXtA/CRiKOSxIu7Wp+HVwh+Q8GE4zPwnJ3PLj2G50=; b=TZQDgL5msOMzTNuuG+8oNR646c
 SIUq8luWIklJsXZ6Q0WjFfFmCZegqUvnulxCjgZUk6zq4gb1wB0OAZ/Uyw+DxmO164FDocQ15oyrp
 TnxbRtv0bGRQ/kvvP1WMAJcIRCbyuJsYOa46ZZMhBeKms/S7LBDZepg1srNB3F6al7KI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ohwUb-0002Ny-IV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Oct 2022 17:23:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2196560FB2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Oct 2022 17:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68665C433D6;
 Mon, 10 Oct 2022 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1665422574;
 bh=sTmASzYKfJzVNadyE54t+nuZVthL8wB7zBryW4ZrKDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IcariJu3eA4iPPpWNv2HLkgAso3MRgC43VnFbE18E1PVVLa/75R3fys+BoSOdvjb0
 wDH06hl+SEQBKbkgTJ4Hc4JMM9W2aa9TBT+m4bdMXKbgzFelZ9EB97AH5DskcesW81
 Np7GpyzFlxTB/P8OLPDBUUCVyv8zwgwKKYd2C8tmtod6M6nOIfm1MIQ8tgijgpwU0l
 uk7LgkeoT5lVlUZyztdgzHszltAeT68Etss+UeoLJwBAXx9VELHUmiUBpa8PuR2CZO
 dtqpfIDY30Plukh80T7QRBOKBCgQHZhD+CF3t+ZBMpJKROlKAzhOHhCdxQA8SOfrBH
 4RAuUUF+/9OHg==
Date: Mon, 10 Oct 2022 10:22:52 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Y0RU7G05vIEhUOYB@google.com>
References: <20221006151428.57561-1-chao@kernel.org>
 <Y0CDoWiaGKHkmnzQ@google.com>
 <6d45ea3a-5a71-b760-b60d-9e3e7dda3be4@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6d45ea3a-5a71-b760-b60d-9e3e7dda3be4@kernel.org>
X-Headers-End: 1ohwUb-0002Ny-IV
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix compile warning
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

On 10/08, Chao Yu wrote:
> On 2022/10/8 3:53, Jaegeuk Kim wrote:
> > Merged into the original patch.
> 
> Thanks, so it looks it's not too later to update commit id of original
> patch since it's close to the end of merge window.

I put this in the next pull request.

> 
> Thanks,
> 
> > 
> > On 10/06, Chao Yu wrote:
> > > fs/f2fs/super.c:3886:6: warning: no previous prototype for 'f2fs_record_stop_reason' [-Wmissing-prototypes]
> > > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/super.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index fad333881ea2..2908d41ed462 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -3884,7 +3884,7 @@ static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
> > >   	spin_unlock(&sbi->error_lock);
> > >   }
> > > -void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
> > > +static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
> > >   {
> > >   	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
> > >   	int err;
> > > -- 
> > > 2.36.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
