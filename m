Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F3AC55173
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbJgUYSy1Ib9G8SS6+mh2ieFrZ1DfsTaNS8JJVgya70=; b=ZdLEfSZPWIrOqKZf9q2M/At1uj
	whj/ai9O8w5IVP49appBAtw0ANYXyfBsQ6V9xGS6sJZMdwDRDP5G9gJcuWKS7IIgqHfcdmGkm9SGw
	PH5/Dvwhkf1L59X/+wNmFRLYStsOVPNdQcqxKFLl2XvAglYJvMbg+91M34VDoPuXyX2w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wprmF-0004y2-Jf;
	Fri, 31 Jul 2026 18:16:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wprmE-0004xv-GD
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 18:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9wUJP0XuZAHVCju2vCQtbQJIE3DcNFW1LWD6svK3iD8=; b=WcEplRkqZ6VZeG7mwb1XDWtUHx
 aF07DhWZ01Y+vYsNPoUkPhVL9A3VLMNSpyMhJEs1nmlwXMs69v46XVfMVuQ7ACHxxm02g2e9QYyBg
 y5bJxrdqYwJS/XEfQda6hjOnGtFq3OroULcLMTWy+PvU6VJzJxEeJQFMkSzwqIMDdloo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9wUJP0XuZAHVCju2vCQtbQJIE3DcNFW1LWD6svK3iD8=; b=X+s0qeIQ7dUDRMN6bV081X9weg
 RUO/FluBwNJo8adAUgSjsF488WtvnqHKO+PsOvdM/CVckjNck/JJ3Y5V+xY+XUQBxl+iPt3bJofwE
 6y0hogQnjAyzu4e43hkw6nh4Xi55he5CZXYBlEswf99eTWTur9MwkSWGLI+4hMRc0w3M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wprmH-0007wI-Ap for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 18:16:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22E32600C3;
 Fri, 31 Jul 2026 18:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6998C1F00AC4;
 Fri, 31 Jul 2026 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785521763;
 bh=9wUJP0XuZAHVCju2vCQtbQJIE3DcNFW1LWD6svK3iD8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=C8mqCAa3sOez8bYlcdk7Ex9hl1Zc3wGzNlS+gMfhYDFWo2GO6U1oOyWzlb2bPQY+x
 hqp45+zj52D2OrfKyI0wE6OnSs4tXIB0pDV9h5BA+FBwqNLLssYqEG2iralfKBbWze
 8TnH2nZgoDMCRUVPIIfWgQ5CX2TqVmWguLZl5ry0GMyg4/zCAi/p/yVuCqOjBPDh1S
 3CfPkRN86lNOdPWBsocKmexkv/xlcBg6n1fCMbp7GWE8C9TU8+qYac8CviSfGdpNx7
 2tBQ+HKflUJA/Bs03oR8x3vLAb4l3YfkvzAafZcN8aqTCzekcrr22Gj5IiA+WkyfGs
 NrtPDLo03P3hg==
Date: Fri, 31 Jul 2026 11:14:08 -0700
To: Baoquan He <baoquan.he@linux.dev>
Message-ID: <20260731181408.GA12803@sol>
References: <20260730184853.48347-1-ebiggers@kernel.org>
 <amy7Biucbf-et5O2@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <amy7Biucbf-et5O2@MiWiFi-R3L-srv>
X-Headers-End: 1wprmH-0007wI-Ap
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
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

On Fri, Jul 31, 2026 at 11:11:02PM +0800, Baoquan He wrote:
> On 07/30/26 at 11:48am, Eric Biggers wrote:
> > ext4 and f2fs don't prevent filesystem-level encrypted files from being
> > set up directly as swap files.  In this case, encryption is bypassed.
> > 
> > No one should be doing this, vs. the methods of encrypted swap that
> > actually do work (such as swapping to a dm-crypt device, or swapping to
> > a loopback device on top of a filesystem-level encrypted file).
> > 
> > Nevertheless, to prevent user error, make swapon() explicitly reject
> > this case.  Document this behavior in fscrypt.rst as well.
> > 
> > Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> > Fixes: f424f664f0e8 ("f2fs crypto: add encryption policy and password salt support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >  Documentation/filesystems/fscrypt.rst | 4 ++++
> >  mm/swapfile.c                         | 4 ++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> > index c0dd35f1af12..cba1989777da 100644
> > --- a/Documentation/filesystems/fscrypt.rst
> > +++ b/Documentation/filesystems/fscrypt.rst
> > @@ -1238,6 +1238,10 @@ astute users may notice some differences in behavior:
> >  
> >  - DAX (Direct Access) is not supported on encrypted files.
> >  
> > +- Encrypted files cannot be used directly as swap files.  To swap to
> > +  an encrypted file, set up a loopback device on top of it.
> > +  Alternatively, encrypted swap can use a dm-crypt device instead.
> > +
> >  - The maximum length of an encrypted symlink is 2 bytes shorter than
> >    the maximum length of an unencrypted symlink.  For example, on an
> >    EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 78b49b0658ad..e4991da81b5f 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3650,6 +3650,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
> >  		error = -EBUSY;
> >  		goto bad_swap_unlock_inode;
> >  	}
> > +	if (IS_ENCRYPTED(inode)) {
> > +		error = -EINVAL;
> > +		goto bad_swap_unlock_inode;
> > +	}
> 
> Sounds reasonable to me.
> 
> One minor suggestion: it might be helpful to emit a pr_warn_once()
> explaining *why* the swapon was rejected and pointing users to the
> dm-crypt / loopback alternatives, so the -EINVAL isn't opaque.
> Optional though -- the check itself is what matters.

How's this?

    pr_warn_once("Filesystem-level encrypted swapfile '%s' is unsupported. Create a loop device over it, or use dm-crypt\n", name->name);

> And this patch updates fscrypt.rst. Would it be good to also
> update the swapon(8) man page to document the new -EINVAL
> condition?
> 
> Other than these,
> 
> Reviewed-by: Baoquan He <baoquan.he@linux.dev>

swapon(8) is for the util-linux program, not the syscall, so it doesn't
document error codes specifically.  It does have a NOTES section that
incompletely documents filesystem-specific constraints on swap files.
It's missing most of the current constraints.  But sure, I'll send a
patch that adds a note to there about this one.  That will be a
util-linux patch.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
