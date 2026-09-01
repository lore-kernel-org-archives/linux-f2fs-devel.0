Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEBDC624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVaVJuE6yR2ZtWcuxXy2jL82/HbJ5HSOB4ghfdixuCM=; b=QwZGyVewn9OSH+lO3sMBByAfCl
	Eaa+ipjf68wkWuZSpDS9Q/mDNCh88OLkzDiTOaBuDs9/tpFaolKNOWlppw0oTa/sH8GwqFL4hCCtK
	zsnodoJN55iwmKU4J8K1c5JPvbsd7cX8M5a84V/rJQ5iq819WoJsENcsVRTsV4J645TA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1Qdc-0003Zj-70;
	Tue, 01 Sep 2026 15:43:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1Qda-0003ZQ-6r
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kwmt/CmpLnrqG0C6TaQUHP9mSrd7dijmNhSSbrv5QBY=; b=LUOKRbXle4SvUCFkqJjI1snud0
 h1uGsLxKsRC9NajKTQkhm8Q/I5qxfFR7oHjfPRb1lgnZUG/O9ry/bI9kXLRZ67kcF9PvjbfYUxBNh
 +WDw2dnYqT+Ny9DOyiC9xGIxIJyeSM0NDx7awCOHIrAhwTutdb/eIyhWADpNd8Hra8c8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kwmt/CmpLnrqG0C6TaQUHP9mSrd7dijmNhSSbrv5QBY=; b=bCY+DU3Er7pTrARYx4Q6zdsKu4
 f1rmcK2YhkS6eeVd77jKg2MSD1ZHDojiMxdJm8fDwdkqZVJbasfb5iM/je4mJQc/pG53OQbXmMxly
 ipNGGXMYv5TGBTcnDuWyO3ugU+Ri9qQCcmH3+PqrQu65Sj5FHUQ4l+ry78aqSfeSxON8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1QdW-0004NX-E3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 15:43:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBC756025F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 15:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10AB1F000E9;
 Tue,  1 Sep 2026 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788277372;
 bh=kwmt/CmpLnrqG0C6TaQUHP9mSrd7dijmNhSSbrv5QBY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UgXsbapBP/AAW22n9gu40jvjps/Dn8xLvmhlVFxPW85tSuKc/4PPWkZZtJXWH7whC
 hnndx/4KyLdzhTeEaOYYljBALNvtYoGK8UlX3S3m6JriAXo9ajiTFPHCr2PaOmU4Oh
 pblvDFLEEAZQRB/QL5/3VNqi5uDwYrsVc/pC0vfy5kj/87Ihd6qVT9Bn/xpAIbNsl/
 Jifs33I6hnycFp4GjcQsSZEVlS1X31fOdiWnBs2rWRWdX2TXKpB6T/KSU2FWpdhaVB
 RlI5QaI/EJ9PAZLBUncPVGb/TLjWzGivV/t5fIdKth1kjQ6h3Ur2tYxsAidgTRbQBR
 Wan2bv9loXLFg==
Date: Tue, 1 Sep 2026 23:42:44 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apbxt_WcZOYfmfd9@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <d8fb7f5c0d67cf01249e8fc4807e963cc1a353d0.1784949155.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d8fb7f5c0d67cf01249e8fc4807e963cc1a353d0.1784949155.git.asj@kernel.org>
X-Headers-End: 1x1QdW-0004NX-E3
Subject: Re: [f2fs-dev] [PATCH v8 04/13] fstests: add
 _require_fanotify_function
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

On Sat, Jul 25, 2026 at 03:39:01PM +0800, Anand Jain wrote:
> fanotify support may not be compiled into the kernel. Add
> _require_fanotify_function to skip tests when fanotify is disabled.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/rc | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 53e5d9d43af6..21b516accdf7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6329,6 +6329,13 @@ _require_max_file_range_blocks()
>  	esac
>  }
>  
> +_require_fanotify_function()
> +{
> +        if $FSNOTIFYWAIT_PROG 2>&1 | grep -q "Function not implemented"; then
> +                _notrun "Need CONFIG_FANOTIFY and CONFIG_FANOTIFY_ACCESS_PERMISSIONS to be enabled"
> +        fi

What happens if $FSNOTIFYWAIT_PROG fails with an error other than
'Function not implemented'?

Thanks,
Zorro

> +}
> +
>  _require_fanotify_ioerrors()
>  {
>  	local x
> -- 
> 2.43.0
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
