Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE77DC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t34G/pPMWR2k/jQXtgD6b8pBtK8df5NmgZji4xPEC64=; b=dfm15BsB1DF/m68+SJ3Ijfmsgf
	ut2r5EGROGt+NV8WT2bn3a1Nx7vWtMZ13tnPJMYWCs/15ycHe8wlDxs7niJtjgzz2urnLCDACerLZ
	wi9OpbPHbwLW0Rzq0fTVTctsZnHNfJFpChhquG4yWySe4SjIhiyGG4aS67OCF6oISXnY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1R3W-0002nQ-IA;
	Tue, 01 Sep 2026 16:09:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1R3V-0002nK-KM
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9CE5RSBHk34ry3w4PuiZHGozADtZbhYGgw45lpA0o2o=; b=C4K242T7kLkd59M2G+O027DkDb
 eYaX/QHSQvirMV+IjWQgJFHFGB2knd38lJ7q1uBUB/2Rq3fp4AjPiaxZnC0oB2AkMbdTShKhsEf4w
 iKBsz5C1Q4qch1v9XzGBCYsKqrj7Rnhbh9DXqct0v+M5eu/LLtW4N1LCNIzmlC1ed3XI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9CE5RSBHk34ry3w4PuiZHGozADtZbhYGgw45lpA0o2o=; b=cvorHDoLcnTKg9dMUN4jStW4CM
 GisXTPhvVAR0nRut3/N76VKBxfXn3T5Aoukl1bhFlHDS4/EdgzGbX1pvCZo9A7WtToH4YQpdKyeuc
 8a8OPWBStRQ58Q3ksabV+PFovRFOevyNTeT6DPz6+xwVhaWqbqIbf9tIQZWnWjZTa66E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1R3U-0005J1-6L for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 16:09:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2340435A3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 16:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753F51F000E9;
 Tue,  1 Sep 2026 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788278982;
 bh=9CE5RSBHk34ry3w4PuiZHGozADtZbhYGgw45lpA0o2o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=m1Tz6oRtFZ0zUWOQmm82EJl+t4YdeTXhXnnxypQmE9R6Ru0zkt0Hso2BJowL+tSNT
 pZAW9+UGBe2OXzNpyJPIVyejvTQoRCwqFR6UOShqbLh1KEA4oVMMzAbC2vUqJxjjo5
 ahtQ3Z6ajxhqhsQwLedC1wGjJ4dPpKAtO1Zd1ViJ3ET0wv7lhKbv+izI0OIYMPH1KY
 MkZHbpY5MDwrOuE3Nm7Lb06drbVK5har0KcGJUVSFMWfYiUwY8NCm9/Leumz0OwmHm
 pPfbpBXXENrKeo36Y6e+YJt3nv7/odzaDiHakUXIgsu8ePE1TFyiGwJ4C20dyl10EC
 UPQuRVM6uVcEQ==
Date: Wed, 2 Sep 2026 00:09:35 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apb19-FLJv9dRFDS@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <878a21ea507cb955ed414072c82ab5e5493b8ae0.1784949155.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878a21ea507cb955ed414072c82ab5e5493b8ae0.1784949155.git.asj@kernel.org>
X-Headers-End: 1x1R3U-0005J1-6L
Subject: Re: [f2fs-dev] [PATCH v8 05/13] fstests: add
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: djwong@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jul 25, 2026 at 03:39:02PM +0800, Anand Jain wrote:
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
>  common/rc | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 21b516accdf7..f73251365a60 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6356,6 +6356,33 @@ _require_fanotify_ioerrors()
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

I would prefer to let the experts of each filesystem confirm whether their
fs guarantees a unique f_fsid. How about switching this logic to an *allowlist*
*(whitelist)* approach, where we _notrun by default and only allow filesystems
that explicitly guarantee unique f_fsid support?

  case "$FSTYP" in
  btrfs|xfs|f2fs)
        ;;
  *)
        _notrun "Target filesystem ($FSTYP) does not guarantee unique f_fsid on clones."
        ;;
  esac

Thanks,
Zorro

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
