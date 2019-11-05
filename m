Return-Path: <SRS0=/Zjq=Y5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1779DCA9ED3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Nov 2019 03:05:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C6A206B8;
	Tue,  5 Nov 2019 03:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dnXmFM3s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WKqZdt59";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4fbfC66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C6A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iRp9R-0004Ad-4l; Tue, 05 Nov 2019 03:05:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1iRp9Q-0004AQ-1E
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Nov 2019 03:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zwj4kn5TVqgDd9P4MWo4EBNcmmY7SJQgfAdtiwRGh3w=; b=dnXmFM3stfe/JY5qVEIztfjRDZ
 hR338i/Te5SSKNt5yltF9z0qjmpOq09De5f3CqoDXmgHMo6Pug6ZvX7kze6Hk9AaBOUUnTfOktKsM
 JmrZ0PEAQEW6fumcD7/rAWMWq/RqaaOgPhPNS03cWEcyV+R1/2DvljyVY3xetjZsuTPw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Zwj4kn5TVqgDd9P4MWo4EBNcmmY7SJQgfAdtiwRGh3w=; b=WKqZdt59sIDHPU+wx4FF2tRbiz
 yedCh14VzzcTmWmsl0pMTQ7+MIbe/U2PReGQYMhWGEBsWnkpG44YY7EEdYmoqVkC1jCrp4l2PYlSR
 wixKjoSRhyLncMXqFeGOQhI+jQrsgIKHizaPKNicAH19F+L5GplWzWQ53YcrET4qrhn8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iRp9O-000LXR-Ou
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Nov 2019 03:04:59 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BF300206B8;
 Tue,  5 Nov 2019 03:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572923092;
 bh=ayQqU8Qbemc32/HIUooa1m/XuTOUikPJAAUvS/qaxjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M4fbfC66Tih/uZITmA1N9W/HcX5rt9+ugMU/5Z3rcTE3omxFQXy4jw67GFv8tbBg9
 tACLhT3w+YOkMDSBb9ubrP70uZKwt5Wva5IeHIprFRpTdoXop48AZfklA245kBm7C6
 3XQ8sPBdy+FZrB11Cbde8HdqVp896Z/3h0f9SFKg=
Date: Mon, 4 Nov 2019 19:04:51 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20191105030451.GA55090@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191101095324.9902-1-yuchao0@huawei.com>
 <20191101095324.9902-3-yuchao0@huawei.com>
 <20191105000249.GA46956@jaegeuk-macbookpro.roam.corp.google.com>
 <40d0df3f-cc55-d31a-474b-76f57d96bd89@huawei.com>
 <20191105023835.GD692@sol.localdomain>
 <00ade77c-5451-4953-0232-89342a029f33@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00ade77c-5451-4953-0232-89342a029f33@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1iRp9O-000LXR-Ou
Subject: Re: [f2fs-dev] [PATCH 3/3] Revert "f2fs: use kvmalloc,
 if kmalloc is failed"
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

On 11/05, Chao Yu wrote:
> On 2019/11/5 10:38, Eric Biggers wrote:
> > On Tue, Nov 05, 2019 at 10:17:41AM +0800, Chao Yu wrote:
> >> On 2019/11/5 8:02, Jaegeuk Kim wrote:
> >>> On 11/01, Chao Yu wrote:
> >>>> This reverts commit 5222595d093ebe80329d38d255d14316257afb3e.
> >>>>
> >>>> As discussed with Eric, as kvmalloc() will try kmalloc() first, so
> >>>> when we need allocate large size memory, it'd better to use
> >>>> f2fs_kvmalloc() directly rather than adding additional fallback
> >>>> logic to call kvmalloc() after we failed in f2fs_kmalloc().
> >>>>
> >>>> In order to avoid allocation failure described in original commit,
> >>>> I change to use f2fs_kvmalloc() for .free_nid_bitmap bitmap memory.
> >>>
> >>> Is there any problem in the previous flow?
> >>
> >> No existing problem, however, it's redundant to introduce fallback flow in
> >> f2fs_kmalloc() like vmalloc() did, since we can call f2fs_vmalloc() directly in
> >> places where we need large memory.
> >>
> >> Thanks,
> >>
> > 
> > f2fs_kmalloc() also violated the naming convention used everywhere else in the
> > kernel since it could return both kmalloc and vmalloc memory, not just kmalloc
> > memory.  That's really error-prone since people would naturally assume it's safe
> > to free the *_kmalloc()-ed memory with kfree().
> 
> Agreed.

Then, why not just keeping f2fs_kvmalloc() and replace all f2fs_kmalloc() with
f2fs_kvmalloc()?

f2fs_kvmalloc()
- call kmalloc()
- vmalloc(), if failed

I'd like to keep the allocation behavior first.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
