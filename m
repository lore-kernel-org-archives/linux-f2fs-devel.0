Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90377C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ttm0nDS+lxJHiCP1geG+I4ftanmPivJq1EWHjfoAzls=; b=JTGInRaIfMQuUCQ6JkX2ZottRy
	kv21jjwavnV9EC+9kLCZRHiJJ86KsCf2F40QXszQZNGGsWRn9zEvKbBA5JMxsCjyzYXn8rSH75gaj
	3NloGGBCPGrpR5oIRdmOFLk2VT5kaHk6u/xXnEv68ykJ51s91fIpxtmeQD3aIGbk/dPU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wobd8-0008Hy-3K;
	Tue, 28 Jul 2026 06:49:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1wobd6-0008Hr-SK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 06:49:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tlfKZiyYkrkM7p7iQu/UMLwgod3tcR5QMt0gjlecmY0=; b=fYEyqAITfQYUW55V0Ve5y+pP/+
 JIfkr7qYd/qI8FkBPteojkF40wr5DZpCO1R1NQwtQ4nqibm1IAUVGkT6T1e23nzPfX8X4X3qaXWEt
 NjERjk4KSed8wTLCNvALtSTk27xzF/uSV8kBwbtID4uswBf+gj3a/ir2T/gj/0MIUyjw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tlfKZiyYkrkM7p7iQu/UMLwgod3tcR5QMt0gjlecmY0=; b=R+3hlomkDXvuqwJqxwnMB+fCmh
 ZkUIXVRVPMA1W80d97LqSVB/Bo+WTgdaqRn1apPgbwzB923hAQ7+v+FxTt456KagFKNgUJ99hbBPb
 TKqmvyZcOaX4Aw31vO9zhbu2d2b6Q2BWi0vwMuYxOgClt5YceiU4E/BhNJXmWlD2znEc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wobd6-0000zo-3h for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 06:49:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B602416CE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 06:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB4B1F000E9;
 Tue, 28 Jul 2026 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785221366;
 bh=tlfKZiyYkrkM7p7iQu/UMLwgod3tcR5QMt0gjlecmY0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ThvyjwIpwAtUlNyN9OwobltIqW9264KDgSHPy844jH4j1oENNIeMmkw8dJPWDRmIm
 vMFE57babQhn1eic5iupYG8t3Ox8owxx5JeRqFudQbUZ9qNZu1DxHcPsmXPAj4TfWL
 72pt9YeqFH//NEmsAibg8rQoURl6RzSVkbASBIIh5Hfo+f676w/qDdLpqd1C5i5xva
 /OVr6SzxotvJ8qQVAkyRBJ2Mo5Vn/lAKdEmXbMIUMLWafEXDdmV+I1W1RcHs9Z0qlE
 0J3aN+v4K3tKJN5UhKAPBV4Ilb4Z9idNKvEzxIPDi393vmBYfHLDiUZ0IuOGqJWMf0
 NXNLWxzoCwcTQ==
Date: Tue, 28 Jul 2026 14:49:19 +0800
To: Chao Yu <chao@kernel.org>
Message-ID: <amhKovVDjwawoWdQ@zlang-mailbox>
Mail-Followup-To: Chao Yu <chao@kernel.org>, 
 Anand Suveer Jain <asj@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, "Darrick J. Wong" <djwong@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
 <aloCfjjqesxpzL9z@zlang-mailbox>
 <a081f7cf-bd47-459d-baee-de772d816af4@kernel.org>
 <ameajJf8iiAQYWA3@zlang-mailbox>
 <99220f8b-05d4-427f-998d-7f15a84c8805@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99220f8b-05d4-427f-998d-7f15a84c8805@kernel.org>
X-Headers-End: 1wobd6-0000zo-3h
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

