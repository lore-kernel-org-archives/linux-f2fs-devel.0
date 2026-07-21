Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EE0C4452D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=314WpMuwH6wsyQYvNj5cX/6o1zM7MDDYvMC0L8xONNU=; b=dEfeg98C4OPgUHiGvt4mBE6+tJ
	QUIqf9TRokm3OSJyX35MfKewYwExTqmbloaxi1FJbShaBRfIkeo9acXxeLyrg1+HLBtlKMHnBpTCY
	M/bd0wgZetw5o/qMGmE4wQUjhc1xU3ad8wHbZbUToeAtNDVU/mBmwhMB270LPoa/59Y4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmJOs-0007X7-Jn;
	Tue, 21 Jul 2026 22:57:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wmJOn-0007Ws-4I
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:57:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0hkPjTUdaj568jeuea2sBw3RB9UhtApfx4Bt0GOlMcI=; b=f9adey4qkkUQSt8eA0vNlXVqB9
 2LPp3de54MKYQ10nZhviyesPanK7+fSdcZ45C63Mtbv3XdKnFMYX8+NIRZAMsOKT12Uedkdoy4Akq
 cC5YJNUIqUi+CWAJo0TzJM7Fu4GhNe10mEVIRDk3pA9SvIs5XmAMpk6WxpGGjLtbMpLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0hkPjTUdaj568jeuea2sBw3RB9UhtApfx4Bt0GOlMcI=; b=K00vmkFffUrVttdPQoRxu6zNpn
 uLLukf6kdrfJGZLWW7spF1OBMUcv+uEuCWNPh4glps9bX6ZY6+KDXNU4kY+AOJqcnKOuHPZZoUfAU
 podR9wr4PynXkMEyEV4OjDGFxnjIbgsEzJaOHNNXu18EYD9N1Na9ALweuKzRLLwsHGNA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmJOl-0004Tk-BZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:57:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 9E70560A65;
 Tue, 21 Jul 2026 22:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 450331F00A3A;
 Tue, 21 Jul 2026 22:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784674624;
 bh=0hkPjTUdaj568jeuea2sBw3RB9UhtApfx4Bt0GOlMcI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QN8EBaaAr15H560q2O9dzU7JbBf/AeEDJ3RakO1jVJ388FxNQeG5h2nKy9Lk4ELA7
 lM08UvIGQDWe+zu1kOwoKDfzp1dsirgxIh8oN9lZTMAHL/alDOJARUQu4j1FyF7PiV
 10MM4rMXOovaqC5NA9u9sRK+epsZlFuwcrflfYFR9O1S2PzD0TA3VztxfZY0F5aDHw
 +6A9ewWquWzzB9IZY5AuOJOuggi9qzueluDAveUIBvie6rz6MAKKUd6IP6vpgP+Cto
 B1y80olZX3NljqRBbmbry+cAQuUgWf3rLXdagWjbEIYAfBcfq6KSiWB+Izo62if78x
 uD0RYeu9rW+Fw==
Date: Tue, 21 Jul 2026 15:57:03 -0700
To: Anand Suveer Jain <asj@kernel.org>
Message-ID: <20260721225703.GZ7380@frogsfrogsfrogs>
References: <cover.1781694879.git.asj@kernel.org>
 <2ac5fb22fd6b51973d11082a1ee8fe354926c63c.1781694879.git.asj@kernel.org>
 <20260701173314.GH6517@frogsfrogsfrogs>
 <328de723-6f9c-4f09-a68a-da24d49300d5@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <328de723-6f9c-4f09-a68a-da24d49300d5@kernel.org>
X-Headers-End: 1wmJOl-0004Tk-BZ
Subject: Re: [f2fs-dev] [PATCH v7 06/11] fstests: verify f_fsid for cloned
 filesystems
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@infradead.org, zlang@redhat.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 22, 2026 at 06:36:13AM +0800, Anand Suveer Jain wrote:
> 
> 
> > This is where I continue getting stuck on this patchset -- fsid is so
> > poorly defined that I don't think the rest of these fsid tests make
> > sense at all.  Nobody mandates that fsid is persistent or stable across
> > remounts.  Nobody even mandates that two cloned filesystems don't have
> > the same fsid value.
> > 
> > The statfs manpage says:
> > 
> > "Nobody knows what f_fsid is supposed to contain (but see below)"
> > 
> > and then:
> > 
> > "The general idea is that f_fsid contains some random stuff such that
> > the pair (f_fsid,ino) uniquely determines a file."
> 
> Which is exactly why we need fstests guardrails.
> Keeps filesystem's implementation consistent across kernel versions.
> Embarrassingly, I introduced a bug around this that is now fixed.
> The commit IDs are in the test cases.
> Thus motivation for this fstests patch.
> 
> > Based on that very weak statement, at most it might make sense to check
> > that two separate and simultaneously mounted filesystems don't end up
> > with the same fsid 
> 
> Yes, for xfs, btrfs and f2fs. However for ext4 cloned filesystems can
> share the same fsid and ino because the images are identical.
> It is then up to the usecase to change the UUID for either filesystem if
> it gets modified.
> Commit ("fstests: add _require_unique_f_fsid() helper") captures this,
> and the link in that commit includes the discussion.
> 
> > just in case there *are* programs foolish enough to
> > use (fsid,ino) as a uniqueness check.
> 
> On the other hand, if a program needs a unique ID, do we currently have
> any way to get one?

I don't think there is a way to get a globally unique identifier for a
filesystem image except for the meta_uuid filesystems, and even then
only if the volume manager resets the user-visible uuid every time it
makes a clone and nobody runs a duplicator.

--D

> Thanks, Anand
> 
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
