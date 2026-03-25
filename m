Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BF8109C02D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3V6dfxwdo1PuO1zFZS1DBHPMP4LW87IrJj1RFH9Dk8=; b=TcYhie39XTFyo2PQ1v7w7QDgKW
	ZtMcF1KSDaZPJ+Z2iWd1b0Wu22E/T/TE45hDmUXrJYx+GcZbG+C9cX+QHUZ1O4QHdZvqfs+6SNMlx
	i5BDt2H24Nl3Oor69QjXX7kfW3Qf20/++WXD+pjrbFCXQahcl+eHlTXWBrsKAhYtvNL8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5Pd5-0002Ba-SI;
	Wed, 25 Mar 2026 14:54:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <peterz@infradead.org>) id 1w5Pd4-0002BR-Kx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 14:54:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=At8D6t8yuaFnfRWs27P1HqTbJ1UkmyaaaoFtD7Fze7Q=; b=Fk+nJz06ZMauf2q3p1iat/UIAA
 TwyR2Ox9ij5mTiheFUMZzHkrmENU+ckgTMZo+lMFruUYw7XoLzuH4GZonvQ471g2R4zLzSH0WJgYl
 VWKWmFQrV77XvhYGMGe+2OGavS4aGlAs++pUB2z35Sg4UkRxe1u3bVHUU40zEEahX71I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=At8D6t8yuaFnfRWs27P1HqTbJ1UkmyaaaoFtD7Fze7Q=; b=fitZx92jJ4XAsQQ21NPfTcmmOx
 BajRu9e8kbH8+MsUH0LkgdEsw6iyuRogY78+1EiAjc9aDb5XmU+fJRXLwHuy7hg+aRXBsy9Vhe1/X
 NgNsQbz6Fnz5u/kbkbKbrpInU2AgqWP0xFgnY0yLIQDZXAhsq+kdEOT3ctM8xjzNAyjE=;
Received: from desiato.infradead.org ([90.155.92.199])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5Pd3-0005MI-61 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 14:54:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=At8D6t8yuaFnfRWs27P1HqTbJ1UkmyaaaoFtD7Fze7Q=; b=ZuRQYmzTxU3qqN7KW/tJ3a0YIq
 5jz9qSvxevYd9Fm/Ve56OoZKHRBbZA8BqBzZhAgpCGEmUnqF1fhtbbpgTemGPRZqP5GSC9fkrQdPM
 Ycnlh1WVoZPvFcgGaPKmdIXfVipRvyvCL11kK/BjB8ApUPSW4pd0uDtvsEXhMR0CBjd2UCrlvWI+A
 B8In2rc2thyDtYDkgfPlyQTI8u4MhhJKF4TtHDvyIotw1wNTf0stnc3vMmFYO2U2dNT5SFtkiof87
 4JnyJdLBplb6GqyCHw2su9aSoB7H9rNwHGI4FPeD+iTkFnl4DDulqIxNxynGlebmuiGKKuLDoe11K
 LsQYsdCA==;
Received: from
 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl
 ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1w5OgY-00000006HPw-3uxa; Wed, 25 Mar 2026 13:54:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 6B826300578; Wed, 25 Mar 2026 14:54:13 +0100 (CET)
Date: Wed, 25 Mar 2026 14:54:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: ruipengqi <ruipengqi3@gmail.com>
Message-ID: <20260325135413.GY3738786@noisy.programming.kicks-ass.net>
References: <20260325133322.1050573-1-ruipengqi3@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325133322.1050573-1-ruipengqi3@gmail.com>
X-Headers-End: 1w5Pd3-0005MI-61
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
 Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org,
 Joel Granados <joel.granados@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Ingo Molnar <mingo@redhat.com>,
 John Stultz <jstultz@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Waiman Long <longman@redhat.com>, Zi Li <amaindex@outlook.com>,
 jaegeuk@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Tomasz Figa <tfiga@chromium.org>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


I still fully and totally detest all of this :/

On Wed, Mar 25, 2026 at 09:33:22PM +0800, ruipengqi wrote:

> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 555e2b3a665a..61fa97da7989 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -29,6 +29,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/debug_locks.h>
>  #include <linux/osq_lock.h>
> +#include <linux/hung_task.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/lock.h>
> @@ -191,7 +192,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  		   struct list_head *list)
>  {
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -	WRITE_ONCE(current->blocker_mutex, lock);
> +	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
>  #endif
>  	debug_mutex_add_waiter(lock, waiter, current);
>  
> @@ -209,7 +210,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
>  
>  	debug_mutex_remove_waiter(lock, waiter, current);
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> -	WRITE_ONCE(current->blocker_mutex, NULL);
> +	hung_task_clear_blocker();
>  #endif

Your functions have stubs, you can get rid of those ugly #ifdefs


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
