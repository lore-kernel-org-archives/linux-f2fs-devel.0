Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CB9C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LxxqA9ipXCjAXNhJpAJh51VpMXEO6/PeieeCbGs1ePU=; b=HNPh9U7cJnU6CAA+t2XUB/xM3M
	VCjFJj3RlXHlufcY38npIV+4IcTKBVUtqPdO4TDkuON5gqOu/RKq51C3pKyCcM5Pg3ydgAWzfhP/f
	i4JQ2auMdtoZ9smGmaBcvvkVnhyvRW2Mza9vhRq6VuLlbu/6qoNGxsYVrpOAiwQHrJ1c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weyTK-0001pV-EN;
	Wed, 01 Jul 2026 17:11:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1weyTJ-0001pK-AH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 17:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dObZorwKY5QXIIvyRJ67mb+sIhgTQQ1nuYKhEabm1IY=; b=RGKMx8mD8IMutUnTlNujnjeDY3
 d2dd0GlHaR13aLFTpvY0mpJmQIj0jIEdZQyi7B3R2LNO2YfaILagPl/Hp9jcp2ENjGADkLcJ60LPI
 868kQ0GuqkyonS5J21RMphhWbMnDYlaAAQAYoXuNCV9pIEqYQST3WO8RE9MJV4M2Jdtw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dObZorwKY5QXIIvyRJ67mb+sIhgTQQ1nuYKhEabm1IY=; b=PxTq79NJjJCh6vVJddylqLc6Kd
 eyB4b8xhk9etkh6lNAgzKA33e/3U4F4em95C9s2FQQvJbaNPtgzotJVJcUPsSqPUPz+h/AdlbOSlw
 xMdn1PLL4qXJsno0eN9k2ZZsj8/5YIjYle5005aHGrAsmmtwP64hAtHtUS2dGcvtO9jI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weyTF-0008PK-7Y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 17:11:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id 1A2E06001D;
 Wed,  1 Jul 2026 17:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B74961F000E9;
 Wed,  1 Jul 2026 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782925882;
 bh=dObZorwKY5QXIIvyRJ67mb+sIhgTQQ1nuYKhEabm1IY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eLk6T1xPagtKVZRSbzBIhjdmyruf+ywZiv6+Yi0GhAt7ebSQGszb9JqdwVTH/x8Nv
 2j8FBo0nP5yyUyi1I1u28my64HyjSHN525nNfzApYyqlc8maaoW4uHeHFFTyytNBwu
 44Hj0G2JyYgB4eIa6Sv9Pv7MrKtHPEcbMf/qwFBqO9jcyHOW283g4mXGEWt3V+Yoxp
 4i23BJwSCN496LxCRwNVRF6OYQIMzPOFGkzwQWPdiKUsHnq/6Qi7yDRdSEkZipQK2r
 lgtEGrdCI4pk9+5jGO2MBDcP22/wLrga0xlLthUnrM6bpY4jm4Wqu1nofhnJurMEni
 lGX+ASfXeQNvQ==
Date: Wed, 1 Jul 2026 10:11:22 -0700
To: Anand Jain <asj@kernel.org>
Message-ID: <20260701171122.GF6517@frogsfrogsfrogs>
References: <cover.1781694879.git.asj@kernel.org>
 <f556db45f1ffc93508a69ce9f9e567b74384210f.1781694879.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f556db45f1ffc93508a69ce9f9e567b74384210f.1781694879.git.asj@kernel.org>
X-Headers-End: 1weyTF-0008PK-7Y
Subject: Re: [f2fs-dev] [PATCH v7 04/11] fstests: add
 _require_unique_f_fsid() helper
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

On Wed, Jun 17, 2026 at 07:20:31PM +0800, Anand Jain wrote:
> Add a helper to check if the target filesystem supports unique f_fsid
> tracking across cloned or snapshot instances.
> 
> Certain filesystems like XFS, Btrfs, and F2FS ensure unique f_fsid
> identifiers per filesystem instance. However, Ext4 derives its f_fsid
> directly from its superblock UUID, which leads to identical f_fsid
> values on cloned images until the UUID is manually modified by userspace.
> 
> Introduce _require_unique_f_fsid() to allow test cases requiring strict
> f_fsid uniqueness to skip gracefully on unsupported filesystems.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/rc | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 968ba33686f3..d95eec94f7b7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6310,6 +6310,27 @@ _require_fanotify_ioerrors()
>  	_notrun "$FSTYP does not support fanotify ioerrors"
>  }
>  
> +# Ext4 derives f_fsid from the superblock UUID, meaning clones share the
> +# same f_fsid until their UUIDs diverge. Conversely, XFS, Btrfs,
> +# and F2FS ensure f_fsid remains unique per filesystem instance (often by
> +# deriving it from the UUID and underlying block device.)
> +#
> +# Across all filesystems, a UUID collision causes libblkid tools to return
> +# non-deterministic device mappings. It is ultimately the responsibility
> +# of the userspace utility or use-case to enforce uniqueness when a clone
> +# diverges. For details, see mailing list thread discussions:
> +#   Link: https://lore.kernel.org/linux-ext4/20260409131238.GC18443@macsyma-wired.lan/
> +_require_unique_f_fsid()
> +{
> +	# Skip the test if the filesystem does not enforce unique f_fsids
> +	# natively. Checking this dynamically requires recreating a clone
> +	# layout, so we use a static lookup based on FSTYP.

I would switch these two comments.  The second comment above describes
what this predicate function actually determines, whereas the first
comment above the function justifies the internal behavior of the
function.

# Skip the test if the filesystem does not enforce unique f_fsids
# natively. Checking this dynamically requires recreating a clone
# layout, so we use a static lookup based on FSTYP.
#
# Across all filesystems, a UUID collision causes libblkid tools to return
# non-deterministic device mappings. It is ultimately the responsibility
# of the userspace utility or use-case to enforce uniqueness when a clone
# diverges. For details, see mailing list thread discussions:
#   Link: https://lore.kernel.org/linux-ext4/20260409131238.GC18443@macsyma-wired.lan/
_require_unique_fsid(
{
	case "$FSTYP" in
	ext*)
		# Ext4 derives f_fsid from the superblock UUID, meaning
		# clones share the same f_fsid until their UUIDs
		# diverge.
		_notrun "Target filesystem ($FSTYP) does not guarantee unique f_fsid on clones."
		;;
	*)
		# Conversely, XFS, Btrfs, and F2FS ensure f_fsid remains
		# unique per filesystem instance (often by deriving it
		# from the UUID and underlying block device.)
		;;
	fi
}

--D

> +	if [ "$FSTYP" == "ext4" ]; then
> +		_notrun "Target filesystem ($FSTYP) does not guarantee unique f_fsid on clones."
> +	fi
> +}
> +
> +
>  # Computes a percentage of the available space in a filesystem and
>  # returns that quantity in MB. The percentage must not contain a percent
>  # sign ("%").
> -- 
> 2.43.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
