Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834F4C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Dec 2021 22:16:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mzQx8-0005j3-6w; Mon, 20 Dec 2021 22:16:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1mzQx4-0005iI-SQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Dec 2021 22:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ija/CWf1c2nMbURcQ8oWbLy/3a3wlmLuZ8YIjgJEaAA=; b=Ia3MAdKUJxwTON5PjOCiJwHDl9
 W3mpRbu93VHxvsPgiMac7SRsuZht4KObZTv2uLsdM7i2axu0vD5VGqZU4PSNPpYE7ITv4Gtng7pRs
 yowTydC2raoWbaeRz7ZTKGtg4FGChBZnPsQbQYKSdZ1LcphlPC5jjGABSdJ53qCPJ4H0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ija/CWf1c2nMbURcQ8oWbLy/3a3wlmLuZ8YIjgJEaAA=; b=ZThMZuvrsvzantU4wVSusTOwvz
 9YeH8aUCtXrwOG+MkVDB7kmNwVzS3FSDiprHF43gW3ZzHiVfjNXpEgRb3SXcFxyXhkqq1jg9+MWRg
 qAReSTsOcjIKvJlXmtg1DyI4n0jEayu0GhAu77w961tj+vUo7YPM9XMxVB1GMhrqrAu0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mzQwy-0006QQ-VK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Dec 2021 22:16:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2A6AE61306
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 Dec 2021 22:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C5C36AE8;
 Mon, 20 Dec 2021 22:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640038559;
 bh=NvzUcorftFDufwHxLvjFkT88ytvP40DRNvsxQGK0hDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YDvwWGj7xIm+MlE+mJUD8BLRJ892Qtci8NA9RJzVB0qJfp1X3UM7+s58oQRTzQzJL
 L4QdwcIf89g2oxC0IS2TUXxSwMMo4MyIgzkxC7rfAbdVvUuCOWr77XXGxJbTHyOKoY
 4Nf+5hcknmKjVuAlfZ2lulQWRfMuDwSfdhq2jU1qoBknk4xtQIIkVM0C/RTbtP6KF7
 zcP9Dyo+7muAvRJZF1mnWjpBgQ9L/ojW0ImJjpxFJCnKPl0vU0X/EyY63CuFFInHrw
 IczNATA148HCROdsK/7Om597mgNx7va5rTp5wci8fvgZTx7Aqrs23CRguMOWV/dVsR
 ZP3M3TRbhDRrA==
Date: Mon, 20 Dec 2021 14:15:57 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YcEAnX2+ARaGXrtx@google.com>
References: <20211214182435.2595176-1-jaegeuk@kernel.org>
 <443927c3-8eaf-8f00-0e41-2173143fe166@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <443927c3-8eaf-8f00-0e41-2173143fe166@kernel.org>
X-Headers-End: 1mzQwy-0006QQ-VK
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid down_write on nat_tree_lock
 during checkpoint
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

On 12/19, Chao Yu wrote:
> On 2021/12/15 2:24, Jaegeuk Kim wrote:
> > Let's cache nat entry if there's no lock contention only.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/node.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 556fcd8457f3..b1bc7d76da3b 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -430,6 +430,10 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
> >   	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >   	struct nat_entry *new, *e;
> > +	/* Let's mitigate lock contention of nat_tree_lock during checkpoint */
> > +	if (rwsem_is_locked(&sbi->cp_global_sem))
> 
> Why not down_write_trylock(nat_tree_lock)? cp_global_sem lock coverage is larger than
> nat_tree_lock's in f2fs_write_checkpoint().

I'm focusing on faster checkpoint by minimizing the nat_tree_lock holding time.

> 
> Thanks,
> 
> > +		return;
> > +
> >   	new = __alloc_nat_entry(sbi, nid, false);
> >   	if (!new)
> >   		return;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
