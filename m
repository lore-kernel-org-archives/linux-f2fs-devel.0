Return-Path: <SRS0=6WL8=UT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF315C43613
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jun 2019 04:58:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7D6208CB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jun 2019 04:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CPflgpZh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZFElhETG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7D6208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hdp9a-000322-B0; Thu, 20 Jun 2019 04:58:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <joe@perches.com>) id 1hdp9Y-00031l-Aq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jun 2019 04:58:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Content-Type
 :References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f/yjM4uSub3DdzevY7uwhzefhRpJW/Kgms41rrg8nac=; b=CPflgpZh6U3urgoO9bH30S0br7
 KSGkn1MdcZ6sNJLDrmii7Sa8MNqDFNyfO1OZ3aOxiJG1X8JNFze7G0XX/5A/fUcN8f+fz+DA+o9Sj
 BXezQ67RB2WKUabqVNcC38ErIYbz+6Nnku9XE1BMoxnV6OvPtGmn5ZmVNye2ZhgjaAnY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f/yjM4uSub3DdzevY7uwhzefhRpJW/Kgms41rrg8nac=; b=ZFElhETGrFhGtVX29gqh8wFOS1
 1IxZtEdQfvgwNXUVYJWMWRjLGJsIFm7ma9unirlDhlywkQgPUMrTPVrQIvWCDAPpj5bgrgihlZUHN
 e0jkKF1NoyjuByBpdMUwmknQA6W4BCzH2/frjUDXD1p9fcb4JnZPf8m3pNZVkRiQYQes=;
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]
 helo=smtprelay.hostedemail.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hdp9X-000tqT-6I
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jun 2019 04:58:29 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1F1E583777F0;
 Thu, 20 Jun 2019 04:58:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: meal99_65e1ef7a9d936
X-Filterd-Recvd-Size: 2249
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf19.hostedemail.com (Postfix) with ESMTPA;
 Thu, 20 Jun 2019 04:58:20 +0000 (UTC)
Message-ID: <e1f85a06454a88ee72f03f60cc55a30b60676df4.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 19 Jun 2019 21:58:18 -0700
In-Reply-To: <96d46153-8bf8-b152-2ae3-3ddeac0ba914@huawei.com>
References: <20190618094842.19332-1-yuchao0@huawei.com>
 <20190619180150.GC57884@jaegeuk-macbookpro.roam.corp.google.com>
 <bf8ad99f0f5d1cb5adde3eb6046a226c78930730.camel@perches.com>
 <20190619205232.GD57884@jaegeuk-macbookpro.roam.corp.google.com>
 <96d46153-8bf8-b152-2ae3-3ddeac0ba914@huawei.com>
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
X-Headers-End: 1hdp9X-000tqT-6I
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce f2fs_<level> macros to wrap
 f2fs_printk()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 2019-06-20 at 10:08 +0800, Chao Yu wrote:
> On 2019/6/20 4:52, Jaegeuk Kim wrote:
> > On 06/19, Joe Perches wrote:
> > > On Wed, 2019-06-19 at 11:01 -0700, Jaegeuk Kim wrote:
> > > > On 06/18, Chao Yu wrote:
> > > > > From: Joe Perches <joe@perches.com>
> > > > > 
> > > > > - Add and use f2fs_<level> macros
> > > > > - Convert f2fs_msg to f2fs_printk
> > > > > - Remove level from f2fs_printk and embed the level in the format
> > > > > - Coalesce formats and align multi-line arguments
> > > > > - Remove unnecessary duplicate extern f2fs_msg f2fs.h
> > > > 
> > > > Can we just use sbi for f2fs_<level>?
> > > 
> > > Not really.  see below:
> > 
> > Since sbi = F2FS_SB(sb), I don't see any problem.
> > 
> > > > And, could you please change missing
> > > > f2fs_msg() in the latest dev?
> > > 
> > > Anyone is welcome to refresh the patch as necessary
> > > or appropriate.
> > 
> > Could you please take a look at this?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=697743b1c1025483c97c740cd8834711be4294eb
> 
> Looks good to me.

Me too.  cheers, Joe




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
