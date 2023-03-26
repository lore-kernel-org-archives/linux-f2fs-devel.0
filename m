Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE20C74A5B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Mar 2023 05:04:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgIY3-0002Oz-0Y;
	Sun, 26 Mar 2023 05:04:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1pgIY1-0002Oq-Ji
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 05:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k4rVIUAgbVmPVdh+2w/2nG22Kv+j5tPnLwsCx7fNYF0=; b=hxnEIK11VxA7S69kVR+0ABCnet
 PUPeyBXVkvTOCJQVyafgjnzAOBGiKMjjBHk+OdJaylmaGCi4FGMOxHItKyGt6kXlHHHzr/AL4mSMJ
 AVCkzxDMBeKJIa+po+Fr/EbnUHkuBfEXHEpCycwrAiWAcf1IKNH2sGZGQ8cbZU/rtSz8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k4rVIUAgbVmPVdh+2w/2nG22Kv+j5tPnLwsCx7fNYF0=; b=alY8O8HmMISgqPYiowQvuLdTOd
 DuBYq6wsaVHk1sYTccr1YUXUk5uJF6c7futFAWYcVkSm0qyuU0GyHtAt8KPEW6voLYcVthV5lW2j8
 SZ4DnmwvdhwBD8050P1Cupx0BPa64aE9U2+F23ASu7wgwGb1WlvBhN06WDp9VlefKFsw=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgIXz-003tXc-Dt for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 05:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=k4rVIUAgbVmPVdh+2w/2nG22Kv+j5tPnLwsCx7fNYF0=; b=F/mz5ZO9GTl5hYlKgNqBETFhyH
 7ceXXU1h+Jh5HitcN9VzvD3Eg44q2Filrb1aCy/YP82BsQAuC3eI0S2uMqkIAa+Ze1SSg8H3q3awm
 uVaDFGNfOjpdbq4pKySvuG6zKwHXlqtR/1QBahCU46Lf5w/2DmFRnpm9aI/NSGyBhApZ7K10Ltoyh
 su/ACZ3f08KWlWZPh2fgUL7xg07FOPNtaRzRUK0P3cm5EstyOCDjs6NQ/wHvLJM0+cGyq5vZUNt2s
 tLcpJN8bx/33exWsrrkovAkWOhTmrvlsAfY4t6OCaxplgLSbRkz5VkrkT6y1TUhEaqdzybQ5u1GMP
 kjcqSjkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pgIXl-0020lr-2Z; Sun, 26 Mar 2023 05:03:49 +0000
Date: Sun, 26 Mar 2023 06:03:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20230326050349.GE3390869@ZenIV>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-2-krisman@collabora.com>
 <20230323143320.GC136146@mit.edu> <ZB74FsfDDUegrqqx@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZB74FsfDDUegrqqx@mit.edu>
X-Headers-End: 1pgIXz-003tXc-Dt
Subject: Re: [f2fs-dev] [PATCH 1/7] fs: Expose name under lookup to
 d_revalidate hook
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
Cc: kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Mar 25, 2023 at 09:33:10AM -0400, Theodore Ts'o wrote:
> On Thu, Mar 23, 2023 at 10:33:20AM -0400, Theodore Ts'o wrote:
> > On Wed, Jun 22, 2022 at 03:45:57PM -0400, Gabriel Krisman Bertazi wrote:
> > > Negative dentries support on case-insensitive ext4/f2fs will require
> > > access to the name under lookup to ensure it matches the dentry.  This
> > > adds an optional new flavor of cached dentry revalidation hook to expose
> > > this extra parameter.
> > > 
> > > I'm fine with extending d_revalidate instead of adding a new hook, if
> > > it is considered cleaner and the approach is accepted.  I wrote a new
> > > hook to simplify reviewing.
> > > 
> > > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > 
> > Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> > 
> > Al, could you take a look and see if you have any objections?
> 
> Ping, Al, any objsections if I take Gabriel's patch series via the
> ext4 tree?

The really subtle part is ->d_name stability in there.  We probably are OK
as it is with the current tree (at least I hope so), but it really needs
to be documented - the proof of correctness is not straightforward and it's
going to be brittle; it's not obvious that this memcmp() relies upon the
parent being locked in all cases when we get to calling it.  And if that
ever becomes not true, we have a hard-to-debug source of occasional oopsen ;-/

It can be done without reliance on locking - take a look at the vicinity of
dentry_cmp() in fs/dcache.c for example of such, but it's very much not
a blind memcmp().  And I suspect that it would be an overkill here.

In any case, that needs to be discussed in commit message and clearly
spelled out.  Otherwise it's a trouble waiting to happen.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
