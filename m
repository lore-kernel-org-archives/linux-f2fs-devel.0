Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4899C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jan 2022 20:07:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n70x6-0003iO-1U; Mon, 10 Jan 2022 20:07:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <timmurray@google.com>) id 1n70x4-0003iG-C2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 20:07:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jhs7IL4TuG8oCYTZuQ1+Jl2xnZ/ELPkPUon97c59VHo=; b=JCpWFF4x4KcRZ/5X7Ze+RqX+UM
 AarmzvEWmHEmJV3CnL9AfZG4qg5eLjXU6NFsIBEH1biDRCXxg4paYGdHHGoA4lr+1NlcPWztl9kNB
 ZIWy4IpD2ta9IosQKy+MewAwieLl5GnwYRPL2iFr2tBACpxaKQS1F+B11kE3xlJzdO78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jhs7IL4TuG8oCYTZuQ1+Jl2xnZ/ELPkPUon97c59VHo=; b=G70/CFB4DG4cPJ2HBqg6zK2O+k
 TcmxroGN5L9O3oE1XqjEZYqNkAR+QzCohXz54hSnm7aSEJTcHsWWtsN1JzWndESdS6e00SGlcIPpe
 pej0hrbu4Y3f7U8kiE1Q4znvl+xnEQiNojHTvDSZyiwLZOeAeovS4ZcOZS1/zaJj++RU=;
