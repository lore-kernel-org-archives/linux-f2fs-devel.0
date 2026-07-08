Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86195C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gQnocsrFT4f7h7B5JbEP7567n1gm7prZ2GCF3JO5Y7A=; b=Yq0t/gcRG6nCnHn1zk2wL2HOPV
	JVz5TS1a82PU7xNn8cGBHdtzoXnCsqUq6sYrYN9t+snPPONLGehqVZH4AN/dB5oH/5TEusNvy640z
	RHFVT1sNxhwzMa4R40bOHZTs1qnJmMCrwVle/rWuuQd4omULMbNvRZVt+9C7ERhYDsqg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1whLO4-00040t-HD;
	Wed, 08 Jul 2026 06:04:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1whLO3-00040n-DX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 06:04:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=llkLKsOR9PknoEgDWcnrGWfV30HkU1bLr89lbeUvfJY=; b=ZIk6bzlz71wSd29tzWT/+4V5lv
 F6pQtsAgb194TetE74iN3MVSyV34VV/Q5DKRs9EBrbm2e0ew7Wds6TCdya5WhqmE6kGfV8ocDVGDm
 bI7+az+FmkpQuRw5U0w/2XKI5y2ruv5RpH0UA6hAKMS0NkW5WV3EAbuG2eaeY0rrt3kg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=llkLKsOR9PknoEgDWcnrGWfV30HkU1bLr89lbeUvfJY=; b=RXByeDU166ddXKvU0uyAGV9VKY
 XUg2NrLTWZMtYSHGOGv9XAc3069YEeflabHE1jPPkIcpnMcdKu4UOXQ114ckTCpUs92XxH6/J3Qlh
 lWxfaOfiKBIZ9uVHDU22svC8zUadn6+SDlOeXIqfAsAL23sSVVM+OXg5jIwF4+gttCnE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whLO3-0006aQ-MC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 06:04:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 501C642DBB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jul 2026 06:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09E51F000E9;
 Wed,  8 Jul 2026 06:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783490634;
 bh=llkLKsOR9PknoEgDWcnrGWfV30HkU1bLr89lbeUvfJY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gGcFJCVRcR5EzSNtHGS9CBvLKRUnkJbPoC7EsjgwU+EryVB4Ys3tKrTmPZOBKYzLW
 KB8oXfUqcH9nR8dDVvr4X6rLpOSOsC/+EJrQJFySWUEKKPQ227oIljD6P4Vt1vud+5
 GRbOfQJJYC6iqk44OghzPzM3j5pqxp41nP4WJEvE1Z9LH4UDUW+0/mqgOE8fOIbfEx
 zQfD3BOcMsCBo4IN2HVPqnAji5BgHUlDNHpu4TjL3ar4v6B6GuVM20GYFpaKmd2u7Q
 drgA4dMDW2f4klH6t0r51RtXNJH/P14G7QzMJbwhrYdt5Xddlgkg7s6cKWOJvajaPQ
 /ofD0r8G1ReRw==
Message-ID: <e19e5b1b-ba0a-463b-8bde-c9f31f4e961b@kernel.org>
Date: Wed, 8 Jul 2026 14:03:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
Content-Language: en-US
In-Reply-To: <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
X-Headers-End: 1whLO3-0006aQ-MC
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Cc: jaegeuk@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



> How about this?
> 
> f2fs)
>     local feat_file="/sys/fs/f2fs/features/fserror"
>     if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
>         return 0
>     fi
>     ;;


This is a check we will use often.
Why not add a helper like the untested code below [1]?
Furthermore, I can clean up _require_btrfs_fs_feature()
to use [1] as well.


[1]
common/rc:

_require_fs_feature_attr()
{
	local feat="$1"
	local attr="$2"

	modprobe $FSTYP > /dev/null 2>&1

	[ -e /sys/fs/$FSTYP/features/$feat ] || \
		_notrun "Feature $feat not supported on $FSTYP"

	if [ -n "$attr" ]; then
		if ! grep -qw "$attr" /sys/fs/$FSTYP/features/$feat; then
			_notrun "Feature $feat attribute $attr missing"
		fi
	fi
}



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
