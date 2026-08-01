Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053B4C55171
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C2fc7TaaCW6IXFJRBPXlDFSaaBjF+ws1LfDw9cswmAk=; b=jHBem2RZhHOkdfDxE/7rFqjl8N
	vsouFry9ZZGuKRBz4wTi7Xg4zMkUh8ygpvFAkcZvI3T4q/jvepf+kLGNi2px70PFk5zGyTi5Ervm4
	LTh43xHfnTlQT03sUbgSh+21tn2Gjy2G8QNMosh2aSbdJ3/Lo8GtC7KzYh4Flgt2FXok=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpxse-0000Kf-BH;
	Sat, 01 Aug 2026 00:47:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <baoquan.he@linux.dev>) id 1wpxsc-0000KX-CK
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 00:47:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gMek1aawQ8IyooAOw8hjJzP++g15hi+kUNuEx4O2XuA=; b=cvfklL6Mgf6gXdSQyJLnwKGWc/
 aRRqXg+4hTf0Vv/hVfOQVjD+mtJdkiNI91qcCiEdmteEGDf4oq048rTs+YQW01PxX2PgUiqAyKYD+
 MqTyWl0cgHlCnT6tGTrlQOFomDoxc6i1uhISZcSf7PWytCOsMyI7dlQ6XOPMMpTbbQ3w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gMek1aawQ8IyooAOw8hjJzP++g15hi+kUNuEx4O2XuA=; b=WmCPVRAs0C5FtywLvVYRhAM+Xa
 Z+trOKeGVdLB9rACYx8LlYrfR5nN+AFBLfB5hgR0NYxe5AtprsLsC03AGtKCq+YyrH8g1jXso6tdY
 a5/vSCAlo7GY3q5ZMP4Be4oRweOh+H+Tqhr7648GmzrDH5GCMBbMBPRvAVj2kbhGfBdM=;
Received: from out-170.mta0.migadu.com ([91.218.175.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpxsb-00012A-Kb for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 00:47:07 +0000
Date: Sat, 1 Aug 2026 08:46:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785545219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gMek1aawQ8IyooAOw8hjJzP++g15hi+kUNuEx4O2XuA=;
 b=Lp/5WC0ukjnAn5o7N1qqH1jN1lRSaj6RecCQ9ONDeU+uZ3dm1b6L3FalP3D7qZ6EHAhVdC
 VlIh6gP28hAflRVDqF1Bq042TiBVII/vlLXde6jAxOk4MqdsHPCkYT7WPSTm3YwOPD+5px
 ZYNtt22HoOYMfrGxy6XWPDx99Au6IY4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <am1B_Mz21L54mrDS@MiWiFi-R3L-srv>
References: <20260730184853.48347-1-ebiggers@kernel.org>
 <amy7Biucbf-et5O2@MiWiFi-R3L-srv> <20260731181408.GA12803@sol>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260731181408.GA12803@sol>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1wpxsb-00012A-Kb
Subject: Re: [f2fs-dev] [PATCH] mm/swap: reject swapon() on filesystem-level
 encrypted files
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
Cc: Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fscrypt@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/31/26 at 11:14am, Eric Biggers wrote:
> On Fri, Jul 31, 2026 at 11:11:02PM +0800, Baoquan He wrote:
> > On 07/30/26 at 11:48am, Eric Biggers wrote:
> > > ext4 and f2fs don't prevent filesystem-level encrypted files from being
> > > set up directly as swap files.  In this case, encryption is bypassed.
> > > 
> > > No one should be doing this, vs. the methods of encrypted swap that
> > > actually do work (such as swapping to a dm-crypt device, or swapping to
> > > a loopback device on top of a filesystem-level encrypted file).
> > > 
> > > Nevertheless, to prevent user error, make swapon() explicitly reject
> > > this case.  Document this behavior in fscrypt.rst as well.
> > > 
> > > Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> > > Fixes: f424f664f0e8 ("f2fs crypto: add encryption policy and password salt support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > ---
> > >  Documentation/filesystems/fscrypt.rst | 4 ++++
> > >  mm/swapfile.c                         | 4 ++++
> > >  2 files changed, 8 insertions(+)
> > > 
> > > diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> > > index c0dd35f1af12..cba1989777da 100644
> > > --- a/Documentation/filesystems/fscrypt.rst
> > > +++ b/Documentation/filesystems/fscrypt.rst
> > > @@ -1238,6 +1238,10 @@ astute users may notice some differences in behavior:
> > >  
> > >  - DAX (Direct Access) is not supported on encrypted files.
> > >  
> > > +- Encrypted files cannot be used directly as swap files.  To swap to
> > > +  an encrypted file, set up a loopback device on top of it.
> > > +  Alternatively, encrypted swap can use a dm-crypt device instead.
> > > +
> > >  - The maximum length of an encrypted symlink is 2 bytes shorter than
> > >    the maximum length of an unencrypted symlink.  For example, on an
> > >    EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 78b49b0658ad..e4991da81b5f 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -3650,6 +3650,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
> > >  		error = -EBUSY;
> > >  		goto bad_swap_unlock_inode;
> > >  	}
> > > +	if (IS_ENCRYPTED(inode)) {
> > > +		error = -EINVAL;
> > > +		goto bad_swap_unlock_inode;
> > > +	}
> > 
> > Sounds reasonable to me.
> > 
> > One minor suggestion: it might be helpful to emit a pr_warn_once()
> > explaining *why* the swapon was rejected and pointing users to the
> > dm-crypt / loopback alternatives, so the -EINVAL isn't opaque.
> > Optional though -- the check itself is what matters.
> 
> How's this?
> 
>     pr_warn_once("Filesystem-level encrypted swapfile '%s' is unsupported. Create a loop device over it, or use dm-crypt\n", name->name);

Looks good to me, thx.

> 
> > And this patch updates fscrypt.rst. Would it be good to also
> > update the swapon(8) man page to document the new -EINVAL
> > condition?
> > 
> > Other than these,
> > 
> > Reviewed-by: Baoquan He <baoquan.he@linux.dev>
> 
> swapon(8) is for the util-linux program, not the syscall, so it doesn't
> document error codes specifically.  It does have a NOTES section that
> incompletely documents filesystem-specific constraints on swap files.
> It's missing most of the current constraints.  But sure, I'll send a
> patch that adds a note to there about this one.  That will be a
> util-linux patch.

Sounds great, thanks.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