On Tue, Jul 28, 2026 at 10:24:10AM +0800, Chao Yu wrote:
> On 7/28/26 01:57, Zorro Lang wrote:
> > On Thu, Jul 23, 2026 at 05:09:12PM +0800, Chao Yu wrote:
> > > On 7/17/26 18:47, Zorro Lang wrote:
> > > > On Wed, Jul 08, 2026 at 11:25:37AM +0800, Chao Yu wrote:
> > > > > On 7/7/26 18:13, Anand Suveer Jain wrote:
> > > > > > On 6/7/26 14:43, Chao Yu wrote:
> > > > > > > f2fs has supported to report fserror, this patch adds support for f2fs
> > > > > > > in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
> > > > > > > 
> > > > > > > Cc: Darrick J. Wong <djwong@kernel.org>
> > > > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > > > ---
> > > > > > >   common/rc | 3 +++
> > > > > > >   1 file changed, 3 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/common/rc b/common/rc
> > > > > > > index 494725547..f51ad59f3 100644
> > > > > > > --- a/common/rc
> > > > > > > +++ b/common/rc
> > > > > > > @@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
> > > > > > >   		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
> > > > > > >   		test -n "$x" && return 0
> > > > > > >   		;;
> > > > > > 
> > > > > > 
> > > > > > > +	f2fs)
> > > > > > > +		x="$(cat /sys/fs/f2fs/features/fserror)"
> > > > > > > +		test -n "$x" && return 0
> > > > > > 
> > > > > > Don't we need to check if /sys/fs/f2fs/features/fserror
> > > > > > is present in the running kernel (there are helpers)
> > > > > 
> > > > > Hi Anand,
> > > > > 
> > > > > You mean _has_fs_sysfs_attr()? however, it forces to check first parameter $dev
> > > > > w/ block device type:
> > > > > 
> > > > > 	if [ ! -b "$dev" -o -z "$attr" ];then
> > > > > 		_fail "Usage: _has_fs_sysfs_attr <mounted_device> <attr>"
> > > > > 	fi
> > > > 
> > > > Hi Chao and Anand,
> > > > 
> > > > The *_fs_sysfs related helpers were brought in by me in:
> > > >    commit 2a7b77abcd1dde735186b363da24540706c43b73
> > > >    Author: Zorro Lang <zlang@redhat.com>
> > > >    Date:   Tue Jul 5 17:30:24 2016 +0800
> > > > 
> > > >      xfs: configurable behavior on errors at unmount time
> > > > 
> > > > At that time, I didn't think about the "features/" directory.
> > > > 
> > > > Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
> > > > family of functions shouldn't be restricted to the $dev directory,
> > > > we should remove this restriction.
> > > > 
> > > > Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
> > > > helpers which call *_fs_sysfs(). Also change the test cases who call these
> > > > functions.
> > > > 
> > > > Finally, we can introduce the *_fs_sysfs_features functions (or simply use
> > > > *_fs_sysfs directly).
> > > > 
> > > > Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
> > > > them is somewhat confusing and easy to mix up.
> > > 
> > > Zorro,
> > > 
> > > It makes sense, and good news to their user. Thanks for the proposal.
> > > 
> > > > 
> > > > I need to write a series of patches to clean up these logic. For this current
> > > > patch, we can start with a small-scale change first. What do you think?
> > > 
> > > So I will use this first:
> > > 
> > > f2fs)
> > >      local feat_file="/sys/fs/f2fs/features/fserror"
> > >      if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
> > >          return 0
> > >      fi
> > >      ;;
> > > 
> > > And then waiting for your cleanup? or if you want to clean up this, please do it
> > > directly while merging.
> > 
> > If f2fs wants to test this feature right away, I can merge your patch now and
> > clean it up later. If it's not urgent, I'll take care of it all together.
> 
> Zorro,
> 
> Could you please help to merge it first? so that we can test 791 w/ last
> upstream code, and also in case we missed to track its status to lose it. :P

Sure, I'm good to have this first. Could you send a new patch version, if you'd
like to change it?

Thanks,
Zorro

> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > > 
> > > > > 
> > > > > > before reading it?
> > > > > 
> > > > > How about this?
> > > > > 
> > > > > f2fs)
> > > > >      local feat_file="/sys/fs/f2fs/features/fserror"
> > > > >      if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
> > > > >          return 0
> > > > >      fi
> > > > >      ;;
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > >   	esac
> > > > > > >   	_notrun "$FSTYP does not support fanotify ioerrors"
> > > > > > 
> > > > > 
> > > 
> > > 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
