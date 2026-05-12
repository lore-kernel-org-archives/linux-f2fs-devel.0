Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29978CD4F26
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNsuWOdaInQg4gD692+Y0qqCdTOINTyjlKXaHJruO8g=; b=RHoqRN3mGlqh5fYseitLkgz1p5
	lSec9g8yBt0z3Qet97SfZ4aqt4YWkLRQnFxBNbK7U5EcaWSeo75mvS9GG7VyzLQ5/7Obtxo1S7eth
	R0PevvEd220TX6qrqcWcwH+Dog4ofcLDAi/8DEAcGKwNd22uZCpZQwAeNRun+uk4+Exc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhOh-0003gS-5O;
	Tue, 12 May 2026 07:19:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhOf-0003gL-F5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6QE3ewrsfby/Z63hPdgzGnhMlX4OhV3m89/7+h7TDBU=; b=k/0/bozlQQ8ldzAF2FPyw0QLD2
 jaeIsedTYEHlG8t7846U3GmYCD+EKpU2WCJAsi55ZDC1Oka48rL4rPsMGSJ4QQ/Vd+6d/U/v5YL5o
 WkiPLRDfGs+AUG5t/tPWN2S1jQMH9pVCcWOD07KUiMdV6WQLDrVaib5zVVnP+eOtMdGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6QE3ewrsfby/Z63hPdgzGnhMlX4OhV3m89/7+h7TDBU=; b=MmhiTU3915IXiOFwxxNyyK9ZXm
 npxdfHCOQpfwcL8/UGakJmrWm0svuJR0ku/Unbd0zN5D4BzTb84iRhBN/eIL4UQ3ZzFCCDheg/iwO
 7GWEFhx8eR1rPln3lJytF+J8+HDdk+s2eWjNJjPcZRScPvrLiBmC/gBHwTLfFw2oy/Yc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhOc-0001Xy-TI for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:19:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 09D1643881;
 Tue, 12 May 2026 07:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9397DC2BCB0;
 Tue, 12 May 2026 07:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778570344;
 bh=d5SXioBPZwBUI6+SvSlauBL+rdn+SyAPRvBRa2uxfM8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rzpOZbhShhQy53uHWdXI2cpciYpCJ920LLOVTxryHf9v8OKxdXcXv9PcbtWsHhvyX
 AYph9XZFDOqDQwZsiKpkaAi5Tj4jgjyto4NZ8GZ1d1lrpRbMH6BEl1FmQDWqHh9aKt
 wR9hASUhwEfR/x7muZ/iQU+ZY4Unac7EpcjljUYFspFcTRdnBtE6xUk0dzsWRcdpwK
 N2xzyLJkDls7Vy9tVuzq9XXM2918R97/uSORI1dlwtkQ+yKrj8aK6cWW6NBweJ5PnN
 m3/udQQng+yYpR0EBFqLsp20DKAl82altPlAL8TvQYjfsAOHgqXK+IqxQKVepy1L7g
 Pst3cIKtZvjWQ==
Message-ID: <48752f6c-39ad-4409-9d41-646922a668cc@kernel.org>
Date: Tue, 12 May 2026 16:18:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-6-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-6-hch@lst.de>
X-Headers-End: 1wMhOc-0001Xy-TI
Subject: Re: [f2fs-dev] [PATCH 05/12] swap: cleanup setup_swap_extents
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
> Reflow setup_swap_extents so that the flag checking is not conditional on
> a swap_activate method.  This is currently a no-op because the swapoff
> code still checks the presence of a swap_deactivate method, but it
> simplifies adding a new check, and also makes the SWP_ACTIVATED flag
> more consistent.
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
