Return-Path: <SRS0=V0x5=GO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF764C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Jan 2021 19:50:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BEE22BF3;
	Mon, 11 Jan 2021 19:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BEE22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kz3DF-0005w9-Ra; Mon, 11 Jan 2021 19:50:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kz3DE-0005w2-DZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jan 2021 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ul3HkFx7rnE5NXGBoIk/mGiOW0W60Ed3Ugupx+slXWo=; b=fYOex3hedLQjC+ob3D7mQLnty/
 sVIYM7UTBq0zb5kiz7OiExG5qvXqKvbwY8LqZZNpmUjl5+02BZ8mTYpcnV46oyBZ1IbyPel7F479t
 8Nsr2ZCC/2pBZDMD3svnjt40QK2wy+aB2w3XdX3aiWP0wfaNUdr3p5pfAZI6WqbUi4WM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ul3HkFx7rnE5NXGBoIk/mGiOW0W60Ed3Ugupx+slXWo=; b=L2i5q8GuN065014czpFXZL0h1Q
 6LJcKtKUpMN9JW4nN4gg67ZLtKGYGjG9QjTAwGZI6GTfxMk8MENxyQ8Ngfc/AwhVc37At5UiCYZSS
 NT3LafxsyPD4ukzf6zkjWPdy4II6FU+rcU2zRuVR0CVCTvi0joSrwx5csf1neTBB4d6g=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kz3D5-001vMe-LI
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jan 2021 19:50:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0614B22BEF;
 Mon, 11 Jan 2021 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610394629;
 bh=TKB/HnyGkf9UFm9NR/3BttEtk/tszaUH5WZ2/H0H1lU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m4gqn+mXwYxCAS6/xTYdzruo7QoknLSjAmGIppZ+evtXmbHvhh0iA5LTXjTPiaPFS
 usyjcJJU6it4DZACHXghcAR4uGoUK4KGA8f6tvgGgHAbfqaVH+0Dzcl5GLCgVItq39
 oplzpqms5sfjB8gtZb/clVe1D+93CqcZwbLH3iT2/ZbJbauAtNiAAeY5WH89Eo1SlP
 T6eZ3vyGEU9JiMVr59ZzArKNKHNuJgNm3X/VKbSeJlTOxlX3qwejyUOJ2JSynJQ1il
 8WPYmluN055p6mj+TjN1avqozbCl1YGDv894Ylp3KtTK6Br83jCBWoGMDPxpxG9+Zd
 htCAc3VlPQinw==
Date: Mon, 11 Jan 2021 11:50:27 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <X/ysA8PuJ/+JXQYL@sol.localdomain>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-5-ebiggers@kernel.org>
 <20210111105201.GB2502@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210111105201.GB2502@lst.de>
X-Headers-End: 1kz3D5-001vMe-LI
Subject: Re: [f2fs-dev] [PATCH v2 04/12] fat: only specify I_DIRTY_TIME when
 needed in fat_update_time()
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
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 11, 2021 at 11:52:01AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 08, 2021 at 11:58:55PM -0800, Eric Biggers wrote:
> > +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > +		dirty_flags |= I_DIRTY_SYNC;
> 
> fat does not support i_version updates, so this bit can be skipped.

Is that really the case?  Any filesystem (including fat) can be mounted with
"iversion", which causes SB_I_VERSION to be set.

A lot of filesystems (including fat) don't store i_version to disk, but it looks
like it will still get updated in-memory.  Could anything be relying on that?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
