Return-Path: <SRS0=WSx8=5Z=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF9CC2BA2B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Apr 2020 02:28:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B78620787;
	Thu,  9 Apr 2020 02:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YJC2wrxw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="AU+aScoN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt4FJC/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B78620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jMMvM-0000cc-2j; Thu, 09 Apr 2020 02:28:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jMMvK-0000cS-VJ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Apr 2020 02:28:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D8MBeY3IhyYtigfcgoMKrLjytc0DnRcl4PGboWRhms4=; b=YJC2wrxwsQu0pfKQ4l1vXbFrwB
 /IDKssS9BhKkZdvsBiat1DsGVsZus5EG7ERgE87QUvm6nS90CUKXNQXRD16Iizbve9TfYhfiaMq59
 9ucW2CHhQ0CGBRCWO7+Tb/OgqzOhbPtYDw2tJtHcc5bd4HHoBS6Z52UtD2u2wnRM9tv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D8MBeY3IhyYtigfcgoMKrLjytc0DnRcl4PGboWRhms4=; b=AU+aScoNX+BgQe0hG/OxCNThsY
 kA8VfzN6IJByvXNcKvwaUoTJ6k6V73veTgHqVxxJGZveJkADOS0EAWZg+9QdvI8e4Mse28RjtSXMs
 wGb7EGjm5uwSS4rBFhrQbzfeF+o7ghudLg/06cp5+4QiXHuHxZ4QizCkOwSFPh+T99n4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jMMvI-00Cu16-6p
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Apr 2020 02:28:10 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 883E820787;
 Thu,  9 Apr 2020 02:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586399282;
 bh=uxk0S1npFOAmVD7CQaJ0Plq215CQzVmPjf8As32lTHM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yt4FJC/etaDubiv39P2czMkzYLhEZRlqGYanFHoScCIsR1PqW/592al1uIFDlJnL0
 VPsSxUQbMw7Iu60w/pT+rWpEX8WwhGOd8MxkflT53LYFeRpnzShiWHQpk8lSqXOceE
 nAkGkBjKsPh0hPbNZhuzqs1cY4j1kE0TzYJIjg5c=
Date: Wed, 8 Apr 2020 19:28:02 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200409022802.GC110440@google.com>
References: <20200403161249.68385-1-jaegeuk@kernel.org>
 <0e627c29-7fb0-5bd6-c1d9-b96a94df62ae@huawei.com>
 <20200407025913.GB137081@google.com>
 <2ca452cd-073a-29fa-1884-99ad1199bb97@huawei.com>
 <20200409022005.GA110440@google.com>
 <69df999a-1df2-595e-579d-a8c3fc700d7b@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69df999a-1df2-595e-579d-a8c3fc700d7b@huawei.com>
X-Headers-End: 1jMMvI-00Cu16-6p
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce sysfs/data_io_flag to attach
 REQ_META/FUA
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/09, Chao Yu wrote:
> On 2020/4/9 10:20, Jaegeuk Kim wrote:
> > On 04/07, Chao Yu wrote:
> >> On 2020/4/7 10:59, Jaegeuk Kim wrote:
> >>> On 04/07, Chao Yu wrote:
> >>>> On 2020/4/4 0:12, Jaegeuk Kim wrote:
> >>>>> This patch introduces a way to attach REQ_META/FUA explicitly
> >>>>> to all the data writes given temperature.
> >>>>>
> >>>>> -> attach REQ_FUA to Hot Data writes
> >>>>>
> >>>>> -> attach REQ_FUA to Hot|Warm Data writes
> >>>>>
> >>>>> -> attach REQ_FUA to Hot|Warm|Cold Data writes
> >>>>>
> >>>>> -> attach REQ_FUA to Hot|Warm|Cold Data writes as well as
> >>>>>           REQ_META to Hot Data writes
> >>>>
> >>>> Out of curiosity, what scenario it is used for?
> >>>
> >>> It's testing purpose to compare the bandwidths per different IO flags.
> >>
> >> Thanks for the hint. :)
> >>
> >> As nobarrier was set in Android, so REQ_PREFLUSH will not be considered in
> >> this sysfs interface?
> > 
> > I don't see any diff on performance, so not interesting. :)
> 
> I doubt it may has diff on non-ufs/emmc device? just guess.

I don't have any data on emmc, so maybe. Which case do we send REQ_PREFLUSH?

> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Thanks,
> >>> .
> >>>
> > .
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
