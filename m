Return-Path: <SRS0=9BzI=ZE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68293C43331
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:33:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A65521783
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lgKxEniq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dYBQnwji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A65521783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iUWIw-0006sr-Qr; Tue, 12 Nov 2019 13:33:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack@suse.cz>) id 1iUWIv-0006sk-I6
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Nov 2019 13:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S7bsJ0K6QaxCs9zWo0tMApIINQNxVfMdR3H4C+Hpsdg=; b=lgKxEniqTJmF6WLned0lDFLmCg
 C84YZpdkxKI97sasExQpqQW6zA2+X8klQC4o1csfSeNt0pXaQaDBEbU7qvg8c+AIGsPJblocJ7yxY
 vfUSUBqiNjd8WNRtjljMh5T5DZ7AYCgvzv4iN74GDLP4zzG/MRyymst0B0JBjSVehKa0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S7bsJ0K6QaxCs9zWo0tMApIINQNxVfMdR3H4C+Hpsdg=; b=dYBQnwjiYm1Dxj2yK61IE1ldZ1
 faQFLEQkm4a52WAel0zxRz8JQIUoG/hopSfv2Nmw42nBlSrFdvQCiG5TFiqfixseBDvSyNhyb9dX3
 uQeazs7RHNeAw2uxIBNy41lGXO6Q0qukBU5Gy8k/2ntRCNhvGFu6/t3dxKubJRuf9bGU=;
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iUWIu-00DQQS-09
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Nov 2019 13:33:57 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 64721B213;
 Tue, 12 Nov 2019 13:33:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id AC6B71E4AD2; Tue, 12 Nov 2019 14:33:48 +0100 (CET)
Date: Tue, 12 Nov 2019 14:33:48 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20191112133348.GJ1241@quack2.suse.cz>
References: <20191112003452.4756-1-ira.weiny@intel.com>
 <20191112003452.4756-3-ira.weiny@intel.com>
 <20191111164320.80f814161469055b14f27045@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191111164320.80f814161469055b14f27045@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1iUWIu-00DQQS-09
Subject: Re: [f2fs-dev] [PATCH 2/2] fs: Move swap_[de]activate to
 file_operations
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
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>, Josef Bacik <josef@toxicpanda.com>,
 Anna Schumaker <anna.schumaker@netapp.com>, linux-xfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, ira.weiny@intel.com,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon 11-11-19 16:43:20, Andrew Morton wrote:
> On Mon, 11 Nov 2019 16:34:52 -0800 ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > swap_activate() and swap_deactivate() have nothing to do with
> > address spaces.  We want to eventually make the address space operations
> > dynamic to switch inode flags on the fly.
> 
> What does this mean?

See my reply to Christoph [1]. Ira wants to make switching inodes between
DAX and non-DAX mode work which means switching also
address_space_operations pointer in the mapping. 

								Honza

[1] lore.kernel.org/r/20191112133055.GI1241@quack2.suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
