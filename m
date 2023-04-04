Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478B0C761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 23:26:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjq2j-0004vQ-G8;
	Tue, 04 Apr 2023 23:26:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1pjq2h-0004vK-9o
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 23:26:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Swb8EXgBPUKvRLC5mU+M2nlIGbHnXhFBg+c3cHFfmls=; b=dqBwU1kd8JXqtWhiHqxgmuj6Za
 txrX7z7yMyQvYZgoA+2hs02ILjA46cl6C29knLKEGrCL9I6ysfaqYKDaeRSSWsOoCRqpMj7s0UvBb
 uFLc8DvMBGF8aRTDtv0m9GN2MaoUV174wUmilWEREdWcWEyn+iD8MTX5WFXgzMM+8xz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Swb8EXgBPUKvRLC5mU+M2nlIGbHnXhFBg+c3cHFfmls=; b=PCVwuCjT714GMTQtPKfzutv1+f
 VR1gA+/Xc7MX33rGoyxAJ+0g2PxiZObG7lGL8XEtgd0guods8VXSEfJ33/yC14Ve7+w+n9/OCKq+s
 5NacL8PHySCpFJB4a/hlVRjw45vDDg3c/S6Lh5q+HMHvFjaTVHTOQgSUYwiYq+BOeAX8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjq2g-0001yO-UT for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 23:26:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA0D63886;
 Tue,  4 Apr 2023 23:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20C1C433D2;
 Tue,  4 Apr 2023 23:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680650777;
 bh=/JyZmGk+myakLaCI1hhSwfIXR6hWB6PhXWV1RmrEmtQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SAMn41ZDLqNoE6Vm+Ws6NlgV5JNtcTsUfptIJYmSWkQXDoMlNthiN90l/6s3+s165
 zakb05T4J4axjmNGiNnSg/PLXu2mm3dIwNe0EsxcSRGtsA6eQKHcGUglH5oPWJiPln
 Dnh6qUYxcYXaByVI2SRX7KIUb5nJ3EW1SYPR/1H9VUb+ZU1nIskrAL356E3Fr1G3fL
 phSprFPiWpHqQwH9IaxCrGVhnGNlQ+9W281nygerSAi/jRifQP+6OPEKpbziDA2KNC
 ugBoZkZROddJxKcgQ9Fr3rXsP5BUTRC+q5V4S69CQ1Y9d015ztJzol3MHxJztXrSe+
 8F3ncUmDR1/ag==
Date: Tue, 4 Apr 2023 16:26:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <20230404232616.GE109960@frogsfrogsfrogs>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-6-zlang@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404171411.699655-6-zlang@kernel.org>
X-Headers-End: 1pjq2g-0001yO-UT
Subject: Re: [f2fs-dev] [PATCH 5/5] fstests/MAINTAINERS: add a co-maintainer
 for btrfs testing part
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
Cc: brauner@kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ebiggers@google.com, amir73il@gmail.com, linux-unionfs@vger.kernel.org,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, fdmanana@suse.com, ocfs2-devel@oss.oracle.com,
 jack@suse.com, linux-fsdevel@vger.kernel.org, anand.jain@oracle.com,
 ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 05, 2023 at 01:14:11AM +0800, Zorro Lang wrote:
> Darrick J. Wong would like to nominate Anand Jain to help more on

In case anyone's wondering how this all came about -- Anand asked me how
he could do more upstream fstests review work, so I suggested that he
and I talk to Zorro about delegating some of the review and maintainer
work so that it's not all on Zorro to keep everything running.

> btrfs testing part (tests/btrfs and common/btrfs). He would like to
> be a co-maintainer of btrfs part, will help to review and test
> fstests btrfs related patches, and I might merge from him if there's
> big patchset. So CC him besides send to fstests@ list, when you have
> a btrfs fstests patch.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Please btrfs list help to review this change, if you agree (or no objection),
> then I'll push this change.

This is what Zorro, Anand, and I sketched out as far as co-maintainer
resposibilities go:

> A co-maintainer will do:
> 1) Review patches are related with him.
> 2) Merge and test patches in his local git repo, and give the patch an ACK.
> 3) Maintainer will trust the ack from co-maintainer more (might merge directly).
> 4) Maintainer might merge from co-maintainer when he has a big patchset wait for
>    merging.
> 
> Thanks,
> Zorro
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ad12a38..9fc6c6b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -108,6 +108,7 @@ Maintainers List
>  	  or reviewer or co-maintainer can be in cc list.
>  
>  BTRFS
> +M:	Anand Jain <anand.jain@oracle.com>

I would like to hear agreement from the btrfs community about this
before making this particular change official.

--D

>  R:	Filipe Manana <fdmanana@suse.com>
>  L:	linux-btrfs@vger.kernel.org
>  S:	Supported
> -- 
> 2.39.2
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
