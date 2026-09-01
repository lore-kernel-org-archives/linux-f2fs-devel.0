Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF6C624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhatjIWq/O+AlpOol4/Nn1eijdiUwPEGsoLUpBqOTOM=; b=I4/jLqkEZix8t6n9kartRSZ/5X
	hmgnyRdOP1Emr24w27mY7oHyOdwiz1pkntlEo2MCM/4IaIsjSEZeep3W1FybYkvjC/Armzdwi/OlY
	oy3+JA1IhU/Pm+hYhjSEkYf/yQOrmbwu+EdTvJC7Q7c6qn/Dlk1oI7M1WBFoDcZnDwCU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1QYd-0002CL-Os;
	Tue, 01 Sep 2026 15:37:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1QYd-0002CF-66
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:37:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qT7SEMz9YTRln0d8ZNOiT6CHsxhi25iHDyM6hQuAnHw=; b=izZ2ns00L2LFhSzRcHg7uYXh8l
 2Q6+waHd8DhtSrJoyv8FbG1C5zmjM+g6boAlMwhc9uabrHHg27qqCEO18mHugAPFPqUxXt8b5qbeO
 TqtRa8yMAVXHrDhnLGK3HmaM4GaulgA2Mdnb+dutLTi94Ueqi2F0PJN4zv8lKV9RrAe0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qT7SEMz9YTRln0d8ZNOiT6CHsxhi25iHDyM6hQuAnHw=; b=lLAVP8kH5a9BD2TbCZ9Oi2F4Yt
 oRjjYtgRuW9+WFPkcyn/TxznHVjy/ruk70sdBaOjm2HwnryN9GsvInD1Rx/hpopRpLdbA3+rKKGyI
 ZkWW1uyOOGNkRpWvFFWcjwTSApD/j3VP8uorazNYaVf/iauS2hkcQ8w9ANNLl2JpiXYg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1QYb-0005ZV-N7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:37:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 57A3E418DB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 15:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99AD1F000E9;
 Tue,  1 Sep 2026 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788277068;
 bh=qT7SEMz9YTRln0d8ZNOiT6CHsxhi25iHDyM6hQuAnHw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FJiENG9rguyxm3V674ma1GAUWeJvo3VIay2BQiN6O1f42U9SIJ8NFECqhhwg93bho
 kIAcTi8xhbCkxkYRWe7yuJX+fb2oWxqqpFFVy8v6vadNaN9Mr8deukVkfX7tnQSTCM
 /ztzbbdh6i94ZdL2VHmdYjT+zJ2im3tfucFOyWL+pnkaeWOicYhvZ5KQS4xcuqYMwI
 5mNKWOrGH44uAOfrBFTxU1OPtZTPIfJHdyrDp3wPBLs/QbQ06bUBhiV6KpgzKvKeTN
 WW1ml43rSn7IRu9QgHlrQ90hpo1WsF8IU06JvRDkRt8VU1c6v24Lc+JjdUkR5tTXKR
 15a/p+pczfpqg==
Date: Tue, 1 Sep 2026 23:37:40 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apbxF-WvNF4j7Ph4@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <09003af49b95d3b7fdf24b0d76e3ef389b44c3e1.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09003af49b95d3b7fdf24b0d76e3ef389b44c3e1.1784949154.git.asj@kernel.org>
X-Headers-End: 1x1QYb-0005ZV-N7
Subject: Re: [f2fs-dev] [PATCH v8 03/13] fstests: add FSNOTIFYWAIT_PROG
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

On Sat, Jul 25, 2026 at 03:39:00PM +0800, Anand Jain wrote:
> Define `FSNOTIFYWAIT_PROG` for an upcoming test case that uses `fsnotifywait`.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/config b/common/config
> index d5299d5b926f..5661fa0ec310 100644
> --- a/common/config
> +++ b/common/config
> @@ -242,6 +242,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>  export PARTED_PROG="$(type -P parted)"
>  export XFS_PROPERTY_PROG="$(type -P xfs_property)"
>  export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
> +export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"

OK, new *notifywait command.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  
>  # udev wait functions.
>  #
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
