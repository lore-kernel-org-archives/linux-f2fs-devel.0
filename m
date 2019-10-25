Return-Path: <SRS0=QQ8V=YS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521AACA9EA0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Oct 2019 18:22:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206C421D7F;
	Fri, 25 Oct 2019 18:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="j6dHqM8w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="W7HQgMwi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9gRv3Pn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206C421D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iO4EX-0005ci-OT; Fri, 25 Oct 2019 18:22:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1iO4ET-0005cU-Sa
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Oct 2019 18:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1IF8ofIQptOiiIlI4YKM5vYiV24B1i1cYwAJ7jhdoOo=; b=j6dHqM8wE5fOry8RvPNKgSav1z
 yvgw5GZEAqymPO2KBynwQQZARg4qjm/mGA1gyTyGzZhef04wZ54GAoZC58RlQN2w53qCTA8gNPIeQ
 rl8RBQQdUsvncW2a3VroOx0QD4hcZkoLZGlocLP7Pv7NBEOTQ5nvyF7ZIry5z9A1IOsA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1IF8ofIQptOiiIlI4YKM5vYiV24B1i1cYwAJ7jhdoOo=; b=W7HQgMwiydPLH0fmmbjRfkfa+y
 lyg09nsoIOIQCPit7tFEzEOIwUMIGTOsyPADoHHw5y+wxy4EivwR0QdnMCRFVAP/lNQ4oUSJKnY6z
 7vjrgK5AQJT3cF2vjwenjfbud4seF6Wx7S6BsoW6/+xG4PXWLEdqpmvrwl6hag8xzMy8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iO4EN-00H2TN-Uf
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Oct 2019 18:22:41 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B9D12084C;
 Fri, 25 Oct 2019 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572027750;
 bh=jW3jhqREmHORgTivuUZILx5c8BXB7MCqCsxfyYoTJfI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t9gRv3PnUM3r7KhTPTtMv8ROhUaBDWEUF7FCnlh+0l4w4+zoMpQ3b6vLpBbO9WHo/
 CXt/pfcTMNW0UR452lG1uxx8a3/KzORuZvF8+PtK6BmIt+wgQGp7SnPQiqefqgmiwy
 afeUzhutXpqXCjIlBQj/AVcdDher7NzO+4kWtkj8=
Date: Fri, 25 Oct 2019 11:22:29 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20191025182229.GB24183@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191023214821.107615-1-hridya@google.com>
 <20191023214821.107615-2-hridya@google.com>
 <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
 <CA+wgaPNas7ixNtepJE_6e7b6Dcutb9a1Who4WrUfKSw1ZnQhTA@mail.gmail.com>
 <96f89e7c-d91e-e263-99f7-16998cc443a7@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96f89e7c-d91e-e263-99f7-16998cc443a7@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1iO4EN-00H2TN-Uf
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: Add f2fs stats to sysfs
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
Cc: Hridya Valsaraju <hridya@google.com>,
 Android Kernel Team <kernel-team@android.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/25, Chao Yu wrote:
> On 2019/10/25 11:51, Hridya Valsaraju wrote:
> > On Thu, Oct 24, 2019 at 2:26 AM Chao Yu <yuchao0@huawei.com> wrote:
> >>
> >> On 2019/10/24 5:48, Hridya Valsaraju wrote:
> >>> Currently f2fs stats are only available from /d/f2fs/status. This patch
> >>> adds some of the f2fs stats to sysfs so that they are accessible even
> >>> when debugfs is not mounted.
> >>
> >> Why don't we mount debugfs first?
> > 
> > Thank you for taking a look at the patch Chao. We will not be mounting
> > debugfs for security reasons.
> 
> Hi, Hridya,
> 
> May I ask is there any use case for those new entries?
> 
> So many sysfs entries exist, if there is real use case, how about backuping
> entire /d/f2fs/status entry into /proc/fs/f2fs/<dev>/ directory rather than
> adding some of stats as a single entry in sysfs directory?

These will be useful to keep a track on f2fs health status by one value
per entry, which doesn't require user-land parsing stuff. Of course, Android
can exploit them by IdleMaint, rollback feature, and so on.

> 
> Thanks,
> 
> > 
> > Regards,
> > Hridya
> > 
> >>
> >> Thanks,
> > .
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
