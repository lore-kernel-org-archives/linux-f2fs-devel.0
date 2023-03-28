Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62782C6FD18
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Mar 2023 23:03:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1phILW-0007bm-WD;
	Tue, 28 Mar 2023 23:03:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <SRS0=rtO5=7U=goodmis.org=rostedt@kernel.org>)
 id 1phILV-0007bg-BT for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Mar 2023 23:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SB9w82fhlUxJZf5bnDsQGaJFPyqtHiCdIwmjN+lkY+8=; b=mRhqd4uQlbbcql7aQMVy+qmeG+
 J/2ywN805J0PQuHP45SazELsmFXh6kNaOvfl3iL/BJJsflTRUsL91Z9XYfKyneFgVObU9MSRz7Tu9
 xE86CRk6wmdoiF0gqrX6ApQniynzTyl3JWDI+H8WCnTXNSaTKteaqliNjaamUNPl51gg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SB9w82fhlUxJZf5bnDsQGaJFPyqtHiCdIwmjN+lkY+8=; b=Cp6121eNnFmPdfb/eJKoO7V8dI
 F+of8r2ZWvlNjLhh/mrdqQSznxGN4SFRF4T49UqTogcWEDr4cdaNP+UBSo9m9fAHD1W/i03T+/+C7
 laQJZrh9hQW/spO/p+FRaOQdRiZSVz3TCEu3VKdyw6Wiwhpuf1bssgXa1j5kwnOcbmz8=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1phILV-007elk-2E for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Mar 2023 23:03:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BFDBEB81D7A;
 Tue, 28 Mar 2023 23:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855D3C433EF;
 Tue, 28 Mar 2023 23:03:08 +0000 (UTC)
Date: Tue, 28 Mar 2023 19:03:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: patchwork-bot+f2fs@kernel.org
Message-ID: <20230328190306.3337b7b0@gandalf.local.home>
In-Reply-To: <167821082479.1693.18260840022075703789.git-patchwork-notify@kernel.org>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
 <167821082479.1693.18260840022075703789.git-patchwork-notify@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Headers-End: 1phILV-007elk-2E
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace
 event
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 mhiramat@kernel.org, jaegeuk@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Douglas RAILLARD <douglas.raillard@arm.com>,
 linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, 07 Mar 2023 17:40:24 +0000
patchwork-bot+f2fs@kernel.org wrote:

> Hello:
> 
> This patch was applied to jaegeuk/f2fs.git (dev)
> by Jaegeuk Kim <jaegeuk@kernel.org>:
> 
> On Mon,  6 Mar 2023 12:25:49 +0000 you wrote:
> > From: Douglas Raillard <douglas.raillard@arm.com>
> > 
> > Fix the nid_t field so that its size is correctly reported in the text
> > format embedded in trace.dat files. As it stands, it is reported as
> > being of size 4:
> > 
> >         field:nid_t nid[3];     offset:24;      size:4; signed:0;
> > 
> > [...]  
> 
> Here is the summary with links:
>   - [f2fs-dev] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
>     https://git.kernel.org/jaegeuk/f2fs/c/3ccc99d5a4ea
> 
> You are awesome, thank you!

I'm hoping you are not waiting for the merge window to get this in. Please
get it to Linus before rc5 is out, because I plan on adding my patch[1]
which will cause this to fail the build at rc5.

The above is a fix to bug that causes unwanted results. Please get it into
mainline ASAP.

[1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/20230309221302.642e82d9@gandalf.local.home/

-- Steve


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
