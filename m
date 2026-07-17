Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897C4C44507
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2h6Ipys6TJJwCxvP/swqXbIVGbHBxhIr6dn1ve6YNl8=; b=eMb4CVdCPc/r1RQc0Zk/ZVZ4bX
	E2AE7EywuIbpgveqbrkP0moccFoTTjdQgw57H6ja1SOa6ZqSzrjn4kXw4fy3ERsNGwPKgL9gMReKu
	dsJtvjklwbquiVHdmrsi6P9DWJ4h3Gq3caoUl6862FOgnSKjOzhft7HSjB0TNDQ7VkBI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wkg6a-00017g-Uu;
	Fri, 17 Jul 2026 10:47:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1wkg6Z-00017Y-WD
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 10:47:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eGkSRp4teI72/jI7XMKfV3fBWLaaZ8qcn87O2VoAlz0=; b=batdPLKvsidxuUU4tx7URrWUlb
 umRZi/ETA0FUBzYHHj+CtlsIBu9qj4CHs1WAAEfwbXgkgf7Sc/q5po3CcgJSe4pP553YL0BtIMfX0
 30guVR8ObUse+nsuR+3hoDEWwEYSaqiWEsPh5gAjAdPp3O/dYDGa9qtW5I/IpAjRJh2Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eGkSRp4teI72/jI7XMKfV3fBWLaaZ8qcn87O2VoAlz0=; b=k7OhekQc6hocESHKKiPIVR3fsr
 FaYRJvvecp6onu09vkjtqCrJOrAv9RY1jfs/kcn6FzTS1B1LKwvUFyeiWCJbko4T8JLRlGiuxPIxY
 muv/p+eTLwUu7Dg3m6JKkjfO3XGWaw4jvBrMXs7YdmDQeLmCOnCNLSOjnAh+bciHGQwM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkg6a-0003mk-4n for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 10:47:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 96D24403CF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 10:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C3F1F000E9;
 Fri, 17 Jul 2026 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784285258;
 bh=eGkSRp4teI72/jI7XMKfV3fBWLaaZ8qcn87O2VoAlz0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bgsT2q8B7l8GSJIcINJTO6jRK3jIi+NiWEpy+hp2BX9RD/9UjbzBQ4RurxHf31sBq
 gCkwXYyrLIbeZGkSPXI2iKnya1r1cp9vFlzGL9JZ4CgZCjzWgG4HIF4qsx5gpdhHWR
 xWrMr9DUedhNhRcymJ1HQW3kVFvubPi1LFC16NIAgRo0MvBn5S7aIgOhRNaXttxCH1
 nXgp7ty0I85LQFMPrh4fVrC9IOw0eeSC0r0gKATZFhKnwlPnL1kgNIJDkfaGvE/xKj
 Pkda7tpl/To2Hbd/IaDQif5ScMyQqBS/qRBwONV3Gsv/1qgH2hZ8yWt1m0Lmej1jEh
 +oSuTo9O9DU+A==
Date: Fri, 17 Jul 2026 18:47:30 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <aloCfjjqesxpzL9z@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, 
 Anand Suveer Jain <asj@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, "Darrick J. Wong" <djwong@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
X-Headers-End: 1wkg6a-0003mk-4n
Subject: Re: [f2fs-dev] [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 Anand Suveer Jain <asj@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 08, 2026 at 11:25:37AM +0800, Chao Yu wrote:
> On 7/7/26 18:13, Anand Suveer Jain wrote:
> > On 6/7/26 14:43, Chao Yu wrote:
> >> f2fs has supported to report fserror, this patch adds support for f2fs
> >> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
> >>
> >> Cc: Darrick J. Wong <djwong@kernel.org>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>  common/rc | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/common/rc b/common/rc
> >> index 494725547..f51ad59f3 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
> >>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
> >>  		test -n "$x" && return 0
> >>  		;;
> > 
> > 
> >> +	f2fs)
> >> +		x="$(cat /sys/fs/f2fs/features/fserror)"
> >> +		test -n "$x" && return 0
> > 
> > Don't we need to check if /sys/fs/f2fs/features/fserror
> > is present in the running kernel (there are helpers)
> 
> Hi Anand,
> 
> You mean _has_fs_sysfs_attr()? however, it forces to check first parameter $dev
> w/ block device type:
> 
> 	if [ ! -b "$dev" -o -z "$attr" ];then
> 		_fail "Usage: _has_fs_sysfs_attr <mounted_device> <attr>"
> 	fi

Hi Chao and Anand,

The *_fs_sysfs related helpers were brought in by me in:
  commit 2a7b77abcd1dde735186b363da24540706c43b73
  Author: Zorro Lang <zlang@redhat.com>
  Date:   Tue Jul 5 17:30:24 2016 +0800

    xfs: configurable behavior on errors at unmount time

At that time, I didn't think about the "features/" directory.

Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
family of functions shouldn't be restricted to the $dev directory,
we should remove this restriction.

Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
helpers which call *_fs_sysfs(). Also change the test cases who call these
functions.

Finally, we can introduce the *_fs_sysfs_features functions (or simply use
*_fs_sysfs directly).

Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
them is somewhat confusing and easy to mix up.

I need to write a series of patches to clean up these logic. For this current
patch, we can start with a small-scale change first. What do you think?

Thanks,
Zorro

>
> 
> > before reading it?
> 
> How about this?
> 
> f2fs)
>     local feat_file="/sys/fs/f2fs/features/fserror"
>     if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
>         return 0
>     fi
>     ;;
> 
> > 
> > 
> > 
> >>  	esac
> >>  
> >>  	_notrun "$FSTYP does not support fanotify ioerrors"
> > 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
