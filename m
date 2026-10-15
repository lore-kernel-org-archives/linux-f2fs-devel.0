Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C66ACC6B39
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mwvspU9a6kQ/MzthGbDfHmzGEJGVIXJE3X/u7kiOFG4=; b=GoExwPMz5YaKhe4ytbIPI+cVLR
	jRsV9hsCSAFtAq0yXUWa82QRju+i89VYEXS6tL376SKfdEZwionKpGJ7GXGalOqRKk2/EZ7wS4L0S
	chYnrWMB57h2Mfiz+Kanzk/YUBbsfuNntW4xhQEnv3ipOYBApwxYfU4L7Yo7Zl8DwcXk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHOB1-0000mi-IK;
	Thu, 15 Oct 2026 16:19:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1xHOB0-0000mc-AC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 16:19:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HYFG290IcaoYwXzOqV8ubmLb8a7PUjjAS/yMSxm5KfM=; b=ZbtBP0t41Wv3q1GcVEyczRBUgB
 YhM+r8le6Kd0RwmP2XwGOmVQ4e9dZxnaVZDvk1roFO9p0kyVXpWAjSb6+m7LbYpItS6y8D3iGxhRI
 o99QeeM9Edl7b9N2Y6WQtm20XfVoCL/LyCv5C41tRScdnLBecC8TupVc+NCoP2BoSa5Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HYFG290IcaoYwXzOqV8ubmLb8a7PUjjAS/yMSxm5KfM=; b=mp9fEYohNJTu22T/1SHj/ro6wP
 i8H0z2G+QzmaoOyWI7wofIoihHyeLDb7nfitf7aurfH0yOLnC0oEmc4ir4QUvvA3E4XltpKxmxgM0
 50b86hWeLKoyzZHr67440XQkf4Mb+zTN+UtRdVdW3CJp8Atj3jYj8lc2bAElVXl7X0Bk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHOAz-00054t-Qy for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 16:19:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78F2240A11;
 Thu, 15 Oct 2026 16:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A711F000C4;
 Thu, 15 Oct 2026 16:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792081164;
 bh=HYFG290IcaoYwXzOqV8ubmLb8a7PUjjAS/yMSxm5KfM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OtIyLrwC7o10uo3W+nu328B4YSiNFkoMjs4gUZylrVfl8th8PiYT67NASOGrrNUe3
 Y/h6vaObnRMZvvDwW6S+VwLrSrPZi9y74Yt++MEYnObU/er6Rw2j8kns8x3iM5iVVi
 w1lqJBr/4onje4eozJoHNWNLeZfiAdcogoKAaNYYXvQ6QAOtTT/vPxb4amznD5QBjt
 tX9eRGZJaVGaOSJKr+YR8vaR2mhzPKwRYvZMsiJiINki0vLFnpS1/8WLiA1ptXuVa6
 PwXvPoYc/JtNZziESoVNV2YOjNuLSkYmK58lfkHUGXIOcNXN8BWZpDXXrte/n5Kjce
 GD5Yq41nL1LlQ==
Date: Thu, 15 Oct 2026 16:19:22 +0000
To: Nanzhe Zhao <nzzhao@126.com>
Message-ID: <atD9Csw1-lj5_SR_@google.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <atAO6ykqwGgZq77y@google.com> <atA24UMtAqkmz_R8@google.com>
 <63e416aa.2fb2.1a13d9f3491.Coremail.nzzhao@126.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <63e416aa.2fb2.1a13d9f3491.Coremail.nzzhao@126.com>
X-Headers-End: 1xHOAz-00054t-Qy
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
 folios for writable files
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
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/15, Nanzhe Zhao wrote:
> 
> Hi Jaeguk:
> 
> >Ok, this comes when applying "f2fs: carry subpage offset and count in write IO".
> >
> 
> So we didn't reproduce this bug with the whole series patched on dev-test?

I hit this after applying the entire patch set. Then, tried to bisect and got an
issue with that patch in the first round.

> 
> Thanks,
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
