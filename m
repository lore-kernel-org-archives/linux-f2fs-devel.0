Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F530C10F1B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Dec 2022 19:17:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p5AmZ-0001KU-88;
	Tue, 13 Dec 2022 19:17:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1p5AmX-0001KO-4m
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 19:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V+Ey6+x0DiQeXB+HxcsVQeqMn4lDNI2M51+RkCxiEq0=; b=jAzIiIIneRRvZZwS564xfIhjtG
 wJsObyZr6BOa0DfxfmW3o8ykdGF7oBlGtaHVrOU5pJAc/MU64wc+dLR8H8ExSBoxyMzUc+s0D1Cy/
 jJ8j3EjIahULowf37kcyRhF6E4XNm/uIry+xz5vCFox32lqggCoVboG4BkbAPRLoqmuE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V+Ey6+x0DiQeXB+HxcsVQeqMn4lDNI2M51+RkCxiEq0=; b=aLt34ohrKbWjXVXT5ToxSzqz2F
 L+qDFIPClULgyEYpf9vRFaUiFDDmTIXcXzKjVVGI6OzgPiOywGSSX76dcSsQlTCk6TzxfzGRT4HID
 mWsGKtCYgYjINGr+kABUgR4ChDSF3IuoO2lUjbqibGLwR7uJpDEBb26tz4O1w43n02F8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p5AmW-00GBIl-HZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 19:17:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 28742616F0;
 Tue, 13 Dec 2022 19:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B4CC433EF;
 Tue, 13 Dec 2022 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670959050;
 bh=oQXZwLpEHai9jIJPJXjlwzNaTMDa9dkWWo0SoGbc+jw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c3hwuUoTS1nYS74nAYE15G6ufa1d8mbLQGLmD0fIG3cSe19dTDwanL2uGifbWSDQA
 6Dnn+NMMr4QtV4gse2Jsjb0y5gPXG3ixDuEEBCSXAlIlkq2ni+KPgKGGlBle2vCrNc
 7ZKlPNkCnsV5CojmO7mSa61aOiNgpgbYd6oi8TPrFYZv8Hh7+iAJtpaSyRTq2yDU3P
 kl1vtvkeXvL5cAjPARciDVEWFfFyXHWB4SFt4HAX9zYYXMV+x7zzN/UvtifQTs4ami
 uHqdk8UNPxzVZ6g+YRFjyXoGAmCBhW/Hz2wlV5WL7NDcT2di2SfNGPtpvtj5ge/yzu
 +EKgtvV0EudxQ==
Date: Tue, 13 Dec 2022 11:17:28 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <Y5jPyEiAtDPx7VSI@google.com>
References: <0cc89bf7-ea7c-d6e9-5ba9-548181de4c82@kernel.org>
 <20221213122121.18685-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221213122121.18685-1-frank.li@vivo.com>
X-Headers-End: 1p5AmW-00GBIl-HZ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add support for counting time of
 submit discard cmd
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

On 12/13, Yangtao Li wrote:
> Hi Jaegeuk,
> 
> >>> Again, w'd better to consider this functionality only when DEBUG_FS 
> >>> is enabled.
> >> 
> >> BTW, why can't we use iostat to get the discard latencies?
> > 
> > Agreed.
> 
> Let me spend some time on this. So, I guess this patch can't catch up with the merge window.
> And I still have some patches that have not been picked, can you take a look, hope they can
> catch up with the window.
> 
> How long is the 6.2 merge window left and when will you send the f2fs 6.2 pull request?

I cut off the patches for this merge window. Please consider next release.
BTW, could you please send a patch set instead of random posts? It's quite hard
to find which one was merged or not.

Thanks,

> 
> Thx,
> Yangtao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
