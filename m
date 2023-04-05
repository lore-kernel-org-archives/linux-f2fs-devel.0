Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E968DC7619A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 15:57:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk5Vv-0008Pw-B0;
	Wed, 05 Apr 2023 15:57:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pk5Vu-0008P2-3D
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 15:57:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oaWPdKdNPnDKtD6FK+eV1Sj5Tqor9nlsfMQyGHmab9E=; b=HHw77zoPo9S7uYOTUFkqwb2ENA
 eJ1HOtGH3273GV52GgXY3RuR2gk5sdpMqTLe09dGl4ZY9Pzu9ILL+9NVtUF5A28z6ZgYpSUwaCimV
 FzV2DSJERDHOKb123sVQO8NtY15/DtPvThFQyJDGQMsqeixgWndSpTNiszx/xASu0H8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oaWPdKdNPnDKtD6FK+eV1Sj5Tqor9nlsfMQyGHmab9E=; b=MNve6Zufxk+rSmP0mBki9IHhP4
 fPlcdqCw6MGFvIssLol5m/3pPi0FeFUTTE9eHBxYxq0h4UYqrchIHPeq79zsLBESLkQJ7v8Q16SM1
 pq2s/rkXQKUeV/Z8evKzlhZR8ugG1cl5Yzjk7pcfr3gD3H3FAeI3/uPffZ42j7BWH32M=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk5Vs-0001zM-0S for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 15:57:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9CB2361D4A;
 Wed,  5 Apr 2023 15:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2973C433EF;
 Wed,  5 Apr 2023 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680710246;
 bh=Wf6yC9V68CXdRJzxScFYl/wiaFwWP6I9Y1bxabKUuHY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aJ+CMtDmZoUKsWeow3qAnsJUNrmfxXeE/P8Z67h4jblTblFlW+qlhgNVXnzKqKx7C
 9AllNbLRwsyn93A/ZX1ke8VF1ScwhHG86FgDaeBXLAX7cjByu/Cv8JPvxe6tEKTGix
 2yuQ8J+Q/rtMZorSiAd37dWvZwjFssvALpsz30PtIFiDUNHiN6aRD7utITV/uQtglP
 bsj1F6BwfqhZkIAx+FBBT+Xyj7mbinxYim9bIeiztnQgh18umEU1mR1PXeukkX3OUK
 mplODYW1DhLoAv4WDqYiQVSvOyUbWYgzrquuETwxmBKlESEbm/x4BASP5JsG8k/UO+
 BfsIculAJUBXg==
Date: Wed, 5 Apr 2023 08:57:24 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZC2aZJFIJZclTkkK@google.com>
References: <20230331113305.77217-1-frank.li@vivo.com>
 <3918411a-77fc-48d7-5b80-c4b84203a39c@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3918411a-77fc-48d7-5b80-c4b84203a39c@kernel.org>
X-Headers-End: 1pk5Vs-0001zM-0S
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert to use sysfs_emit
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
 Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/05, Chao Yu wrote:
> On 2023/3/31 19:33, Yangtao Li wrote:
> > Let's use sysfs_emit.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   fs/f2fs/sysfs.c | 10 ++--------
> >   1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 9ddc6ee19433..2c0b2cb05a3a 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -312,19 +312,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
> >   	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
> >   		struct ckpt_req_control *cprc = &sbi->cprc_info;
> > -		int len = 0;
> >   		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
> >   		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
> > -		if (class == IOPRIO_CLASS_RT)
> > -			len += scnprintf(buf + len, PAGE_SIZE - len, "rt,");
> > -		else if (class == IOPRIO_CLASS_BE)
> > -			len += scnprintf(buf + len, PAGE_SIZE - len, "be,");
> > -		else
> > +		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
> >   			return -EINVAL;
> > -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d\n", data);
> > -		return len;
> > +		return sysfs_emit(buf, "%s,%d\n", class == IOPRIO_CLASS_RT ? "rt" : "be", data);
> 
> Exceed 80 columns.

Fixed and applied.

> 
> Thanks,
> 
> >   	}
> >   #ifdef CONFIG_F2FS_FS_COMPRESSION


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
