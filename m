Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C521C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 May 2023 00:19:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q0tHI-0003Lv-LH;
	Mon, 22 May 2023 00:19:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1q0tHH-0003Ln-Hv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 May 2023 00:19:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PlaJ8tgkqzd2AC75bYWzOXuIlemnk1JcYEE5wMJCYvU=; b=QFpsOq58c9UMQDQnmdVbM5/i06
 IRyn9kaE/UDDBhhIPtI+bDgm2FOaObPUE63znYVPRwdN8MUHFnwpQOCHIK0XcEqakdNhP8h2fMzM2
 LIczQmoQYNi1jlo2CfJUQz0tbrW8oPEGYHNopQyJHXkU5GBTClEEBhGb5zUOdsSDLdNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PlaJ8tgkqzd2AC75bYWzOXuIlemnk1JcYEE5wMJCYvU=; b=COp9VdFS0e8wI0asyK8Q7j/Q8H
 25rB6v/6cIG38B3yLxHb8O3nj4U1v9QRB2FyCtfQ9yI69+MSg3gjiNTNgxYJ2Fl29lTUW7Q+y27F3
 oLHxkCLcBNxdvixWQbstnZche3sdhhHsBAcu5yj7Hv+8ySu9CJJM6PItPM8al9kLNdfs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q0tHH-00FIKf-0d for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 May 2023 00:19:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A1D4D61026;
 Mon, 22 May 2023 00:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B75FC433EF;
 Mon, 22 May 2023 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684714789;
 bh=0wMqm8X8okr8bQlU0srLtMNQGV4Sb8jZambGxoRRwbI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q848JHFH/73MaEyiSlpI5u8Qqu1/UIV5YsfF5aB/NR6WP7Au6x2YNvKscJXaOkd2I
 9XL90qth2OHNf0eit4hRZXwPwLULA4TPuMzy4jgH6OxyZ5g2IcYtta/5hPRowDuqRX
 piMwelG30Y2EhWkWm2qtha8v1wcPJ/ThP3y7JL7ojmBWMfxyBeg88iGyOlKsJOSTOT
 UCKid+QFg00PeD+sx1RIqEDhkWfgZ+qnRjDHgTmuk5SXqDqpDqiAQEEvFFDeffQt4h
 wlw8aN2wcIajPm4Bwb+WnJcL8iE2xWhn5YGmZvRuo//g4DMQMlgEtxOgKRUV4KSaM7
 UqH5BaxAg1utQ==
Message-ID: <4ebd2eb4-04e3-8c41-0606-aa057f4d2e4b@kernel.org>
Date: Mon, 22 May 2023 09:19:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-13-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-13-hch@lst.de>
X-Headers-End: 1q0tHH-00FIKf-0d
Subject: Re: [f2fs-dev] [PATCH 12/13] fuse: drop redundant arguments to
 fuse_perform_write
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 cluster-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/19/23 18:35, Christoph Hellwig wrote:
> pos is always equal to iocb->ki_pos, and mapping is always equal to
> iocb->ki_filp->f_mapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
