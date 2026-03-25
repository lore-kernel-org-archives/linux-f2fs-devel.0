Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58010109C02F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Mime-Version:References:In-Reply-To:Message-Id:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lPIA4pF5MQgXJqS6WnlOFX9Kxv+uXXZ0P+58u7HsAYE=; b=UWU9YoVfBlfaGNvHVe3RSZHkaf
	pDd5nyD6TOuRWxDiBD77XCkWRnr2DmZRtwIoXZoIRNo2N+2obE5+crMJ2UXqpbW2LgBFpR9umRQau
	LqTheBQ9WEXEOP6P73M9Uu8xdr1t65O0M/hnqkuExoizD6bYYQRxR3nYcC4kYo0fjw3Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5Pt7-0006EO-05;
	Wed, 25 Mar 2026 15:11:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <akpm@linux-foundation.org>) id 1w5Psk-0006DS-2F
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:10:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dH/HikHS0Z43yKF1/mCPjOqgmV+U9gh7c/HR1qGU5to=; b=gxYup8uwo6NXECTD8+edwOXTC3
 DMFfipjNsH5ldj8JQwnh28O1JQYX04BmgbFtAZ8VCiVk+Bzz5eHZmKFyMEsHlixD3Y+sCSinLb7YJ
 Fm7QIi6kgyFXCoRiQ33XDAX4F3Xlcs9bHQHxOcoxEhheSjYeK19Lu57GZlgFcrGLxY6c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dH/HikHS0Z43yKF1/mCPjOqgmV+U9gh7c/HR1qGU5to=; b=MglfMPhLPKSLvNRlO7lhGmqGhh
 GYgT6+cVx4lvKWhkjNoURn/QhnjW5LE39eO8c0wB9fmlV7OrcSk64kcEJT3KfoQKokdK13QdNTgLb
 GLmXNP1RcbrtAWEqCTpmI8ujvJ2E3Tn207K+Jdt/K55TwpkbdGuVU8G7Z9eqNeX9dc0E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5Psj-0007Si-Ei for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:10:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3235341661;
 Wed, 25 Mar 2026 14:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E794C4CEF7;
 Wed, 25 Mar 2026 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1774450414;
 bh=q2p/caJLu8pgVOjdyT3CZ8x/Y2Xscg0zLpvXvsseD8s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=D+hj6iIk+0w+xk85T8d/IyEtFWgl4HYqHqdhqdUgrNWbItcGpyg7gBkHlwVQFaSjM
 hlTFjZnwPnx9tFFn7OWGrErqZKHx+RMUOuqa0NIbVvD4PQBlu5KGgdgAtUEpOA4RZV
 HjFakHOJnfaFHVScNx5U2pNor538ZXzijk/44xxA=
Date: Wed, 25 Mar 2026 07:53:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Message-Id: <20260325075332.c32528cd5a16bc7886421a1b@linux-foundation.org>
In-Reply-To: <20260325135413.GY3738786@noisy.programming.kicks-ass.net>
References: <20260325133322.1050573-1-ruipengqi3@gmail.com>
 <20260325135413.GY3738786@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1w5Psj-0007Si-Ei
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

On Wed, 25 Mar 2026 14:54:13 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> 
> I still fully and totally detest all of this :/

This is one of those mystery sends of material which has been upstream
for nearly a year.

I don't recall you weighing in when this was under discussion - did I
miss something?

What's the objection?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
