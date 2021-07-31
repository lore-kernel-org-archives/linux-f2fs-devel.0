Return-Path: <SRS0=A69Z=MX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37EC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jul 2021 00:43:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD54461019
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jul 2021 00:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD54461019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m9d5q-0005hj-KQ; Sat, 31 Jul 2021 00:43:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1m9d5p-0005hY-P3
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Jul 2021 00:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B40DBV3Rowl5xAsPZuwUHENVpWlPK3pB8JKI7iireQg=; b=Vk9xmVFRVmQm6RcQ0EuAf9tEmi
 aF7cJYexsOdi0mNIN9zDGrGWiwbhijal+V73UJgwOEyHHjeA/4gCuw1Q+h64+z2o3Ah6fHYFhdFrV
 bieV8KGOdVH97u8eQkXd7RAW/EfrPQNJn5+wLXPzNDe6fLwG5HLhXHW/Nun3pSVMmosE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B40DBV3Rowl5xAsPZuwUHENVpWlPK3pB8JKI7iireQg=; b=HFGFiSo9jVIA6iNAq1Gz2gI2VU
 T4BW9i2kekIaBo+8KPSp1BMrqEU7FMjNuTbfXr0vaR6lkjnA9hfAsJYPjbIfWAdVPzqKKJxsdYvVA
 o0AdpphVdDJn7teqbcsrl/8ePGDbEpf246GfwaLTUKw4D4gDez/avn8rUOmsoxVPp/DM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m9d5o-0000iF-Gk
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Jul 2021 00:43:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 067AA60FED;
 Sat, 31 Jul 2021 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627692178;
 bh=sPuGl+L1sdMhNZK/fg1Tmc3r36KfKxRqsunJdIUimWw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HcZ0jAYDOWYePNYjE32BhhbV1DO76aUFx129ROMN5YtXrvNo1928acyqx85pVexu1
 lhL1ur0K3CAv7GD/mwp9I26CHucFbCf7hPN6P7KpsvgB2f/ZSiAWTqRuFc5Z/cHhx2
 lpz7mDt3sWZWaOR/JmdX0gx+ZFq1JOdHyZDSGW2tqhLdlEY7yIvus0DYyWCvz+gB/g
 izEUKS5BaM0IPVpDEJx0o5ohIMTeJkgVZ9iZnFmQ0j1s/A9Cl4nGmSaJb5i03TZys0
 ERmI5EheTcG1rsrHivHRugQkTrY/7m6xs6HENEh3mog9/zFcnjvhw97osmnSkJKkkR
 pZcd5wowcV0eA==
Date: Fri, 30 Jul 2021 17:42:56 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YQSckPQWe9b0JfNu@google.com>
References: <20210730100530.4401-1-chao@kernel.org>
 <YQREtmDLBNKSQViC@google.com>
 <c0af2126-7383-a579-e020-6480216c46fe@kernel.org>
 <1a540deb-4219-4000-2f8d-a72695f1dfde@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a540deb-4219-4000-2f8d-a72695f1dfde@kernel.org>
X-Headers-End: 1m9d5o-0000iF-Gk
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce nosmall_discard mount option
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
 Chao Yu <chao.yu@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/31, Chao Yu wrote:
> On 2021/7/31 7:41, Chao Yu wrote:
> > On 2021/7/31 2:28, Jaegeuk Kim wrote:
> > > how about adding "discard_gran=[small|segment|section]", and keeping discard_map
> > > in the small case only? And, I think we should set the section mode for zoned
> > > device automatically.
> > 
> > Yup, better,
> > 
> > About the naming, it look discard_gran is not clear here, since there is another
> > sysfs entry /sys/fs/f2fs/<devname>/discard_granularity has the same name, and
> > also semantics of newly added mount option is not only control the smallest discard
> > size, but also indicate discard start offset should be aligned to segment or section.
> > So how about using: "aligned_discard=[none|segment|section]" instead?
> 
> Maybe: "aligned_discard=[block|segment|section]"?

How about discard_unit? I feel that issuing discards in one of those unit
indicate the offset.

> 
> > 
> > Thanks,
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
