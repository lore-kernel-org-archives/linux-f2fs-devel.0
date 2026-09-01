Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189EBC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ObJNLVwBSATCmBtcIrawAIbw0W/pE2knjjHF2SIP1U=; b=EI4RBWbFWrrBu4n9+XvpOiWAe9
	IJcq/iKDPojlbF025+wlBx4njqq7rhuF5jjaKNllRMaBgCPIeVg2X7EnZCETD0s/vNZKlwAJiZZ6W
	XVJQ7pK3GGwq7k+KJtX8vI8eUFj7nCit/LWES8nsua1OyWNx8T5cEaH56bS/wSNCKq8E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1VU1-0008JE-UD;
	Tue, 01 Sep 2026 20:53:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1VU0-0008J8-SU
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d+QoObKvn/jjIcgnDWLOeeDC/v3Jvf6TBEqFVZ09LX0=; b=cvDNUHQgnAalNaXqvnJWizvxLK
 Y34igw+lH29HzNjiq43HSorjUamDIWVdDNgfvDQpp0+QImw9S79mfzvXGJ2OAVEsXWUXfMOgLHgCi
 fmW36QMZts7A27O4O3faOMtqsUhYczbY5F4TFcUVsI2dJRN+N5VOHdiOPLGzkBAmn2F0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d+QoObKvn/jjIcgnDWLOeeDC/v3Jvf6TBEqFVZ09LX0=; b=gifzzpu+ztFUBWDSS3RSCpZIph
 I9G1K6nOIaGOKDgGDCYLsa+tZbAOsADSowidU3Nd1XvUf/3h5HcPHZrxg1UKmvKWFs18sbRDRVbmi
 38KX+jrmzoS2dgGEsiLuMxH/1YgyFSKir5ea6/YNLQ7xvtZcPoUDlb46aQqewFt/tge8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1VU1-0004dh-11 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:53:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6146C600D9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 20:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEE41F000E9;
 Tue,  1 Sep 2026 20:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788296003;
 bh=d+QoObKvn/jjIcgnDWLOeeDC/v3Jvf6TBEqFVZ09LX0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LUKDwbUi/br3OChyeR1SZJcm+9N0lq/0iaPuCV++ToeoebBS2gk1SZYTHU94UXAuo
 ua9bSe3rXCyTRY/Jd5QmMJlfWlKtpo56meYjYh2i+/gpWdGexubauiw2CXjAJucEQZ
 TzAYAj5YdP/iDSuxr3Mu4GeUF36pUcduUvXR8gChO5dMy8SN3p/M4FEG7m8olHV6rU
 HuiXdDPG1jp97uw+ra7/Fb/swfdlaKnb0iS77S+cv7ROIOofFnX5v3i3RZZhl9sUq6
 8diMDBY6/9GK76kX9pnmg4ad+ht42KGK8H2cVvQDt3tXQkwVnNRDA9oZzNDBq1iTvt
 t9i+byvFmso2Q==
Date: Wed, 2 Sep 2026 04:53:17 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apc6wRjPnQZNYfxV@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <8d69567fb5700c5a4075509bd7272d02ce9ba4f5.1784949155.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d69567fb5700c5a4075509bd7272d02ce9ba4f5.1784949155.git.asj@kernel.org>
X-Headers-End: 1x1VU1-0004dh-11
Subject: Re: [f2fs-dev] [PATCH v8 12/13] fstests: add _change_metadata_uuid
 helper
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

On Sat, Jul 25, 2026 at 03:39:09PM +0800, Anand Jain wrote:
> _change_metadata_uuid changes the UUID of the golden filesystem before it
> is cloned.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/rc | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index f73251365a60..45cf9360ba73 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1533,6 +1533,29 @@ _scratch_resvblks()
>  	esac
>  }
>  
> +# Change the metadata UUID of the given device to a newly generated one.
> +# Args:
> +#   $1: Block device path to modify.
> +_change_metadata_uuid()
> +{
> +	local temp_mnt=$TEST_DIR/${seq}_mnt
> +	local dev=$1
> +
> +	case $FSTYP in
> +	xfs)
> +		_require_command "$XFS_ADMIN_PROG" "xfs_admin"
> +		$XFS_ADMIN_PROG -U generate $dev >> $seqres.full
> +		;;
> +	btrfs)
> +		_require_command "$BTRFS_TUNE_PROG" "btrfstune"

How about split this function to _require_metadata_uuid_tool and
_chanage_metadata_uuid ?

> +		$BTRFS_TUNE_PROG -m $dev
> +		;;
> +	*)
> +		_notrun "Require filesystem with metadata_uuid feature"
> +		;;
> +	esac
> +}
> +
>  # Create a small loop image, run an optional tuning function ($2) on it,
>  # clone it, and attach both to loop devices, returned in ($1).
>  # Args:
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
