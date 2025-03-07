Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CC6C19F32
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:40:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tqeUN-0001Hh-Cm;
	Fri, 07 Mar 2025 20:40:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tqeUL-0001HY-Fg
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Mar 2025 20:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kL5ad9Gb0t9OR5Mmf43J0/FIFCjG2j1F/hWn4jUlEkQ=; b=WEyfiYn2FqBoGcm5s/NIYR5oN5
 BQuCxw+O0LLZiU3H+rIEuqfpPlkgXMVFnnH5o76f4e1Bu5uTU45weDV6geH54vvQefuuDJtl9VnIS
 QlK1ibvG92mMmvsSFUC2iRMa3VxiGo3Hrld6gGDMw3+SRP2HTekQPbTEesH4chrQr06o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kL5ad9Gb0t9OR5Mmf43J0/FIFCjG2j1F/hWn4jUlEkQ=; b=ifrAI1VzogD/t9pLGc0MWmcjUG
 Yk1WoSgOWqiOXZ8BdY9jokjY1eSa5qLfrUAoetISlYGWQpAA6PgLmEZp7iyYDYmDabhoWdhVcx4zL
 lKkzUHpM1t+w+6/w0y+X93yaBoCofmzxC6QdGAQhJFhwXaYts293JTEP8Phw6XdxjHPo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tqeUG-0006Rr-9V for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Mar 2025 20:40:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 11DCB5C6277;
 Fri,  7 Mar 2025 20:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E02C4CEE2;
 Fri,  7 Mar 2025 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741379998;
 bh=H8ql6R14QTVScWQoYRQBgXkNTHCFl/dZikkrBPMpnIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uJDvr1PE4Zmn0kjDj/ENOdDtLhy+vxW/FMM/joYTCIXNM1OWokZ69mnFH/4us841M
 Qb9d/t1XvX15wRYZQ4prZYifMG/ZjFNFtZMyH2l+cdgfJ1ErSApNMJG+/+7SNROcbz
 jLzSkR8MWlDyehaeSFpUE5AgUOUQl0cdvcgPLblpbskdqQMEwbPZgMnplsqa+KqGaq
 8WBjlf/i5Ieitb7/oxoze0xllLaSPzeGvX7Wm2Ebh56keyPzAK7OKcjgZUIqrTZnyC
 Sy1szc0LyeGebebzVRW4kiG5Q6ogMmWNygSLUIeRcMhK4eY7B2i9OJLHJNYCtbBBi4
 Q1KLRN2J9jFuQ==
Date: Fri, 7 Mar 2025 20:39:56 +0000
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID: <Z8tZnN-CAS20Dpi7@google.com>
References: <20250307182151.3397003-1-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>
X-Headers-End: 1tqeUG-0006Rr-9V
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/07, Matthew Wilcox (Oracle) wrote:
> I was planning on sending this next cycle, but maybe there's time to
> squeeze these patches into the upcoming merge window?
> 
> f2fs already implements writepages and migrate_folio for all three
> address_space_operations, so either ->writepage will never be called (by
> migration) or it will only be harmful (if called from pageout()).

My tree sitting on [1] doesn't have mm-next, which looks difficult to test this
series for test alone. Matthew, can you point which patches I need to apply
in mm along with this for test?

[1] f286757b644c "Merge tag 'timers-urgent-2025-02-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip"


> 
> The only remaining filesystem with ->writepage defined in next-20250307
> is vboxsf, so the concept of removing ->writepage is well proven.  I
> have some follow-up patches which simplify f2fs writeback afterwards,
> but I think we can postpone them to next cycle.
> 
> See
> https://lore.kernel.org/linux-fsdevel/20250307135414.2987755-1-willy@infradead.org/
> for where we're going; the first four patches in that series are the
> same as the four patches in this series, and I've split them out here
> for your convenience.
> 
> Matthew Wilcox (Oracle) (4):
>   f2fs: Remove check for ->writepage
>   f2fs: Remove f2fs_write_data_page()
>   f2fs: Remove f2fs_write_meta_page()
>   f2fs: Remove f2fs_write_node_page()
> 
>  fs/f2fs/checkpoint.c |  7 -------
>  fs/f2fs/data.c       | 28 ----------------------------
>  fs/f2fs/node.c       |  8 --------
>  3 files changed, 43 deletions(-)
> 
> -- 
> 2.47.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
