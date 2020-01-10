Return-Path: <SRS0=ysmo=27=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89244C282DD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jan 2020 23:52:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520CF2072A;
	Fri, 10 Jan 2020 23:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="AIc2a7SS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NQcBNrU2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5rsvDPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520CF2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iq450-0001Mr-NX; Fri, 10 Jan 2020 23:52:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1iq44s-0001MX-JJ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jan 2020 23:52:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JzLRdHvGFg5Agv66X/P8KtcTDPVQVS7wlsWlJZDHwuA=; b=AIc2a7SSBYedmDESO6av41Qapv
 9BUKD10fmMEV0qkSniUVtsHv9mPqFtPaSmaLh6uAQ2dal+4ROjAa7bz5PuhIzn4buV2OWKZvdgFBr
 pkI3pGPAGu8q08UDBLGf+3HujCZgKLoUZqAl8UpxqGmroJAzA1XoTS0UleNTuc+9xUuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JzLRdHvGFg5Agv66X/P8KtcTDPVQVS7wlsWlJZDHwuA=; b=NQcBNrU2hdmcOOuhTsxQWrdBdr
 5ZsFDPraHPFepFaQh+dZmahwpl+Af1FaaPCcQK39qeoOE+QgTmxt/pTlUqQjt9PQPq25GFbIgSHXU
 IulJpg4WwOJ+XDjbQUzG4QHBaFpXhWeifIksqbS5nvkoH5jh0NkoWltynRL4YHBTjWTI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iq44o-00HTaD-3B
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Jan 2020 23:52:29 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91F062072A;
 Fri, 10 Jan 2020 23:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578700335;
 bh=NvOUcUspxFLI01lV4A8uaAMX4Ow8pA4DdoGx2zMfWBU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K5rsvDPnEAR5f21xmUvg1WTxOoWEYMaz3T4nOp8ln4/PnRUK4/QvBccKSxw5gx6F5
 KSbS8D2qzcW2V8HhqcHE4E4fU2V4WST4iFRc15NeOJdUxDkmGbzhsYrvkRgYg0zg5s
 4Pnn73nYDbl8cxLB9pOYFoZPsR8NX3+HrjDDKgns=
Date: Fri, 10 Jan 2020 15:52:14 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200110235214.GA25700@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <20191218214619.GA20072@jaegeuk-macbookpro.roam.corp.google.com>
 <c7035795-73b3-d832-948f-deb36213ba07@huawei.com>
 <20191231004633.GA85441@jaegeuk-macbookpro.roam.corp.google.com>
 <7a579223-39d4-7e51-c361-4aa592b2500d@huawei.com>
 <20200102181832.GA1953@jaegeuk-macbookpro.roam.corp.google.com>
 <20200102190003.GA7597@jaegeuk-macbookpro.roam.corp.google.com>
 <d51f0325-6879-9aa6-f549-133b96e3eef5@huawei.com>
 <94786408-219d-c343-70f2-70a2cc68dd38@huawei.com>
 <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1iq44o-00HTaD-3B
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
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

On 01/06, Jaegeuk Kim wrote:
> On 01/06, Chao Yu wrote:
> > On 2020/1/3 14:50, Chao Yu wrote:
> > > This works to me. Could you run fsstress tests on compressed root directory?
> > > It seems still there are some bugs.
> > 
> > Jaegeuk,
> > 
> > Did you mean running por_fsstress testcase?
> > 
> > Now, at least I didn't hit any problem for normal fsstress case.
> 
> Yup. por_fsstress

Please check https://github.com/jaegeuk/f2fs/commits/g-dev-test.
I've fixed
- truncation offset
- i_compressed_blocks and its lock coverage
- error handling
- etc

One another fix in f2fs-tools as well.
https://github.com/jaegeuk/f2fs-tools

> 
> > 
> > Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
