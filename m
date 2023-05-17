Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDBDC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 May 2023 02:32:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pz6xa-0004Xz-48;
	Wed, 17 May 2023 02:32:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pz6xY-0004Xo-1r
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 02:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4YWukZKCN2HkLC/JCPOIBlycl26Pn3SOsK8esB/zYyE=; b=JltX7lASsYqhN0FS4kk7tLKAQv
 wZmPph/WpiU1URZClQs2qHkckUmbX+YDtmL/r/HRo/Np7PbDZaZ+nIcHQhE5iprmQ1ITkxr2dEpTE
 bmj8F3w8H0TUZ4CpTpnc2p8OyHSQR9wS1jo2sdrI1P3jxU2bzBIIHKWY9cY+raZxx/C8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4YWukZKCN2HkLC/JCPOIBlycl26Pn3SOsK8esB/zYyE=; b=CqTFJ3886zDINJTu8XFiWEXAwG
 7+R+aKnpqmdYr7ume2pp7fPZ+pelU1sPn6UzkY0Ii+hd5aNf+lFpZ+wf6dDngPrHQ+gx3mOHMASt1
 LjCI9vuxZOGUWRtfISyJrnpHBVsybGS6lYy1Yl1oBAqdlNepbHyTjt8/FD+5ebIu8PDk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pz6xU-00AP6U-1C for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 02:32:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A2D55640DC;
 Wed, 17 May 2023 02:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D72EC433EF;
 Wed, 17 May 2023 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684290722;
 bh=EGWWvTtIz/wefBtSbQjyXbGccmk7EVTm65ykgv4tinQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=JZH/SIc3l8kO4VCTPoT1GAbA53InelUdM05t7DUEP7A85TszHsbe2z7LoVUIPDMno
 sHQ+LsphgUkO0H1IavoQUOjYM4HYMj92ouwYS6ePPjqmYnZRxKWK+M/ApYZYyNp7Xr
 QygGe3TAOW1sCUUvW7uqwwfg8oW+k2cxqsfKPmDtJI0VR9SgQAJ2CyBxW+JPwYw0rQ
 JTlPLUBy1kk/or+3s3Wbge7A1GHgP3vIJwwqc8k3jyO59Pm5oW/hGc/NgF4ImQuXju
 HgJd/7hH0+aDobDheNoBDL6XauiiPKPpT41srRH0gqCQNWBjhvk3//HCNSrQa/RXlK
 tCqLXe+3f2ISg==
Message-ID: <ed4926d1-aba5-0234-7345-cc3290e8cc54@kernel.org>
Date: Wed, 17 May 2023 10:32:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Sijie Lan <sijielan@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <CAGAHmYC8AR_iw=nXQc6s29T3SkSoz9Ajd0N39Nv87orJJHMLGQ@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAGAHmYC8AR_iw=nXQc6s29T3SkSoz9Ajd0N39Nv87orJJHMLGQ@mail.gmail.com>
X-Headers-End: 1pz6xU-00AP6U-1C
Subject: Re: [f2fs-dev] Is compression available under direct-io mode?
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/12 9:10, Sijie Lan wrote:
> Hi, guys,
> 
> When I do some specific test scenarios, I want to do some direct write
> after data have been compressed in F2FS, but when I track the internal
> functions, it seems F2FS forces my direct-io request to buffer-io
> mode. Does it mean we can not do the write direct-io if we applied the

Yes, compression feature depends on page cache.

Thanks,

> compression feature? In other words, must f2fs use an inside buffer to
> provide compression functions?
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
