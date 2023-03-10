Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBBDC6FA99
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Mar 2023 22:23:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pal9Q-0000xp-LN;
	Fri, 10 Mar 2023 22:23:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pal9Q-0000xi-4e
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Mar 2023 22:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ncmBdmAMvcj/uZi34Lb3IyghLNAkHSkLQtORgbeiC/w=; b=mzYPNAu6NfN43iOovpb788BYJt
 degfjl0kTMfMMRzJm1iH2R0vrkRa/eKJhtbQpyWiyfXuf+xZdC1OoUfm63avyZp0kuUs1xIITbs6d
 Hu2/ngVA4ZAXaIo4MFzY5AckIIYSuj8RzqSgNhXOv+ouvYb1hjPDIDzzNJ4VBfbDa9s4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ncmBdmAMvcj/uZi34Lb3IyghLNAkHSkLQtORgbeiC/w=; b=iE3rjuvkj1MjFnqARY7g7E8X7f
 oUw00TU7oV8VrWet+quwKMJgn/z5v2PlKJHAHO9tF5XwKYo1heaReF9Df2hClC9OJz9wjxJ5fes7t
 PL8iuxgVp4T5R9dwUIkp8eVywVdS1WebNGSNSG7KxDJ1R19oXR0KdHLJuetLe0HMVzlY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pal9R-0002a9-Eo for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Mar 2023 22:23:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B617E61D5F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Mar 2023 22:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C91C433D2;
 Fri, 10 Mar 2023 22:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678487020;
 bh=pLqjpow77D3rK1zfQ77dw8Ngccz3kSkSYPNMZNpMVjU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UT0/bMjFlrjlkiV2/744VuhEOv9BfD2M601JNBZQkozKGguqNrsbtA/csCaFuSZbs
 C54u9+I9Dt2V6wi8zambw3KVl4Iwm8QmrNm5IWuwBKtoO0fpopThOt2P3iS7rr+lli
 S1DjzpCJBzMaAeamMkT6oi6+8Esk3tKpazUoQ+c6drSHuOLSRveHYGA7kijAmzJUFR
 Oe4nAgoMMblBLrDq2OyUTgRBNcBLKuJYST/+yC4GB3OTE13Fzc8QPX6d/oducrnTh/
 pWOLNUT3g/WOk34Sm6fLu/RAtGRrPfdzkAtK7XyABUP+pGUxR+WqkP14gkM8yRkXLm
 s6SlehA47exqg==
Date: Fri, 10 Mar 2023 14:23:38 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ZAut6jcnytFJAen9@sol.localdomain>
References: <20230310210454.2350881-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230310210454.2350881-1-jaegeuk@kernel.org>
X-Headers-End: 1pal9R-0002a9-Eo
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: factor out victim_entry usage from
 general rb_tree use
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Mar 10, 2023 at 01:04:52PM -0800, Jaegeuk Kim wrote:
> Let's reduce the complexity of mixed use of rb_tree in victim_entry from
> extent_cache and discard_cmd.
> 
> This should fix arm32 memory alignment issue caused by shared rb_entry.
> 
> [struct victim_entry]              [struct rb_entry]
> [0] struct rb_node rb_node;        [0] struct rb_node rb_node;
>                                        union {
>                                          struct {
>                                            unsigned int ofs;
>                                            unsigned int len;
>                                          };
> [16] unsigned long long mtime;     [12] unsigned long long key;
>                                        } __packed;
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Thanks for fixing this properly.  It looks much better than the weird type
punning that was being done before...

> +static struct rb_node **f2fs_lookup_rb_tree_ext(struct f2fs_sb_info *sbi,
> +				struct rb_root_cached *root,
> +				struct rb_node **parent,
> +				unsigned long long mtime, bool *leftmost)

Call this f2fs_lookup_victim_entry()?

> +static bool f2fs_check_victim_tree(struct f2fs_sb_info *sbi,
> +				struct rb_root_cached *root)
> +{
> +#ifdef CONFIG_F2FS_CHECK_FS
> +	struct rb_node *cur = rb_first_cached(root), *next;
> +	struct victim_entry *cur_ve, *next_ve;
> +
> +	if (!cur)
> +		return true;
> +
> +	while (cur) {

The !cur check is redundant.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
