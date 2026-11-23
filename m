Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF428606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Dbnjv87P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YLCPrHy5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AdrsQ2j1;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDD4CU9t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PCAULCLFRx8t2IFwIfAZ/tykhcfmJFv/++byTVUbkPw=; b=Dbnjv87PaJhHQmoABLbKehF6pS
	JN8vNsCAR7GFhKfwvTHW58C0b59hrkF8cBVbimF0mrZRVn6d1KcTztl2DvEk+PjHNzISTuWPLsAYT
	1hPMXW21nXewg7V/NA/IL9gw/6J8fSl3aNgQ//zuPoWHRC1RgjC3rgvLI75G1vd69wSM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVYnu-000000005JJ-1vfY;
	Mon, 23 Nov 2026 18:30:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zlang@kernel.org>) id 1xVYnJ-000000005Hu-2smd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:29:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9FVwijSS/u13QVeqTyKKb8D3NxGid/P0YoVWsdCD+gc=; b=YLCPrHy5tL36Sfea8Uh9H8VvpZ
 cV3juV3KMavG0BanvmT1cdsGK5v1QwQLY5Mf+K4/Ox0zLSXQchiHlbjNSfNwtENlhn43Tp26cMZbd
 yq20v4AE+fe1GCiB4agP+HSdQW0nR2V3GhXI1Fo37J+hP//Gj2YAGoPCn2mceKJPSTQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9FVwijSS/u13QVeqTyKKb8D3NxGid/P0YoVWsdCD+gc=; b=AdrsQ2j1LM1TAVJZ/HtdK3+a6D
 56uUQOrrSJ+EnCDd8gNVgU6fIKienLprsKIkse42qhNBtmv0PM08YYFN2Xq6vfVZ2bcI1NEKnmgQt
 sAvelTCIUkyNp0qqkfn29mNFOykRD9fVhXkP2DL+ZErIDDgy309IzDh5fSi7IuzDDIqc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVYnH-000000003Rm-0LWj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:29:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A45E240117
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 18:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055991F000D4;
 Mon, 23 Nov 2026 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795458569;
 bh=9FVwijSS/u13QVeqTyKKb8D3NxGid/P0YoVWsdCD+gc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NDD4CU9tZCHQTX1HQBApcgQ+eam+hqAHxUI9qI/9mGXglS7mQT1hKWvGrgug09ScD
 6KL3xrvKyyoGdTDVm0TKXPRaqDvVSTAuLii8Xnb50ADdtPYwSLomTKW5O4R7MopqL0
 hmoTytl71lpc6l4gpm6Udlh0Tv9JFWAjkk48xUmadw7zpqzTtcVD3l8jcVVjK6ITTo
 CzytHyWLoy7SOqes2pqIXH9Ez/2RWKJv6WBKZ7W4zcQwcA7V4i+nOYlWaJOOPAmQmw
 QD5Hw+VQlqxQGa4ZCt4fKCmqu2r2/Hmep3LNmY/DpjJXTcHWED+vFqzaIiV25VoP8f
 i/GQv0ik7KxAw==
Date: Tue, 24 Nov 2026 02:29:20 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <awSDxwVociDn6649@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1791272793.git.asj@kernel.org>
 <523304ad35666548443b910955ae7d3a1669ae5a.1791272793.git.asj@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <523304ad35666548443b910955ae7d3a1669ae5a.1791272793.git.asj@kernel.org>
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVYnH-000000003Rm-0LWj
Subject: Re: [f2fs-dev] [PATCH 06/21] fstests: add _require_unique_f_fsid()
 helper
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 06, 2026 at 04:55:32PM +0800, Anand Jain wrote:
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

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/rc | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 0fcc1a614ad1..37b32b498c80 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6417,6 +6417,33 @@ _require_fanotify_ioerrors()
>  	_notrun "$FSTYP does not support fanotify ioerrors"
>  }
>  
> +# Skip the test if the filesystem does not enforce unique f_fsids
> +# natively. Checking this dynamically requires recreating a clone
> +# layout, so we use a static lookup based on FSTYP.
> +#
> +# Across all filesystems, a UUID collision causes libblkid tools to return
> +# non-deterministic device mappings. It is ultimately the responsibility
> +# of the userspace utility or use-case to enforce uniqueness when a clone
> +# diverges. For details, see mailing list thread discussions:
> +#   Link: https://lore.kernel.org/linux-ext4/20260409131238.GC18443@macsyma-wired.lan/
> +_require_unique_f_fsid()
> +{
> +	case "$FSTYP" in
> +	ext*)
> +		# Ext4 derives f_fsid from the superblock UUID, meaning
> +		# clones share the same f_fsid until their UUIDs
> +		# diverge.
> +		_notrun "Target filesystem ($FSTYP) does not guarantee unique f_fsid on clones."
> +		;;
> +	*)
> +		# Conversely, XFS, Btrfs, and F2FS ensure f_fsid remains
> +		# unique per filesystem instance (often by deriving it
> +		# from the UUID and underlying block device.)
> +		;;
> +	esac
> +}
> +
> +
>  # Computes a percentage of the available space in a filesystem and
>  # returns that quantity in MB. The percentage must not contain a percent
>  # sign ("%").
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
