Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E99CD4855
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gI1V4cwEfqu6UfA7W5zeOFogrYurBaZJUWgmRi81m48=; b=djzpHJwBcYTo2UTRvsEVVHQUTW
	S2cBvuQGAtj/sR6HfYBbXEhYNFUy/hRJzWR8q3SiqkjDX2uvIFg7V+FHreVEGzBSAdUEtBtsHVOIk
	dsBQ0dUxYjhbRLPZk8fyhixJCtargeroDxczwHckOtrWP7pj7oQSG9mFA75wWUdtG8P4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhan-0005fi-Mj;
	Tue, 12 May 2026 07:31:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMham-0005fb-0X
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ita3d5CJVmYPF+eclMsnCvsqN2sPxc0IzPuSVfoqbk4=; b=JuQ8yvYHcdbZkv66J3GQxPESlo
 xuLfZPoyKcPrzjgsdJf1F9/7hVwm+0pg3+aWYDA48GtryUahsawepAPD4rtykODkKyM89xlzwlPt/
 ZtcdXksuLoJ2qcv/hHZXEGNrQ5XlTD8uaFO51L50NLqU1EuqOEURRYFnAmOXMi3oHVwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ita3d5CJVmYPF+eclMsnCvsqN2sPxc0IzPuSVfoqbk4=; b=gnEeScB9XYkRkNj9WsQucL7gWN
 b3Hj6f6QI4tz8piJykFfe2MGoqql5QckEqdo3It3ZylspQiqkiRHdnPeQXPXTbwjDkCSjzIyvgFv4
 KnDf1DiIn2hDHDIvDNyPziZshCyUg5fFSMbU68SiapbKA5hDje3HjDMuX30g0brbWQpc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhal-0002Ny-Qa for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:31:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D1996001A;
 Tue, 12 May 2026 07:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3FBC2BCB0;
 Tue, 12 May 2026 07:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778571097;
 bh=aowACr2p+6rSwpChoE3EadCBPCPgSF8E8psfVlXgrO8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gAiB8tFXXabdPEPYhwa+Fm9YFauBqF8VyymvDAAZmCoURFlvvPu6j0sz4KZ788AbA
 /Gilye7p4N5y9ZjRoSrFQ6s+fsXJaBGyl0DIg6af6KSVL52pIRTR4QBciuGyf4cE11
 H2ZLNauyCJw7sUXtWJPUlSY8C+xQSZQ+BLvRl3T6nGZyl3bJmm+w8TMzbUXKvLQq/d
 867M4z2uhgR5hdCFZzD5aMDreoTDa9a/idDEIGy972SC8TvrPs9rAgOOqsDOp6CIPd
 afxA9vC7uam6EfUpw1RehUPquNGm1COUq7xNl82JZuOUABbJMJoXu3JE4ABKO33E1I
 Huh7jhSU82cPw==
Message-ID: <88cdaac7-05a9-41a7-bae4-443db26b7082@kernel.org>
Date: Tue, 12 May 2026 16:31:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-9-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-9-hch@lst.de>
X-Headers-End: 1wMhal-0002Ny-Qa
Subject: Re: [f2fs-dev] [PATCH 08/12] swap,
 iomap: simplify iomap_swapfile_iter
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
From: Damien Le Moal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/12/26 14:35, Christoph Hellwig wrote:
> add_swap_extent already coalesces multiple extents, no need to duplicate
> that in the caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
