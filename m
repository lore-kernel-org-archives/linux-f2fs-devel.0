Return-Path: <SRS0=ppQZ=MS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89878C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jul 2021 19:04:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2C060F11
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jul 2021 19:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A2C060F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m85uB-0006In-HA; Mon, 26 Jul 2021 19:04:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1m85uA-0006Ih-RK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Jul 2021 19:04:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XyXEnJieNGh/lesiIeroy7vT5KLcMn16qaH4WUkIdx0=; b=Mw6t0dGmzQeFJNwS3Tqnvfw1aF
 kJDHgVfbi1SqmNlRjkzQU3CwZe/8iawHE6A9VKQR8XKjhMugd+SMpmQrKlL3uB4uha6yaucVFpYS9
 0q6o9uptMe+FO6KhW89Cq+5xrZiuv11NCHdWInr+qVk4GuMf0vae7W3HQRS0SVISAOeU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XyXEnJieNGh/lesiIeroy7vT5KLcMn16qaH4WUkIdx0=; b=TS4lCpkwQedk23+bydt9U+Gex5
 UaYQkpCrApv7bkgZyiplggyFz6vBciolQZhYXvO3yHKKPnaRrdv0GiGWnrAfyDoqi1NwMBNSgyjv4
 wJSdMZ3WZ7PyYJj7WMTtsguKEk9bvgyzzRWQM0mR5anFIipyMvBPtXIVMG3syetVb0lA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m85u0-003Px6-Ob
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Jul 2021 19:04:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C2EE60F5D;
 Mon, 26 Jul 2021 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627326266;
 bh=kzsXWrwCi9RWE6Q9bwL1m2kT7wU3EGNRLs3PcijJLeQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p+2KgCyWvbGQIoSDUecB02vvD07XptxRslfwV63L3kKSv0UrbN5oB2xrHAZKdwje7
 WrfowmN1LQaJT+GLZbz4myvuFjQmlNiqvR6SLHKMilU+z2X3fXBJceOqDY55xnjyVx
 6JSCHDc/r9fPie1T6IBnvZcrT3rxzo2rEI7/8kbSky6joTs5gdI3wkMvAc576R/gv2
 47FdGxFnsLzaYoMWpKH/2aFWXJeMxexBkmlW+qn0W7EOI5scsJVneQN2V/CALfbBYj
 H+bawPsyfh+2vyp9Vdweh+ACtV6CAs+TsTg8ou6MqH7gl9LK+YGcGovesWN9Cip0Mi
 Mfg2FcfH2CnfQ==
Date: Mon, 26 Jul 2021 12:04:24 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YP8HOOkA0wlyMYMf@google.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <YP2Ew57ptGgYsD1Y@google.com> <YP2Hp5RcZfhKipfG@google.com>
 <YP2m7lSqvenvxYIY@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YP2m7lSqvenvxYIY@sol.localdomain>
X-Headers-End: 1m85u0-003Px6-Ob
Subject: Re: [f2fs-dev] [PATCH 3/9] f2fs: rework write preallocations
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
Cc: Satya Tangirala <satyaprateek2357@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 Changheun Lee <nanich.lee@samsung.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/25, Eric Biggers wrote:
> On Sun, Jul 25, 2021 at 08:47:51AM -0700, Jaegeuk Kim wrote:
> > On 07/25, Jaegeuk Kim wrote:
> > > Note that, this patch is failing generic/250.
> > 
> > correction: it's failing in 4.14 and 4.19 after simple cherry-pick, but
> > giving no failure on 5.4, 5.10, and mainline.
> > 
> 
> For me, generic/250 fails on both mainline and f2fs/dev without my changes.
> So it isn't a regression.

fyi; I had to change 250 to pass like this. I'm digging the patch.
https://github.com/jaegeuk/xfstests-f2fs/commit/99c11b6550a2a24f831018d2e019eed86e517d44.

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