Received: from mail-io1-f50.google.com ([209.85.166.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1n70x2-00Au60-0s
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 20:07:32 +0000
Received: by mail-io1-f50.google.com with SMTP id y11so19152749iod.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Jan 2022 12:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jhs7IL4TuG8oCYTZuQ1+Jl2xnZ/ELPkPUon97c59VHo=;
 b=n3MYFNks8/IOT2YjufrlS6VEYPjy+x1daJ7/2YzdsLN9cvg+2nz1u71iTNIMhbnFe7
 wquK+2gOG4YskjWfRH51WQLgm20kTM9GtpF5hWSkW+izvrK4NqgJaa/bK0wYENtAUkN7
 1pxE4MOYIThkesUn4tpRCvuuQUkAcnkB5cNu7NbcYw7o006A3FuZVTs+Yii8denc1Loi
 2x8dBg15cZrOp36xIfc3Me3YJfCui7TuoNS20XElI1OqfCrAW9wpEfgSrr72wyojueDT
 9fxMMb4g24j4dY/64E2J9VTuK0emyLAtJeJG31/AZAQMKlWhP0CCsDiWgaQBeIBCE650
 HQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jhs7IL4TuG8oCYTZuQ1+Jl2xnZ/ELPkPUon97c59VHo=;
 b=CSbyzqrdYbAGtnpO/F5LXYcTvbl1+TDfThfRmpkiLAVcMAH+p/q4zYRjG+U0wu00Vs
 MLKjr23ts+kiALpDjIqenDbxZLHR4HVgqK5+Y4zgNoR5SZBuAyS+TMEBV1PTwAKpPenu
 BRHbOVE5yf9KNUUYkxbQANa7IgmzC5SnVw4e1ioj7qlsrB2lUm9pdLZoX71cMuid+5SR
 /ulol4nHveXifYLbIKxETPJgA+qF3D1LTle1RNZLdHkjF5VbGlmM7zXtvu379DLB68dH
 8tA/a+uesJFEVyzmTtAtjvmJ6bdQJYoy8rF8Fo/JKerLgnF/FL/DCT824iT7tcl4on6A
 rvpA==
X-Gm-Message-State: AOAM531rpemPV50IWTjlYA8RVqIobetlEMEJu+OHlYKaPNPvAQJNt79O
 Cf89RFek1c5eHHCZk+DkFkQSPstXcfvi+uXxUd5cVZJJ6X8=
X-Google-Smtp-Source: ABdhPJxhjNm6icsqOGOpoFOONXUNbXjRqEF5soc9izmdW9/IxaC/kPfcJo0PCuHyrH747FDUTCl0MmpF8k0bksOJZYk=
X-Received: by 2002:a92:ca90:: with SMTP id t16mr735783ilo.173.1641843694664; 
 Mon, 10 Jan 2022 11:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
In-Reply-To: <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
Date: Mon, 10 Jan 2022 11:41:23 -0800
Message-ID: <CAEe=SxnWeK0pSfijPKJSTxBiMgD1Ev69fV3qSTCgWASk0b3vhA@mail.gmail.com>
To: Waiman Long <longman@redhat.com>
X-Headers-End: 1n70x2-00Au60-0s
Subject: Re: [f2fs-dev] [PATCH] f2fs: move f2fs to use reader-unfair rwsems
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
From: Tim Murray via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Tim Murray <timmurray@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 10, 2022 at 7:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> Can we start by describing the actual problem?

Of course. Sorry, I didn't realize Jaegeuk was going to move so
quickly with this patch :)

We have a few thousand traces from internal Android devices where
large numbers of threads throughout the system end up blocked on
f2fs_issue_checkpoint(), which userspace code usually reaches via
fsync(). In the same traces, the f2fs-ckpt kthread is often blocked
around f2fs_write_checkpoint(), which does the actual fsync()
operation on behalf of some number of callers (coalescing multiple
fsync calls into a single checkpoint op). I think the problem is
something like:

1. f2fs-ckpt thread is running f2fs_write_checkpoint(), holding the
cp_rwsem write lock while doing so via f2fs_lock_all() in
block_operations().
2. Random very-low-priority thread A makes some other f2fs call that
tries to get the cp_rwsem read lock by atomically adding on the rwsem,
fails and deschedules in uninterruptible sleep. cp_rwsem now has a
non-zero reader count but is write-locked.
3. f2fs-ckpt thread releases the cp_rwsem write lock. cp_rwsem now has
a non-zero reader count and is not write-locked, so is reader-locked.
4. Other threads call fsync(), which requests checkpoints from
f2fs-ckpt, and block on a completion event that f2fs-ckpt dispatches.
cp_rwsem still has a non-zero reader count because the low-prio thread
A from (2) has not been scheduled again yet.
5. f2fs-ckpt wakes up to perform checkpoints, but it stalls on the
write lock via cmpxchg in block_operations() until the low-prio thread
A has run and released the cp_rwsem read lock. Because f2fs-ckpt can't
run, all fsync() callers are also effectively blocked by the
low-priority thread holding the read lock.

I think this is the rough shape of the problem (vs readers holding the
lock for too long or something like that) because the low-priority
thread is never run between when it is initially made runnable by
f2fs-ckpt and when it runs tens/hundreds of milliseconds later then
immediately unblocks f2fs-ckpt.

When there's a lot of oversubscription, threads running IO, etc, we
see f2fs-ckpt stalls of tens to hundreds of milliseconds per f2fs-ckpt
iteration. In one recent experiment of the immediate aftermath of
booting and unlocking a phone for the first time, over a 10s period,
we saw f2fs-ckpt blocked on the rwsem for 9.7s, running for <50ms over
110 separate slices (so probably ~110 fsyncs), and blocked on IO
operations for <100ms. The worst 10s period I can find in a similar
experiment with the unfair reader approach has f2fs-ckpt blocked on
the rwsem for 130ms, running for 20ms over 95 slices, blocked on IO
for 40ms, and sleeping the rest of the time.

Unfair rwsems are rarely appropriate, but I think the lack of fairness
makes sense here because of the relative importance of f2fs-ckpt vs
any particular reader of that rwsem. The one concern I have about
down_read_unfair() is whether the fairness should be a property of the
down_read operation or the rw_semaphore itself. In the f2fs case, it
seems like all read locks of the rw_semaphores should be unfair and
that adding a single fair down_read() could introduce a similar
regression, but duplicating rw_semaphore also seems bad. If it does
make sense to make the fairness a property of the semaphore, could
that property be flagged in an init_unfair_rwsem() macro and then
checked in lockdep?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
