Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B9D109C028
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANuDp+dSUAV3KLXQd7YCLaILUVSdQbJSSY0Vxsn0sWo=; b=OV96qATjHOBYdUmc8GzNbUEZqD
	qwaLxgjbIHN97s7IXVNuTrU90XrymML5sDBahjU6KQIdBRdTtdCWGnXtGSQXUyMVNKPuG1R1T/Tvj
	tvrLM/f4m6tmN8mN6HfhfVPt3ZeRPSuETe3tLVTfXDobHGg9OQWr9TOsaJ7uVwkuJ+zU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5PmK-0002VY-HR;
	Wed, 25 Mar 2026 15:04:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <peterz@infradead.org>) id 1w5PmJ-0002Un-55
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mIuxSunehHiRSvG/GnXThLOJmIPoTa6dLKg7+KpmcBA=; b=dIPo4k5gDDxy8fk/w50qwuI9Z1
 xOdQ0pvanh9DLdqzd6SYlcQxXJ0e9I8AMOoTDrAI8ncV6TgwPny/M1aOEWuYm7J8CU6JJf+Q09/Ew
 MPrBDMxfLXNa3cLklMsSewiWTd5MHzJNHPSbq/1BV1R38DtgGypoywUrRKJnZsvUhEj0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mIuxSunehHiRSvG/GnXThLOJmIPoTa6dLKg7+KpmcBA=; b=cArqYrvtGbYiwesdya0sJBNdJL
 2pWl1zLXjnMN7pQUJJbtGEqhoZ9W3KN1j+8bp5eCxvGaSte4TqJdjzGwC/RJi5YydBxNAsKhtlw7I
 hSV/xWmGE8m4tK2bMK6PZySdJuKZsyeji8odAQ7BvgQSWmkJ3AhV+9EzRFVJLUzfk1T8=;
Received: from desiato.infradead.org ([90.155.92.199])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5Pm5-0006Ve-Rs for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mIuxSunehHiRSvG/GnXThLOJmIPoTa6dLKg7+KpmcBA=; b=m6jz0KGhdEoAUzgiWb3fMvmDvc
 diJl7nyhbSFzgiGsfrgyVrz4dFAu7PFy615kqUx1xmRJ2zhHEsNkmNZ5GRHCGZc0m685PQhyAmua/
 rZQJokxeHWs8tu9c9w5twyMGh6WicQyemkXAAA4W62R+jrxq7nww7a9CTXsL+5KQcm4GEo0+fSJnm
 p6N9wqVCq5BIYtfe2aX/qKZB73AAYeBOl2FrHhJmFTSS71WrVD6f05aXHYWjDE7y+SE1LXLWcj8hx
 KwJw20b6kNG6FoSMVZ9xbKVd2CfjY37v2Rib3lAvgp1Fx5M9rndMliOQbnEmCcGv+ZcX7GkJdUl/A
 ypSW7qRQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1w5Pli-00000006QVL-2LxD; Wed, 25 Mar 2026 15:03:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id E8F88300400; Wed, 25 Mar 2026 16:03:36 +0100 (CET)
Date: Wed, 25 Mar 2026 16:03:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20260325150336.GF3738786@noisy.programming.kicks-ass.net>
References: <20260325133322.1050573-1-ruipengqi3@gmail.com>
 <20260325135413.GY3738786@noisy.programming.kicks-ass.net>
 <20260325075332.c32528cd5a16bc7886421a1b@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325075332.c32528cd5a16bc7886421a1b@linux-foundation.org>
X-Headers-End: 1w5Pm5-0006Ve-Rs
Subject: Re: [f2fs-dev] [PATCH 1/2] hung_task: replace blocker_mutex with
 encoded blocker
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
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, ruipengqi <ruipengqi3@gmail.com>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org,
 Joel Granados <joel.granados@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 John Stultz <jstultz@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Waiman Long <longman@redhat.com>, Zi Li <amaindex@outlook.com>,
 jaegeuk@kernel.org, Tomasz Figa <tfiga@chromium.org>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 25, 2026 at 07:53:32AM -0700, Andrew Morton wrote:
> On Wed, 25 Mar 2026 14:54:13 +0100 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > 
> > I still fully and totally detest all of this :/
> 
> This is one of those mystery sends of material which has been upstream
> for nearly a year.
> 
> I don't recall you weighing in when this was under discussion - did I
> miss something?

I'm sure I replied at some point, because the original was going to
abuse the blocked_on field, which we need for something else.

> What's the objection?

Death by a thousand cuts and endless duplication of stuff and nobody
should grub at lock internals.

We have a ton of lock debugging stuff, but because $raisins people don't
want to run their misbehaving crap on a debug kernel, so we must put
'cheap' hacks into production kernels :-(


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
