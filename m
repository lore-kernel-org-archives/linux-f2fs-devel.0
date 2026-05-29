Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6BDCD6E45
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2026 04:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hZVvPRUuCWyWpQuwX21jcEHGTTJTES7SyWtkA8dRnzY=; b=Gd1PXpf2to3pUEowXiz9OhodWH
	VqBbhout8KYLE2Tu1OLibn6/pD0I30voLKJIvqqwvS3TvxVBJMJT5SA/tIh+xMKcC/lVtlLgx2TLh
	zLver9C4R7X1/fxi41fzIzM3Cv5tPaG07LSo9dwvhTsMSEHN4QavC9OoZnxNyXJpk4Po=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSosI-00084o-7J;
	Fri, 29 May 2026 04:31:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wSosG-00084h-8O
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 May 2026 04:31:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y9i3D99952aoMze26KNO+B5RKcPVXLOJ/Le5dJq03VQ=; b=QcwY86o99tecxQW2xsFoHrDnkA
 jiRwrOf3D5s7lvHTtWh18xq8wzhl3lzZ0bXyX8loo+qVMxafPIBvb9AFP+ieMcn5ahYm40zXJzohW
 OG8J+VBBaq++KyRpRHRkivSdRqnF3ln4WA4z+W1rGOGoqyejFwWk8qNVyH/d/PshkkFY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y9i3D99952aoMze26KNO+B5RKcPVXLOJ/Le5dJq03VQ=; b=L4M1dgDlQ/IegGlqVykCfFqiDF
 CvexkAnNa+9CZ/rwVGzbCAQk26bvRClML9pdEWM4CmF7n20vPYTVcREzq8iNIgcYHWHcrCtPwxp0O
 XkDvx8M5RKb3bnBqPewxi31zmzx5srPRNoXevnneERU+Y1EQAE/YEO7IADQDNPeOSzGU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSosE-00087v-TQ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 May 2026 04:31:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id BA9D360213;
 Fri, 29 May 2026 04:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 616A81F00893;
 Fri, 29 May 2026 04:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780029056;
 bh=Y9i3D99952aoMze26KNO+B5RKcPVXLOJ/Le5dJq03VQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HUZJMAQ4JW93nEK7Ak/B7yekzr0L9gilaId6xBXrCVUiqg92v5fqrUBFr8h0m5Oog
 iA+F1hNKwTjPIft3PnmQJLznIaw3uwRhlW/yO7iC6nc8mrwKxZ11Spi1tT+/ltMTpz
 7IQPG4fRwkqsLrp7gsjSrEflI1XB+p7SzvOC1/uWggWjXTk/JblEv4qBAS+YJQcAmv
 1m5mUzzgTHR4ortXnd/whkXqrlJYQ7+pU1pNwuXhBj+kA2rpGXRvx+mxNzirF6cAF+
 mbVFiwiesQ8295To0Sx1dqDr+Q3kddrBX2CkGYiqz8GDTn65esC1eMNj51RB/Q+2I1
 Iler0emvl6uXw==
Date: Thu, 28 May 2026 21:30:56 -0700
To: Anand Jain <asj@kernel.org>
Message-ID: <20260529043056.GE6070@frogsfrogsfrogs>
References: <cover.1779939330.git.asj@kernel.org>
 <983ed0f63318c930379ee74220f23aa558c16d51.1779939330.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <983ed0f63318c930379ee74220f23aa558c16d51.1779939330.git.asj@kernel.org>
X-Headers-End: 1wSosE-00087v-TQ
Subject: Re: [f2fs-dev] [PATCH v6 04/11] fstests: add
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

On Thu, May 28, 2026 at 12:05:35PM +0800, Anand Jain wrote:
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
> index 937f478963b4..5446552aed92 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6314,6 +6314,27 @@ _require_fanotify_ioerrors()
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

"device mappings", as in /dev/disk/by-id/$UUID ?

> +# of the userspace utility or use-case to enforce uniqueness when a clone
> +# diverges. For details, see mailing list thread discussions titled:
> +#      "ext4: derive f_fsid from block device to avoid collisions".

How about providing a direct lore link?

--D

> +_require_unique_f_fsid()
> +{
> +	# Skip the test if the filesystem does not enforce unique f_fsids
> +	# natively. Checking this dynamically requires recreating a clone
> +	# layout, so we use a static lookup based on FSTYP.
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
