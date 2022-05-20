Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52859C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 May 2022 06:30:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrw9j-0007CW-7P; Fri, 20 May 2022 06:30:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nrw9P-0007CN-Q8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 May 2022 06:30:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fGHBYx9Z0kj8n/0d3//S1qbtfHPwJBgSjE1CmGWstqo=; b=PeFyn471d6k/Khv/6y0lrPeelL
 QF6sXMg57iV547YduXOGNYEJzKhoMcn4rulwJf/uST7bx9X+NBcVbk8Ghq/xna5kFdhGMq8l0NAb3
 lWkj7VB7rIjv46Go5i6kwu8dLzyWe1nFkAz0XfVsqiJ/IeblM8lQK6cYTLJxqC5aBAZg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fGHBYx9Z0kj8n/0d3//S1qbtfHPwJBgSjE1CmGWstqo=; b=TRd7xpcaRbm7wV8Y9uhSjOIUvn
 WfqHDzPR5F7RoobUR1/hN47ex2o+42c/upzISywdncy5UO7oRdcJK/4DYKY0IjmwGW3LbuBfQN75D
 kRaQreMOjj/pbx92QvjpfCntdh5ACH61S2WWrmClJDs30ij8RYXShF+JYXkHttZt8DxU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrw9M-00BxMv-H9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 May 2022 06:30:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B4AB2B82892
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 May 2022 06:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342CEC385A9;
 Fri, 20 May 2022 06:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653028204;
 bh=zLcVAySAGbHavOCyzZ3mHIX/dLccYG2RDrRrXi8XEwY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mIi0kfLHATOya+xGeR0ur/w+CnAM2SQc8hib3dEpvbOubRYGldcau8s/33XCt2s76
 SThI5nP5Bka/U8+8maJc8ic6ISPZUSR89qgmdoBjvGiqKfq7osmnUSaJHcB6JaG+kf
 KbTo0iwc3dep7dA/EntYOhibh5zEl3e1WihnZHvrlzXhxsrS7FoVV8b6UdpGBAyRFf
 Mgjw7EIhBzad06vU33Lx5bn2irSQTKaen9hMmsvds+j654UiaktBoZjKnKcWp+uVfB
 Vi6Px9ntf2zfzBRwDwtTs3Xltn/kmUYIPpa1ptWnO+w7PtNiWQmW0CZDuhK4HMXxOi
 7bR3YsuCNmwWQ==
Date: Thu, 19 May 2022 23:30:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <Yoc1asB6Ud4Su3gf@sol.localdomain>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YobNXbYnhBiqniTH@magnolia>
X-Headers-End: 1nrw9M-00BxMv-H9
Subject: Re: [f2fs-dev] [RFC PATCH v2 1/7] statx: add I/O alignment
 information
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 19, 2022 at 04:06:05PM -0700, Darrick J. Wong wrote:
> I guess that means for XFS it's effectively max(pagesize, i_blocksize,
> bdev io_opt, sb_width, and (pretend XFS can reflink the realtime volume)
> the rt extent size)?  I didn't see a manpage update for statx(2) but
> that's mostly what I'm interested in. :)

I'll send out a man page update with the next version.  I don't think there will
be much new information that isn't already included in this patchset, though.

> Looking ahead, it looks like the ext4/f2fs implementations only seem to
> be returning max(i_blocksize, bdev io_opt)?  But not the pagesize?

I think that's just an oversight.  ext4 and f2fs should round the value up to
PAGE_SIZE.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
